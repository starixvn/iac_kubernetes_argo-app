#####
cluster_org = "lumi"
cluster_env = "local"

default_project = "tf-lumi-local"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      ## Prometheus
      # prometheus = {
      #   namespace     = "monitoring"
      #   helm_path     = "monitoring/kube-prometheus"
      #   chart_version = "9.5.11"
      #   skip_crds     = true
      #   value_files = [
      #     "values-global.yaml",
      #     "values-lumi-sit-atomix.yaml",
      #   ]
      # }
      opencost = {
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-lumi-local-atomix.yaml"]
        ### trigger
      }
    }
  }
}


# REQUIRED VARIABLE SET [argo_token]
vault_secrets = {
  argo_token = {
    mount = "nexops"
    path  = "automation/Kubernetes/argo-app/lumi"
    field = "ARGOCD_AUTH_TOKEN"
  }
}
