###
cluster_org = "12b-tools"
cluster_env = "prod"

default_project = "tf-12b-tools-prod"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      # prometheus = {
      #   namespace     = "monitoring"
      #   helm_path     = "monitoring/kube-prometheus"
      #   chart_version = "9.5.11"
      #   skip_crds     = true
      #   value_files = [
      #     "values-global.yaml",
      #     "values-starix-dr-atomix.yaml",
      #   ]
      # }
      ingress = {
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
        value_files   = ["values-12b-tools-prod-atomix.yaml"]
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

