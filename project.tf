resource "argocd_project" "this" {
  for_each = local.argo_projects
  metadata {
    name      = each.key
    namespace = "argocd"
  }

  spec {
    description = "Project Managed by TF"

    source_namespaces = ["*"]
    source_repos      = each.value.src_repo

    dynamic "destination" {
      for_each = each.value.destinations
      content {
        name      = destination.value.name
        server    = destination.value.server
        namespace = destination.value.namespace
      }
    }

    dynamic "cluster_resource_whitelist" {
      for_each = each.value.cluster_resource_whitelist
      content {
        group = cluster_resource_whitelist.value.group
        kind  = cluster_resource_whitelist.value.kind
      }
    }

  }
}
