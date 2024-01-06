resource "yandex_vpc_address" "type-6-public-ip" {
  name = "type-6-ip"
  deletion_protection = true
  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}
resource "yandex_vpc_address" "type-7-public-ip" {
  name = "type-7-ip"
  deletion_protection = true
  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}