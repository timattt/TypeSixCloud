#
# POSTGRES CLUSTER
#
resource "yandex_mdb_postgresql_cluster" "type-6-postgres-cluster" {
  name                = "type-6-cluster"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.type-6-net.id
  security_group_ids  = [ yandex_vpc_security_group.type-6-security-group.id ]

  config {
    version = 16
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "20"
    }
  }

  host {
    zone      = "ru-central1-a"
    name      = "type-6-postgres-cluster-host-a"
    subnet_id = yandex_vpc_subnet.type-6-subnet.id
  }
}

#
# DATABASE
#
resource "yandex_mdb_postgresql_database" "type-6-database" {
  cluster_id = yandex_mdb_postgresql_cluster.type-6-postgres-cluster.id
  name       = "type-6-database"
  owner      = "default-user"
}

#
# USER AND PASSWORD
#
resource "yandex_mdb_postgresql_user" "default-user" {
  cluster_id = yandex_mdb_postgresql_cluster.type-6-postgres-cluster.id
  name       = "default-user"
  password   = var.type-6-db-password
}
