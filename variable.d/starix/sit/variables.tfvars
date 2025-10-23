######
cluster_org = "starix"
cluster_env = "sit"

default_project = "tf-starix-sit"

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
          "values-starix-sit-atomix.yaml",
        ]
      }
      # kubernetes-etcd-backup = {
      #   namespace     = "etcd-backup"
      #   helm_path     = "kubernetes-etcd-backup"
      #   chart_version = "1.0.0"
      #   skip_crds     = true
      #   value_files = ["values-starix-local-atomix.yaml"]
      # }

      velero = {
        namespace     = "velero"
        helm_path     = "velero"
        chart_version = "1.14.1"
        skip_crds     = false
        value_files   = ["values-starix-sit-atomix.yaml"]
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
