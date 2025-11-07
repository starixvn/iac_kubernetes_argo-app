#####
cluster_org = "starix"
cluster_env = "k3sdr"

default_project = "tf-starix-k3sdr"

# Main Image Reg Addr: nexhub.ops-dr.nebula.prod/kbt/base

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files   = ["values-starix-k3sdr-atomix.yaml"]
      }

      haproxy-service = {
        namespace     = "haproxy-service-core"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
      }

      ingress = {
        namespace     = "haproxy-ingress"
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
      }

      rancher = {
        namespace     = "rancher"
        helm_path     = "rancher"
        chart_version = "2.10.2"
      }

      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = false
        value_files   = ["values-starix-k3sdr-atomix.yaml"]
      }

      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-starix.yaml"]
      }

      sentry-ovs = {
        namespace     = "sentry-st-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-starix-ovs.yaml"]
      }
    }
  }

  pier = {
    team_name = "pioneers"
    applications = {
      rds-opr-alpha-state = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sdr-pioneers-state.yaml"
        ]
      }

      rds-opr-alpha-cache = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sdr-pioneers-cache.yaml"
        ]
      }

    }
  }

  suba = {
    team_name = "subarashi"
    applications = {
      rds-opr-oddfeed = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sdr-subarashi.yaml"
        ]
        # trigger
      }

    }
  }


  was = {
    team_name = "wabisabi"
    applications = {

      # rabbitmq = {
      #   namespace     = "rabbitmq-fps"
      #   helm_path     = "rabbitmq-cluster-operator"
      #   chart_version = "4.3.15"
      #   auto_sync     = false
      #   skip_crds     = true
      #   value_files = [
      #     "values-fps-k3sprod.yaml"
      #   ]
      # }
      # logstash = {
      #   namespace     = "logging-fps"
      #   helm_path     = "logging/logstash"
      #   chart_version = "8.5.1"
      #   value_files = [
      #     "values-global.yaml",
      #     "values-starix-k3sprod-wabisabi.yaml",
      #   ]
      # }
      # opsearch = {
      #   namespace     = "logging-fps"
      #   helm_path     = "logging/opensearch-cluster"
      #   chart_version = "3.0.0"
      # }

      rds-opr-fps = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sdr-wabisabi.yaml"
        ]
      }

    }
  }


  lui = {
    team_name = "lumi"
    applications = {
      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-lumi.yaml"]
      }

      sentry-ovs = {
        namespace     = "sentry-sc-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-lumi-ovs.yaml"]
      }

      ops-ingress = {
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
        value_files   = ["values-starix-k3sdr-sc-ops-ingress.yaml"]
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

  omfl = {
    team_name = "omniflow"
    applications = {
      rds-opr-nap = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sdr-omniflow.yaml"
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

