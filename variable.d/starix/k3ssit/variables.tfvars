########
cluster_org = "starix"
cluster_env = "k3ssit"

default_project = "tf-starix-k3ssit"
vault_addr      = "https://vault.nexdev.net"

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
      }
      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-starix-k3ssit-atomix.yaml",
        ]
      }
      rancher = {
        namespace     = "rancher"
        helm_path     = "rancher"
        chart_version = "2.10.2"
      }
    }
  }
  stx = {
    team_name = "starix"
    applications = {
      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
      }
    }
  }
  lui = {
    team_name = "lumi"
    applications = {
      ops-ingress = {
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
        value_files   = ["values-starix-k3ssit-lumi-ops-ingress.yaml"]
      }
      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
      }
      nats = {
        helm_path     = "nats"
        chart_version = "1.2.10"
      }
      nats-nui = {
        namespace     = "tf-lui-nats"
        helm_path     = "nats/nats-nui"
        chart_version = "0.1.3"
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
