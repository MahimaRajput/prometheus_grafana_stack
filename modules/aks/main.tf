provider "azurerm"{
    features {
    }
}

resource "azurerm_resource_group" "prometheus" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_kubernetes_cluster" "promeaks" {
  resource_group_name = azurerm_resource_group.prometheus.name
  name                = var.aksname
  location            = var.location
  dns_prefix          = "promeaks"
  depends_on          = [azurerm_resource_group.prometheus]

  default_node_pool {
    name       = "default"
    vm_size    = var.nodesize
    node_count = 1
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "dev"
  }
}

locals {
  docker_compose_content = file("../../docker-compose.yaml")
}

# Copy manifest files and config file to the Kubernetes cluster
resource "null_resource" "copy_files_to_cluster" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../../manifests/alertmanager.yaml -f ../../manifests/grafana.yaml -f ../../manifests/node-exporter.yaml -f ../../manifests/prometheus.yaml && kubectl cp alertmanager-config.yml default/$(kubectl get pods -l app=alertmanager -o jsonpath='{.items[0].metadata.name}'):/etc/alertmanager/alertmanager.yml"
  }

   triggers = {
    manifest_files = "${filesha256("../../manifests/alertmanager.yaml")} ${filesha256("../../manifests/grafana.yaml")} ${filesha256("../../manifests/node-exporter.yaml")} ${filesha256("../../manifests/prometheus.yaml")} ${filesha256("alertmanager-config.yml")}"
  }
}
