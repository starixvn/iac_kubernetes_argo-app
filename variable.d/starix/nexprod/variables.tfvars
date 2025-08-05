#####
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
      # redis-standalone = {
      #   helm_path     = "redis-standalone"
      #   chart_version = "18.17.0"
      #   value_files   = ["values-starix-nexprod-wabisabi.yaml"]
      # }

      redis-was-custom = {
        helm_path     = "redis-was-custom"
        chart_version = "18.17.0"
        value_files   = ["values-starix-nexprod-wabisabi.yaml"]
        # trigger
      }

      opencost = {
        helm_path     = "opencost"
        chart_version = "1.115.0"
        value_files   = ["values-starix-nexprod-atomix.yaml"]
        # trigger
      }

      postgresql-sonar = {
        helm_path     = "postgresql"
        chart_version = "12.8.1"
        value_files   = ["values-starix-nexprod-atomix.yaml"]
        # trigger
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
