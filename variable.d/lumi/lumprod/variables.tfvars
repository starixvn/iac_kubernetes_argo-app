#########
cluster_org = "lumi"
cluster_env = "lumprod"

default_project = "default"

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
      #   value_files = []                           # optional - values root path: helm-values/{helm_path}/
      #   skip_crds              = true                         # optional - default: false
      #   auto_sync              = true                         # optional - default: true
      # }

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

      #- Jaeger -##
      jaeger = {
        namespace     = "jaeger-sc"
        helm_path     = "jaeger/jaeger"
        chart_version = "1.53.0"
        value_files = [
          "values-lumi-lumprod-atomix.yaml"
        ]
      }
      jaeger-elasticsearch = {
        namespace     = "jaeger-sc"
        helm_path     = "jaeger/elasticsearch"
        chart_version = "8.14.3"
        value_files = [
          "values-lumi-lumprod-atomix.yaml"
        ]
      }

      #- Tolgee -#
      tolgee = {
        namespace     = "tolgee-sc"
        helm_path     = "tolgee"
        chart_version = "3.120.0"
        value_files = [
          "values-lumi-lumprod-atomix.yaml"
        ]
      }

      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-lumi-lumprod-atomix.yaml",
        ]
      }

      postgresql-sonar = {
        namespace     = "nexpe"
        helm_path     = "postgresql"
        chart_version = "12.8.1"
        value_files   = ["values-starix-lumprod-atomix.yaml"]
      }

      sentry-ovs = {
        namespace     = "sentry-sc-ovs"
        helm_path     = "sentry-selfhost"
        chart_version = "4.3.3"
        auto_sync     = false
        value_files   = ["values-starix-lumprod-lumi-ovs.yaml"]
        ######### trigger
      }

      openreplay = {
        helm_path     = "openreplay-stack"
        chart_version = "0.1.0"
        auto_sync     = false
        value_files   = ["values-lumi-lumprod-atomix.yaml"]
        ##trigger
      }
      nginx-ingress = {
        helm_path     = "nginx-ingress"
        chart_version = "1.13.0"
        auto_sync     = true
        value_files   = ["values-lumi-lumprod-atomix.yaml"]
      }

      vault-secrets-operator = {
        namespace     = "vault"
        helm_path     = "vault/vault-secrets-operator"
        chart_version = "0.10.0"
      }
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

      redis-operator = {
        namespace     = "redis-operator"
        helm_path     = "redis-operator/operator"
        chart_version = "0.22.1"
        auto_sync     = false
        skip_crds     = false
        value_files = ["values-starix-lumprod-atomix.yaml"]
      }
      redis-nexpe = {
        helm_path     = "redis-operator/replication-sentinel"
        chart_version = "1.0.0"
        skip_crds     = false
        auto_sync     = false
        value_files = [
          "values-starix-lumprod-atomix.yaml"
        ]
      }

    }
  }
}

argo_projects = {
  tf-lumi-lumprod = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-lumprod"
        server    = "https://kubernetes.default.svc"
        namespace = "*"
      }
    ]
  }
  tf-lumi-local = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-local"
        server    = "https://10.10.50.144:6443"
        namespace = "*"
      }
    ]
  }
  tf-lumi-sit = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-sit"
        server    = "https://sc-sit-apiserver.playonesit.com:16444"
        namespace = "*"
      }
    ]
  }
  tf-lumi-uat = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-uat"
        server    = "https://st-api-k3skluat.starixuat.com:26443"
        namespace = "*"
      }
    ]
  }
  tf-lumi-prod = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-prod"
        server    = "https://sc-api-klprod.starixplay.com:16443"
        namespace = "*"
      }
    ]
  }
  tf-lumi-sgprod = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-sgprod"
        server    = "https://F74006CA89D990C1B0BAF42607B51B47.gr7.ap-southeast-1.eks.amazonaws.com"
        namespace = "*"
      }
    ]
  }
  tf-lumi-sguat = {
    src_repo = ["*"]
    destinations = [
      {
        name      = "lumi-sguat"
        server    = "https://E6191EEBBB4840436E79DD857495912F.yl4.ap-southeast-1.eks.amazonaws.com"
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
    vault_path  = "automation/Kubernetes/argo-app/lumi"
    vault_field = "GIT_REPO_SSH_KEY"
    repo_url    = "git@gitlab.nexdev.net"
  }
}

# REQUIRED VARIABLE SET [argo_token]
vault_secrets = {
  argo_token = {
    mount = "nexops"
    path  = "automation/Kubernetes/argo-app/lumi"
    field = "ARGOCD_AUTH_TOKEN"
  }
}
