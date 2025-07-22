terraform {
  required_version = ">= 1.11.0"
  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.7.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.8.0"
    }
  }
  backend "s3" {}
}

provider "argocd" {
  server_addr = var.argo_controller_addr[var.cluster_org]
  auth_token  = data.vault_kv_secret_v2.secrets["argo_token"].data[lookup(var.vault_secrets["argo_token"], "field", "ARGOCD_AUTH_TOKEN")]
  insecure    = true
}
