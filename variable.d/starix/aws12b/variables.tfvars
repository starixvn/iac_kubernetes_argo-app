#####
cluster_org = "starix"
cluster_env = "aws12b"

default_project = "tf-starix-aws12b"

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
        value_files   = ["values-starix-aws12b-atomix.yaml"]
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

