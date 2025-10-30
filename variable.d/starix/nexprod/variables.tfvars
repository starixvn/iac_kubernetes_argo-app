###
cluster_org = "starix"
cluster_env = "nexprod"

default_project = "tf-starix-nexprod"
vault_addr      = "https://vault.nexdev.net"

argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      # # Monitoring Apps
      # prometheus = {
      #   namespace              = "monitoring"                 # optional - default: {app-name}
      #   project                = "tf-project"                 # optional - default: "default"
      #   helm_path              = "monitoring/kube-prometheus" # required
      #   chart_version          = "9.5.11"                     # required
      #   value_files            = []                           # optional - values root path: helm-values/{helm_path}/
      #   skip_crds              = true                         # optional - default: false
      #   auto_sync              = true                         # optional - default: true
      # }
      rancher = {
        namespace     = "rancher"
        helm_path     = "rancher"
        chart_version = "2.10.2"
      }

      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-starix-nexprod-atomix.yaml",
        ]
      }

      #############
      #- Logging -#
      #############
      opsearch = {
        namespace     = "logging"
        helm_path     = "logging/opensearch"
        chart_version = "2.34.0"
      }
      opsearch-dashb = {
        namespace     = "logging"
        helm_path     = "logging/opensearch-dashboards"
        chart_version = "2.30.0"
      }
      logstash = {
        namespace     = "logging"
        helm_path     = "logging/logstash"
        chart_version = "8.5.1"
        value_files = [
          "values-global.yaml",
          "values-starix-nexprod-atomix.yaml",
        ]
      }
      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-starix-nexprod-atomix.yaml",
        ]
      }

      vault-secrets-operator = {
        namespace     = "vault"
        helm_path     = "vault/vault-secrets-operator"
        chart_version = "0.10.0"
      }
      vault-dev = {
        namespace     = "vault-dev"
        helm_path     = "vault"
        chart_version = "0.30.1"
        auto_sync     = false
        value_files   = ["values-starix-nexprod-vaultdev.yaml", ]
      }
      vault-dev-snap-agent = {
        namespace     = "vault-dev"
        helm_path     = "vault/vault-raft-snapshot-agent"
        chart_version = "0.1.0"
        value_files   = ["values-starix-nexprod-vaultdev.yaml", ]
      }

      redis-standalone = {
        helm_path     = "redis-standalone"
        chart_version = "21.0.0"
        value_files   = ["values-starix-nexprod-wabisabi.yaml"]
      }

      redis-was-custom = {
        helm_path     = "redis-was-custom"
        chart_version = "18.17.0"
        value_files   = ["values-starix-nexprod-wabisabi.yaml"]
        # trigger
      }

      postgresql-sonar = {
        namespace     = "nexpe"
        helm_path     = "postgresql"
        chart_version = "12.8.1"
        value_files   = ["values-starix-nexprod-atomix.yaml"]
        # trigger
      }

      mysql-operator = {
        helm_path     = "mysql-operator"
        chart_version = "0.6.3"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-nexprod-atomix.yaml"
        ]
      }

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files   = ["values-starix-nexprod-atomix.yaml"]
      }

      redis-nap = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-nexprod-omniflow.yaml"
          #trigger
        ]
      }
      # 

      redis-alpha = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-nexprod-pioneers.yaml"
          #trigger
        ]
      }
      #
      redis-nexpe = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-nexprod-atomix.yaml"
        ]
      }
      #
      
      influxdb = {
        namespace     = "influxdb"
        helm_path     = "influxdb/influxdb2"
        chart_version = "2.1.2"
        value_files   = ["values-starix-nexprod-atomix.yaml"]
      }
    }
  }
  stx = {
    team_name = "starix"
    applications = {
      vault = {
        namespace     = "vault"
        helm_path     = "vault"
        chart_version = "0.30.1"
        auto_sync     = false
      }
      vault-snap-agent = {
        namespace     = "vault"
        helm_path     = "vault/vault-raft-snapshot-agent"
        chart_version = "0.1.0"
      }

      sentry-ovs = {
        namespace     = "sentry-st-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-nexprod-starix-ovs.yaml"]
      }

      grafana-mimir = {
        namespace     = "grafana-mimir"
        helm_path     = "monitoring/grafana-mimir"
        chart_version = "5.8.0"
        skip_crds     = false
        value_files   = ["values-starix-nexprod-starix.yaml"]
        ### trigger
      }
    }
  }
}

argo_projects = {
  tf-starix-backup = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-backup"
        server    = "https://10.10.50.136:6443"
        namespace = "*"
      }
    ]
  }
  tf-starix-nexprod = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-nexprod"
        server    = "https://kubernetes.default.svc"
        namespace = "*"
      }
    ]
  }
  tf-starix-k3ssit = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-k3ssit"
        server    = "https://starix-k3ssit-api.playonesit.com:16443"
        namespace = "*"
      }
    ]
  }
  tf-starix-k3suat = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-k3suat"
        server    = "https://st-api-k3skluat.starixuat.com:26443"
        namespace = "*"
      }
    ]
  }
  tf-starix-k3sprod = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-k3sprod"
        server    = "https://st-api-k3sklprod.starixplay.com:26443"
        namespace = "*"
      }
    ]
  }

  tf-starix-local = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-local"
        server    = "https://10.17.200.90:6443"
        namespace = "*"
      }
    ]
  }

  tf-starix-sit = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "starix-sit"
        server    = "https://st-api-sit.playonesit.com:16445"
        namespace = "*"
      }
    ]
  }

  tf-starix-k3sawx = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "k3s-awx"
        server    = "https://10.18.200.78:6443"
        namespace = "*"
        # trigger
      }
    ]
  }

  tf-starix-k3skc = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "k3s-kc-testlab"
        server    = "https://10.70.70.70:6443"
        namespace = "*"
        # trigger
      }
    ]
  }

}

# REQUIRED VARIABLE SET [git_helm_source,git_helm_value]
argo_repositories = {
  git_helm_source = {
    repo_url  = "git@gitlab.nexdev.net:NEXOPS/helm-charts/helm-nexops-tools.git"
    repo_cred = "git_credential_nexdev"
  }
  git_helm_value = {
    repo_url  = "git@gitlab.nexdev.net:iac/kubernetes/argo-app.git"
    repo_cred = "git_credential_nexdev"
  }
}

argo_repo_credentials = {
  git_credential_nexdev = {
    vault_mount = "nexops"
    vault_path  = "automation/Kubernetes/argo-app/starix"
    vault_field = "GIT_REPO_SSH_KEY"
    repo_url    = "git@gitlab.nexdev.net"
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
