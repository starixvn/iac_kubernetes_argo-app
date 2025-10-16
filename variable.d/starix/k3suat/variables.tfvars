#######
cluster_org = "starix"
cluster_env = "k3suat"

default_project = "tf-starix-k3suat"
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
        auto_sync     = false
        value_files = [
          "values-global.yaml",
          "values-starix-k3suat-atomix.yaml",
        ]
      }
      opencost = {
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-starix-k3suat-atomix.yaml"]
        ### trigger
      }

      rabbitmq = {
        helm_path     = "rabbitmq-cluster-operator"
        chart_version = "4.3.15"
        auto_sync     = false
        value_files   = ["values-starix-k3suat.yaml"]
      }

      haproxy-service = {
        namespace     = "haproxy-service-core"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
      }
      logstash = {
        namespace     = "logging"
        helm_path     = "logging/logstash"
        chart_version = "8.5.1"
        value_files = [
          "values-global.yaml",
          "values-starix-k3suat-atomix.yaml",
        ]
      }
      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-starix-k3suat-atomix.yaml",
        ]
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files = ["values-starix-k3suat-atomix.yaml"]
      }

    }
  }

  pier = {
    team_name = "pioneers"
    applications = {
      redis-alpha-cache = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-pioneers-cache.yaml"]
      }
      redis-alpha-state = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-pioneers-state.yaml"]
      }

      redis-alpha-pier-cache = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3suat-pioneers-cache.yaml"
        ]
      }

      redis-alpha-pier-state = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3suat-pioneers-state.yaml"
        ]
      }


    }
  }

  omfl = {
    team_name = "omniflow"
    applications = {
      redis-omniflow-cache = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-omniflow-cache.yaml"]
        ###
      }

      redis-nap = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3suat-omniflow.yaml"
        ]
      }

    }
  }

  suba = {
    team_name = "subarashi"
    applications = {
      redis-oddfeed-cache = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-subarashi-cache.yaml"]
        ###
      }
    }
  }

  was = {
    team_name = "wabisabi"
    applications = {
      redis-fps-cache = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-wabisabi-cache.yaml"]
        ####
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
        value_files   = ["values-starix-k3suat-lumi-ops-ingress.yaml"]
      }
      sentry = {
        helm_path     = "sentry-selfhost"
        chart_version = "26.6.0"
        auto_sync     = false
        #trigger
      }
      sentry-ovs = {
        namespace     = "sentry-sc-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-lumi-ovs.yaml"]
        #####
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

  stx = {
    team_name = "starix"
    applications = {
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
      sentry-ovs = {
        namespace     = "sentry-st-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3suat-starix-ovs.yaml"]
        ######## trigger deploy sentry
      }

      redis-was-custom = {
        helm_path     = "redis-was-custom"
        chart_version = "18.17.0"
        value_files   = ["values-starix-k3suat-wabisabi.yaml"]
        # trigger
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
