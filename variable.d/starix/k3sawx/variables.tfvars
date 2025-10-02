#####
cluster_org = "starix"
cluster_env = "k3sawx"

default_project = "tf-starix-k3sawx"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      awx-operator = {
        namespace     = "awx"
        helm_path     = "awx-operator"
        chart_version = "3.1.0"
        auto_sync     = true
        value_files = [
          "values-starix-k3sawx-atomix.yaml"
        ]
        # trigger
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

