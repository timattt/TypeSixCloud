resource "yandex_kubernetes_cluster" "type-6-k8s" {
  network_id = yandex_vpc_network.type-6-net.id
  master {
    version = "1.28"
    zonal {
      zone      = yandex_vpc_subnet.type-6-subnet.zone
      subnet_id = yandex_vpc_subnet.type-6-subnet.id
    }
    security_group_ids = [yandex_vpc_security_group.k8s-public-services.id]
  }
  service_account_id      = yandex_iam_service_account.k8s-account.id
  node_service_account_id = yandex_iam_service_account.k8s-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

resource "yandex_kubernetes_node_group" "type-node-group" {
  cluster_id = yandex_kubernetes_cluster.type-6-k8s.id
  count = 1
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  instance_template {

  }
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # A key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 year.
}

resource "yandex_vpc_security_group" "k8s-public-services" {
  name        = "k8s-public-services"
  description = "Group rules allow connections to services from the internet. Apply the rules only for node groups."
  network_id  = yandex_vpc_network.type-6-net.id
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
    from_port         = 30000
    to_port           = 32767
  }
  egress {
    protocol          = "ANY"
    description       = "The rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Yandex Object Storage, Docker Hub, and so on."
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}

resource "yandex_iam_service_account" "k8s-account" {
  name        = "k8s-account"
  description = "K8S zonal service account"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # The service account is assigned the k8s.clusters.agent role.
  folder_id = var.type-6-folder-id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # The service account is assigned the vpc.publicAdmin role.
  folder_id = var.type-6-folder-id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # The service account is assigned the container-registry.images.puller role.
  folder_id = var.type-6-folder-id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "viewer" {
  folder_id = var.type-6-folder-id
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}
