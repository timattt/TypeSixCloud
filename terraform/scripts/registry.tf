resource "yandex_container_registry" "type-6-registry" {
  name = "type-6-registry"
  folder_id = var.type-6-folder-id
  labels = {
    my-label = "type-6"
  }
}