#####
cluster_org = "lumi"
cluster_env = "uat"

default_project = "tf-lumi-uat"

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
      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-lumi-uat-atomix.yaml",
        ]
      }
      opencost = {
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-lumi-uat-atomix.yaml"]
        ### trigger
      }
      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
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
