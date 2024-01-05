terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token = "t1.9euelZrHz8yZiYmZypzLjIzHxo-Uju3rnpWazZiKypiTkJjHiZLNnJSekcvl8_djHR9T-e8nLj0__t3z9yNMHFP57ycuPT_-zef1656VmpKNkpWZio2LiY6NzMbMxpPH7_zF656VmpKNkpWZio2LiY6NzMbMxpPH.NVgf6lDPP3-u1jJbGD4ghQTIwiz2iwsfeh6pqyvUiaKocALO5dew6v9Ukx78wgIxADXw0C0CTY8oVFCPGVI2CQ"
  # other variant of auth
  #service_account_key_file = "authorized_key.json"
  cloud_id                 = var.type-6-cloud-id
  folder_id                = var.type-6-folder-id
  zone                     = "ru-central1-a"
}