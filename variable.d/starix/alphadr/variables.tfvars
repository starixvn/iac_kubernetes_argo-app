#####
cluster_org = "starix"
cluster_env = "alphadr"

default_project = "tf-starix-alphadr"

#HUB: nexhub.ops-dr.nebula.prod/kbt/base
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
          "values-alpha-dr-atomix.yaml",
        ]
      }
      opencost = {
        namespace     = "opencost"
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-alpha-dr-atomix.yaml"]
        ## trigger
      }
      ingress = {
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
      }
      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-starix-alphadr-atomix.yaml",
        ]
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

