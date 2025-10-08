terraform {
  backend "s3" {
    region                      = "us-east-1"
    use_lockfile                = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    bucket                      = "investlab-terraform"
    key                         = "terraform.tfstate"
  }

  required_version = "~> 1.10"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.19"
    }
  }
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = var.kubernetes_host
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  token                  = var.kubernetes_token
}

# Helm Provider
provider "helm" {
  kubernetes {
    host                   = var.kubernetes_host
    cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
    token                  = var.kubernetes_token
  }
}

provider "kubectl" {
  host                   = var.kubernetes_host
  token                  = var.kubernetes_token
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  load_config_file       = false
}
