####
cluster_org = "12b-tools"
cluster_env = "prod"

default_project              = "tf-12b-tools-prod"
default_argocd_app_namespace = "argocd-12b-tools"

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

      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
        value_files   = ["values-12b-tools-prod-atomix.yaml"]
      }

      haproxy-service = {
        namespace     = "haproxy-service-core"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
        value_files   = ["values-12b-tools-prod-atomix.yaml"]
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files   = ["values-12b-tools-prod-atomix.yaml"]
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

