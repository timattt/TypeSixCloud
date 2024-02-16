resource "yandex_logging_group" "k8slog" {
  name             = "k8slog"
  folder_id        = var.type-6-folder-id
  retention_period = "1h"
  data_stream = ""
}