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
      opencost = {
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-starix-k3ssit-atomix.yaml"]
        ## trigger
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
      vault = {
        helm_path     = "vault"
        chart_version = "0.30.1"
        auto_sync     = false
      }
      vault-snap-agent = {
        namespace     = "tf-stx-vault"
        helm_path     = "vault/vault-raft-snapshot-agent"
        chart_version = "0.1.0"
      }

      redis-nap = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3ssit-omniflow.yaml"
        ]
      }

      haproxy-service = {
        namespace     = "haproxy-service"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
        value_files = [
          "values-starix-k3ssit-atomix.yaml"
        ]
      }

      sentry-ovs = {
        namespace     = "sentry-st-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3ssit-starix-ovs.yaml"]
        ######
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

      sentry = {
        helm_path     = "sentry-selfhost"
        chart_version = "26.6.0"
        auto_sync     = false
        value_files   = ["values-starix-k3ssit-lumi.yaml"]
        #trigger
      }

      sentry-ovs = {
        namespace     = "sentry-sc-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3ssit-lumi-ovs.yaml"]
        #####
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files = ["values-starix-k3ssit-atomix.yaml"]
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
