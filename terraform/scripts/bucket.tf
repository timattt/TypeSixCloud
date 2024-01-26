resource "yandex_iam_service_account" "bucket-service-account" {
  name = "bucket-service-account"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.type-6-folder-id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.bucket-service-account.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.bucket-service-account.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "type-6-logs-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "type-6-logs-bucket"
  anonymous_access_flags {
    read = true
    list = false
  }
}