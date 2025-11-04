#####
cluster_org = "starix"
cluster_env = "dr"

default_project = "tf-starix-dr"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-starix-dr-atomix.yaml",
         ]
       }
      ingress-nap = {
        namespace     = "ingress-nap"
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
        value_files = ["values-starix-napdr-atomix.yaml"]
      }

      ingress-fps = {
        namespace     = "ingress-fps"
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
        value_files = ["values-starix-fpsdr-atomix.yaml"]
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

