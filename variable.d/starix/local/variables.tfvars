########
cluster_org = "starix"
cluster_env = "local"

default_project = "tf-starix-local"
vault_addr      = "https://vault.nexdev.net"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      falco = {
        helm_path     = "falco"
        chart_version = "6.0.2"
        auto_sync     = true
        value_files   = ["values-starix-local-atomix.yaml"]
      }
    }
  }
}


# REQUIRED VARIABLE SET [argo_token]
vault_secrets = {
  argo_token = {
    mount = "nexops"
    path  = "automation/Kubernetes/argo-app/starix"
    field = "ARGOCD_AUTH_TOKEN"
  }
}
