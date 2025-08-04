#####
cluster_org = "lumi"
cluster_env = "sit"

default_project = "tf-lumi-sit"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      ingress = {
        namespace     = "haproxy-ingress"
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
      }
      ## Prometheus
      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-lumi-sit-atomix.yaml",
        ]
      }
    }
  }
  # lui = {
  #   team_name = "lumi"
  #   applications = {
  #     harbor = {
  #       helm_path     = "registry/harbor"
  #       chart_version = "2.11.0"
  #       auto_sync     = false
  #     }
  #   }
  # }
}


# REQUIRED VARIABLE SET [argo_token]
vault_secrets = {
  argo_token = {
    mount = "nexops"
    path  = "automation/Kubernetes/argo-app/lumi"
    field = "ARGOCD_AUTH_TOKEN"
  }
}
