###
cluster_org = "starix"
cluster_env = "k3sprod"

default_project = "tf-starix-k3sprod"

#HUB: nexhub.ops-klprod.gamora.prod/kbt/base

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
          "values-starix-k3sprod-atomix.yaml",
        ]
      }
      opencost = {
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-starix-k3sprod-atomix.yaml"]
        ## trigger
      }
      portainer = {
        namespace     = "portainer"
        helm_path     = "portainer"
        chart_version = "1.0.63"
        skip_crds     = true
      }
      haproxy-service = {
        namespace     = "haproxy-service-core"
        helm_path     = "haproxy-svc-tcp"
        chart_version = "2.1.4"
        auto_sync     = false
      }
      rancher = {
        namespace     = "rancher"
        helm_path     = "rancher"
        chart_version = "2.10.2"
      }

      #############
      #- Logging -#
      #############
      opsearch-operator = {
        namespace     = "logging"
        helm_path     = "logging/opensearch-operator"
        chart_version = "2.7.0"
      }
      opsearch = {
        namespace     = "logging"
        helm_path     = "logging/opensearch-cluster"
        chart_version = "3.0.0"
      }
      logstash = {
        namespace     = "logging"
        helm_path     = "logging/logstash"
        chart_version = "8.5.1"
        value_files = [
          "values-global.yaml",
          "values-starix-k3sprod-atomix.yaml",
        ]
      }
      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-starix-k3sprod-atomix.yaml",
        ]
      }
      fluentb-server = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-starix-k3sprod-fluentb-server.yaml",
        ]
      }
      #- Jaeger -#
      jaeger = {
        namespace     = "jaeger-sc"
        helm_path     = "jaeger/jaeger"
        chart_version = "1.53.0"
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
      }
      jaeger-elasticsearch = {
        namespace     = "jaeger-sc"
        helm_path     = "jaeger/elasticsearch"
        chart_version = "8.14.3"
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
      }
      #- Tolgee -#
      tolgee = {
        namespace     = "tolgee-sc"
        helm_path     = "tolgee"
        chart_version = "3.120.0"
        value_files = [
          "values-starix-k3sprod-lumi.yaml"
        ]
      }
      #- zabbix-server -##
      zabbix-server = {
        namespace     = "zabbix-server"
        helm_path     = "zabbix/zabbix-server"
        chart_version = "7.2.9"
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
      }
      ###### update rabbitmq
      rabbitmq = {
        namespace     = "rabbitmq-nap-alpha"
        helm_path     = "rabbitmq-cluster-operator"
        chart_version = "4.3.15"
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod.yaml"
        ]
      }
      mysql-operator = {
        helm_path     = "mysql-operator"
        chart_version = "0.6.3"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
      }
      grafana = {
        helm_path     = "grafana-grafana"
        chart_version = "8.4.8"
        auto_sync     = true
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
        # trigger install     
      }

      elasticsearch = {
        helm_path     = "elk/elasticsearch"
        chart_version = "8.5.1"
        auto_sync     = true
        value_files = [
          "values-starix-k3sprod-atomix.yaml"
        ]
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files   = ["values-starix-k3sprod-atomix.yaml"]
      }

      #- MinIO -#
      minio-operator = {
        namespace     = "minio"
        helm_path     = "minio/operator"
        chart_version = "6.0.4"
      }
      minio-oprelay = {
        helm_path     = "minio/tenant"
        chart_version = "6.0.4"
        value_files   = ["values-starix-k3sprod-minio-oprelay.yaml"]
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
        value_files   = ["values-starix-k3sprod-pioneers-cache.yaml"]
      }
      redis-alpha-state = {
        helm_path     = "redis-sentinels"
        chart_version = "18.17.0"
        auto_sync     = false
        value_files   = ["values-starix-k3sprod-pioneers-state.yaml"]
      }

      rds-opr-alpha-state = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-pioneers-state.yaml"
        ]
      }

      rds-opr-alpha-cache = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-pioneers-cache.yaml"
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
        value_files   = ["values-starix-k3sprod-omniflow-cache.yaml"]
        ###
      }

      rds-opr-nap = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-omniflow.yaml"
        ]
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
        value_files   = ["values-starix-k3sprod-wabisabi-cache.yaml"]
        ####
      }
      rabbitmq = {
        namespace     = "rabbitmq-fps"
        helm_path     = "rabbitmq-cluster-operator"
        chart_version = "4.3.15"
        auto_sync     = false
        skip_crds     = true
        value_files = [
          "values-fps-k3sprod.yaml"
        ]
      }
      logstash = {
        namespace     = "logging-fps"
        helm_path     = "logging/logstash"
        chart_version = "8.5.1"
        value_files = [
          "values-global.yaml",
          "values-starix-k3sprod-wabisabi.yaml",
        ]
      }
      opsearch = {
        namespace     = "logging-fps"
        helm_path     = "logging/opensearch-cluster"
        chart_version = "3.0.0"
      }

      rds-opr-fps = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-wabisabi.yaml"
        ]
        # trigger
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
        value_files   = ["values-starix-k3sprod-subarashi-cache.yaml"]
        ###
      }

      rds-opr-oddfeed = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-k3sprod-subarashi.yaml"
        ]
        # trigger
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
        value_files   = ["values-starix-k3sprod-lumi-ops-ingress.yaml"]
      }
      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
      }
      sentry = {
        helm_path     = "sentry-selfhost"
        chart_version = "26.6.0"
        auto_sync     = false
      }
      sentry-ovs = {
        namespace     = "sentry-sc-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3sprod-lumi-ovs.yaml"]
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

      # grafana = {
      #   helm_path     = "grafana-grafana"
      #   chart_version = "8.4.8"
      #   auto_sync     = true
      #   value_files = [
      #     "values-starix-k3sprod-lumi.yaml"
      #   ]
      #   # trigger install     
      # }

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
      sentry-ovs = {
        namespace     = "sentry-st-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-k3sprod-starix-ovs.yaml"]
        ######## trigger deploy sentry
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
