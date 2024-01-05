resource "yandex_vpc_network" "type-6-net" {
  name = "type-6-net"
}

resource "yandex_vpc_subnet" "type-6-subnet" {
  name           = "type-6-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.type-6-net.id
  v4_cidr_blocks = ["10.5.0.0/24"]
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
}