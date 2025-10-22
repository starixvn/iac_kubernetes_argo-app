######
cluster_org = "starix"
cluster_env = "local"

default_project = "tf-starix-local"

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
          "values-starix-local-atomix.yaml",
        ]
      }
      kubernetes-etcd-backup = {
        namespace     = "etcd-backup"
        helm_path     = "kubernetes-etcd-backup"
        chart_version = "1.0.0"
        skip_crds     = true
        value_files = ["values-starix-local-atomix.yaml"]
      }
      # falco = {
      #   helm_path     = "falco"
      #   chart_version = "6.0.2"
      #   value_files   = ["values-starix-local-atomix.yaml"]
      # }
      
      kubescape-op = {
        namespace     = "kubescape"
        helm_path     = "kubescape/kubescape-operator"
        chart_version = "1.29.0"
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
    path  = "automation/Kubernetes/argo-app/starix"
    field = "ARGOCD_AUTH_TOKEN"
  }
}
