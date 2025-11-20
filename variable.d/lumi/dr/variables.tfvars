#####
cluster_org = "lumi"
cluster_env = "dr"

default_project = "tf-lumi-dr"

#HUB: lumhub.ops-dr.nebula.prod/kbt/base
# ARGO APPLICATIONS
argo_applications_by_team = {
  atx = {
    team_name = "atomix"
    applications = {
      prometheus = {
        namespace     = "monitoring"
        helm_path     = "monitoring/kube-prometheus"
        chart_version = "9.5.11"
        skip_crds     = true
        value_files = [
          "values-global.yaml",
          "values-lumi-dr-atomix.yaml",
        ]
      }

      opencost = {
        namespace     = "opencost"
        helm_path     = "opencost"
        chart_version = "2.1.9"
        value_files   = ["values-lumi-dr-atomix.yaml"]
        ## trigger
      }
      # kubernetes-etcd-backup = {
      #   namespace     = "etcd-backup"
      #   helm_path     = "kubernetes-etcd-backup"
      #   chart_version = "1.0.0"
      #   skip_crds     = true
      #   value_files = ["values-lumi-local-atomix.yaml"]
      # }
      # kubescape-op = {
      #   namespace     = "kubescape"
      #   helm_path     = "kubescape/kubescape-operator"
      #   chart_version = "1.29.6"
      #   auto_sync     = false
      # }
      # vault-secrets-operator = {
      #   namespace     = "vault"
      #   helm_path     = "vault/vault-secrets-operator"
      #   chart_version = "0.10.0"
      # }

      fluent-bit = {
        namespace     = "logging"
        helm_path     = "logging/fluent-bit"
        chart_version = "0.50.0"
        value_files = [
          "values-global.yaml",
          "values-lumi-dr-atomix.yaml",
        ]
      }

      # trivy-op = {
      #   namespace     = "trivy"
      #   helm_path     = "trivy-stack/trivy-operator"
      #   chart_version = "0.30.0"
      # }

      ingress = {
        namespace     = "haproxy-ingress"
        helm_path     = "kubernetes-ingress"
        chart_version = "1.43.0"
        auto_sync     = false
        skip_crds     = true
      }

      kubescape-op = {
        namespace     = "kubescape"
        helm_path     = "kubescape/kubescape-operator"
        chart_version = "1.29.6"
      }

    }
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
