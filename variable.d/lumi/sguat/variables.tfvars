######
cluster_org = "lumi"
cluster_env = "sguat"

default_project = "tf-lumi-sguat"

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
        value_files = [
          "values-lumi-sguat-atomix.yaml"
        ]
        ## trigger
      }

      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = false
        value_files = [
          "values-global.yaml",
          "values-lumi-sguat-atomix.yaml"
        ]
      }

      velero = {
        namespace     = "velero"
        helm_path     = "velero"
        chart_version = "1.14.1"
        skip_crds     = false
        value_files   = ["values-starix-sguat-atomix.yaml"]
        #trigger
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
