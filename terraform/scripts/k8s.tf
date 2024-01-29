resource "yandex_kubernetes_cluster" "type-6-k8s" {
  network_id = yandex_vpc_network.type-6-net.id
  name = "type-6-k8s"
  master {
    version = "1.28"
    public_ip = true
    zonal {
      zone      = yandex_vpc_subnet.type-6-subnet.zone
      subnet_id = yandex_vpc_subnet.type-6-subnet.id
    }
    security_group_ids = [yandex_vpc_security_group.type-6-security-group.id]
  }
  service_account_id      = yandex_iam_service_account.k8s-account.id
  node_service_account_id = yandex_iam_service_account.k8s-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

resource "yandex_kubernetes_node_group" "type-node-group" {
  cluster_id = yandex_kubernetes_cluster.type-6-k8s.id
  count = 1
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  instance_template {

  }
}

resource "yandex_kubernetes_node_group" "type-node-group-scaled" {
  cluster_id = yandex_kubernetes_cluster.type-6-k8s.id
  count = 1
  scale_policy {
    auto_scale {
      initial = 1
      max     = 3
      min     = 1
    }
  }
  instance_template {

  }
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # A key for encrypting critical information, including passwords, OAuth tokens, and SSH keys.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 year.
}

resource "yandex_iam_service_account" "k8s-account" {
  name        = "k8s-account"
  description = "K8S zonal service account"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # The service account is assigned the k8s.clusters.agent role.
  folder_id = var.type-6-folder-id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # The service account is assigned the vpc.publicAdmin role.
  folder_id = var.type-6-folder-id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # The service account is assigned the container-registry.images.puller role.
  folder_id = var.type-6-folder-id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "viewer" {
  folder_id = var.type-6-folder-id
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "load-balancer-admin" {
  folder_id = var.type-6-folder-id
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-account.id}"
}
