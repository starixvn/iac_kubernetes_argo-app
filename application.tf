# Multiple Application Sources with Helm value files from external Git repository
resource "argocd_application" "argo_app" {
  for_each = { for entry in local.applications : "${entry.app_name}" => entry }
  metadata {
    name      = each.key
    namespace = "argocd"
    labels = {
      name = each.key
      team = each.value.team
      env  = each.value.env
    }
  }

  validate = false

  spec {
    project = each.value.project
    source {
      repo_url        = var.helm_source_repo
      path            = each.value.helm_path
      target_revision = "HEAD"
      helm {
        release_name = each.key
        value_files  = each.value.value_files
        skip_crds    = each.value.skip_crds
      }
    }

    source {
      # path            = each.value.value_path
      repo_url        = var.helm_value_repo
      target_revision = "HEAD"
      ref             = "values"
    }

    destination {
      server    = lookup(lookup(var.kube_cluster_api, var.cluster_org, {}), var.cluster_env, "https://kubernetes.unknown.svc")
      namespace = each.value.namespace
    }


    sync_policy {
      dynamic "automated" {
        for_each = each.value.auto_sync ? [1] : []
        content {
          prune       = true
          self_heal   = true
          allow_empty = true
        }
      }
      sync_options = ["CreateNamespace=true"]
      retry {
        limit = "5"
        backoff {
          duration     = "5s"
          max_duration = "3m"
          factor       = "2"
        }
      }
    }
  }
}
