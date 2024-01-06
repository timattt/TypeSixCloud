terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token = var.type-6-token
  # other variant of auth
  #service_account_key_file = "authorized_key.json"
  cloud_id                 = var.type-6-cloud-id
  folder_id                = var.type-6-folder-id
  zone                     = "ru-central1-a"
}