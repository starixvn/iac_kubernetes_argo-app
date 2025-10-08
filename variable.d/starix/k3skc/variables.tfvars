#####
cluster_org = "starix"
cluster_env = "k3skc"

default_project = "tf-starix-k3skc"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      haproxy-service = {
        namespace     = "haproxy-service-core"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
        value_files = ["values-starix-k3skc-atomix.yaml"]
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files = ["values-starix-k3skc-atomix.yaml"]
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

