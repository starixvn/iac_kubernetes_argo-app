####
cluster_org = "lumi"
cluster_env = "local"

default_project = "tf-lumi-local"

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
          "values-lumi-local-atomix.yaml",
        ]
      }
      kubescape-op = {
        namespace     = "kubescape"
        helm_path     = "kubescape/kubescape-operator"
        chart_version = "1.29.6"
        auto_sync     = false
      }
      vault-secrets-operator = {
        namespace     = "vault"
        helm_path     = "vault/vault-secrets-operator"
        chart_version = "0.10.0"
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
