#######
cluster_org = "starix"
cluster_env = "backup"

default_project = "tf-starix-backup"

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
          "values-starix-backup-atomix.yaml",
        ]
      }
      minio-operator = {
        namespace     = "minio"
        helm_path     = "minio/operator"
        chart_version = "6.0.4"
      }
      minio-bk = {
        helm_path     = "minio/tenant"
        chart_version = "6.0.4"
        value_files = [
          "values-starix-backup-minio-bk.yaml",
        ]
      }
      # minio-gitcache = {
      #   helm_path     = "minio/tenant"
      #   chart_version = "6.0.4"
      #   value_files = [
      #     "values-starix-backup-minio-gitcache.yaml",
      #   ]
      # }

      # NFS Storage Class
      nfs-provisioner = {
        namespace     = "nfs-provisioner"
        helm_path     = "nfs-subdir-external-provisioner"
        chart_version = "4.0.18"
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
