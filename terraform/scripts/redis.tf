resource "yandex_mdb_redis_cluster" "type-6-redis" {
  name                = "type-6-redis"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.type-6-net.id
  security_group_ids  = [ yandex_vpc_security_group.type-6-security-group.id ]
  tls_enabled         = true

  config {
    password = var.type-6-redis-password
    version  = "7.0"
  }

  resources {
    resource_preset_id = "b3-c1-m4"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  host {
    zone             = "ru-central1-a"
    subnet_id        = yandex_vpc_subnet.type-6-subnet.id
    assign_public_ip = true
    replica_priority = 50
  }
}