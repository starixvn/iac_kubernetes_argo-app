#####
cluster_org = "starix"
cluster_env = "k3sdr"

default_project = "tf-starix-k3sdr"

# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      # haproxy-service = {
      #   namespace     = "haproxy-service-core"
      #   helm_path     = "haproxy-svc-tcp"
      #   chart_version = "2.1.4"
      #   auto_sync     = false
      #   value_files = ["values-starix-k3sdr-atomix.yaml"]
      # }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files = ["values-starix-k3sdr-atomix.yaml"]
      }

      # redis-kc-replication = {
      #   namespace     = "redis-kc"
      #   helm_path     = "redis-operator/replication"
      #   chart_version = "0.16.9"
      #   auto_sync     = false
      #   skip_crds     = true
      #   value_files = ["values-starix-k3skc-atomix.yaml"]
      # }

      # redis-kc-sentinel = {
      #   namespace     = "redis-kc"
      #   helm_path     = "redis-operator/sentinel"
      #   chart_version = "0.16.10"
      #   auto_sync     = false
      #   skip_crds     = true
      #   value_files = ["values-starix-k3skc-atomix.yaml"]
      # }

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
        skip_crds     = false
        value_files = ["values-starix-k3sdr-atomix.yaml"]
      }

      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-starix.yaml"]
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

  lui = {
    team_name = "lumi"
    applications = {
      harbor = {
        helm_path     = "registry/harbor"
        chart_version = "2.11.0"
        auto_sync     = false
        value_files   = ["values-starix-k3sdr-lumi.yaml"]
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

