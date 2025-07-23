###########
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
      #- Tolgee -#
      tolgee = {
        namespace     = "tolgee-sc"
        helm_path     = "tolgee"
        chart_version = "3.120.0"
        value_files = [
          "values-lumi-lumprod-atomix.yaml"
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
