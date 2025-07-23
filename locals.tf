locals {
  # Argo Applications - Flatten
  applications = flatten([
    for team, team_details in var.argo_applications_by_team : [
      for app, app_details in team_details.applications : {
        app_name   = "${app}-${team}-${var.cluster_env}"
        team       = "${team_details.team_name}"
        env        = "${var.cluster_env}"
        namespace  = lookup(app_details, "namespace", "tf-${team}-${app}")
        project    = lookup(app_details, "project", var.default_project)
        helm_path  = "${app_details.helm_path}/${app_details.chart_version}"
        value_path = "Kubernetes/argo-app/helm-values/${app_details.helm_path}"
        value_files = length(lookup(app_details, "value_files", [])) > 0 ? [
          for file in app_details.value_files : "$values/helm-values/${app_details.helm_path}/${file}"
        ] : ["$values/helm-values/${app_details.helm_path}/values-${var.cluster_org}-${var.cluster_env}-${team_details.team_name}.yaml"]
        skip_crds = lookup(app_details, "skip_crds", false)
        auto_sync = lookup(app_details, "auto_sync", true)
      }
    ]
  ])


  # Argo Projects - Flatten
  argo_projects = {
    for proj_key, proj_val in var.argo_projects :
    proj_key => {
      proj_name    = proj_key
      src_repo     = proj_val.src_repo
      destinations = proj_val.destinations
      cluster_resource_whitelist = lookup(proj_val, "cluster_resource_whitelist", [
        {
          group = "*"
          kind  = "*"
        }
      ])
    }
  }

}
