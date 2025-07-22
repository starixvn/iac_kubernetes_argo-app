resource "argocd_repository_credentials" "git_repo_creds" {
  for_each        = var.argo_repo_credentials
  url             = each.value.repo_url
  username        = "git"
  ssh_private_key = data.vault_kv_secret_v2.git_repo_creds["${each.key}"].data["${each.value.vault_field}"]
  depends_on      = [data.vault_kv_secret_v2.git_repo_creds]
}
