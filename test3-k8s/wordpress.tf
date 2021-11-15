data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "test-aks-cluster"
  resource_group_name = azurerm_resource_group.rg.name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)}"
#   load_config_file       = false
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name = "mysql"
    labels = {
      app = "mysql"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app  = "mysql",
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app  = "mysql",
          tier = "backend"
        }
      }

      spec {
        container {
          image = "mysql:5.6"
          name  = "mysql"

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "dkagh1."
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "wordpress_db"
          }
          env {
            name  = "MYSQL_USER"
            value = "wp-admin"
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = "dkagh1."
          }

          port {
            container_port = 3306
            name           = "mysql"
          }
          resources {
            limits = {
              cpu    = "500m"
              memory = "1000Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "service_mysql" {
  metadata {
    name = "mysql"
    labels = {
      app = "mysql"
    }
  }
  spec {
    selector = {
      app  = "mysql",
      tier = "backend"
    }
    port {
      port = 3306
    }
  }
}

resource "kubernetes_deployment" "wp" {
  metadata {
    name = "wordpress"
    labels = {
      app = "wordpress"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app  = "wordpress",
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app  = "wordpress",
          tier = "frontend"
        }
      }

      spec {
        container {
          image = "wordpress:5.5.3-apache"
          name  = "wordpress"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = "mysql"
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = "wordpress_db"
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = "wp-admin"
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = "dkagh1."
          }

          port {
            container_port = 80
            name           = "wordpress"
          }
          resources {
            limits = {
              cpu    = "500m"
              memory = "258Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_wp" {
  metadata {
    name = "wordpress"
    labels = {
      app = "wordpress"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app  = "wordpress",
      tier = "frontend"
    }
    port {
      port = 80
    }
  }
}
