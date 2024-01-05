output "postgres-cluster-id" {
  value       = yandex_mdb_postgresql_cluster.type-6-postgres-cluster.id
}
output "postgres-db-url" {
  value       = yandex_mdb_postgresql_database.type-6-database.name
}
output "k8s-master" {
  value       = yandex_kubernetes_cluster.type-6-k8s.master
}
output "k8s-description" {
  value       = yandex_kubernetes_cluster.type-6-k8s.description
}