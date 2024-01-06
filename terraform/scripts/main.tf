resource "yandex_vpc_network" "type-6-net" {
  name = "type-6-net"
}

resource "yandex_vpc_subnet" "type-6-subnet" {
  name           = "type-6-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.type-6-net.id
  v4_cidr_blocks = ["10.5.0.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

#
# this is to ensure pods can load images from docker hub
#
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  name       = "test-route-table"
  network_id = yandex_vpc_network.type-6-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_security_group" "type-6-security-group" {
  name       = "type-6-security-group"
  network_id = yandex_vpc_network.type-6-net.id

  ingress {
    description    = "PostgreSQL"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    protocol          = "TCP"
    description       = "The rule allows availability checks from the load balancer address range. It is required for the operation of a fault-tolerant Managed Service for Kubernetes cluster and load balancer services."
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "The rule allows master-to-node and node-to-node communication inside a security group."
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "The rule allows pod-to-pod and service-to-service communication. Specify the subnets of your Managed Service for Kubernetes cluster and services."
    v4_cidr_blocks    = concat(yandex_vpc_subnet.type-6-subnet.v4_cidr_blocks)
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ICMP"
    description       = "Rule allows debugging ICMP packets from internal subnets."
    v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol          = "TCP"
    description       = "The rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
  egress {
    protocol          = "ANY"
    description       = "The rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Yandex Object Storage, Docker Hub, and so on."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}