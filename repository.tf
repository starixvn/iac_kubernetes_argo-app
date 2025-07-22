resource "argocd_repository" "git_repos" {
  for_each        = var.argo_repositories
  repo            = each.value.repo_url
  username        = "git"
  ssh_private_key = data.vault_kv_secret_v2.git_repo_creds["${each.value.repo_cred}"].data[lookup(var.argo_repo_credentials["${each.value.repo_cred}"], "vault_field", "")]
  insecure        = true
}
