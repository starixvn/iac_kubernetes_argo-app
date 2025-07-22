variable "vault_addr" {
  description = "Vault Addr Server to archive secrets"
  type        = string
  default     = "https://vault.nexdev.net"
}

provider "vault" {
  address          = var.vault_addr
  skip_child_token = true #https://stackoverflow.com/questions/73034161/permission-denied-on-vault-terraform-provider-token-creation
}

data "vault_kv_secret_v2" "git_repo_creds" {
  for_each = var.argo_repo_credentials
  mount    = each.value.vault_mount
  name     = each.value.vault_path
}

data "vault_kv_secret_v2" "secrets" {
  for_each = var.vault_secrets
  mount    = each.value.mount
  name     = each.value.path
}
