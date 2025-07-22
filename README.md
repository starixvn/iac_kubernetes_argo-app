# ArgoCD Application Management Infrastructure

This Terraform configuration manages ArgoCD applications and projects across multiple Kubernetes clusters. It provides a structured approach to deploying and managing applications using GitOps principles.

## Overview

This infrastructure code manages:
- ArgoCD Applications
- ArgoCD Projects
- Git Repository Credentials
- Vault Secret Integration

## Prerequisites

- Terraform >= 1.11.0
- Access to a Vault instance
- Git repositories with Helm charts
- ArgoCD installed in target clusters

## Required Providers

- ArgoCD Provider (~> 7.7.0)
- Vault Provider (~> 4.8.0)

## Structure

```plaintext
.
|— application.tf         # ArgoCD application definitions
|— helm-values/          # Helm chart values
|— locals.tf             # Local variables and data transformations
|— project.tf            # ArgoCD project configurations
|— provider.tf           # Provider configurations
|— repository.tf         # Git repository configurations
|— variables.tf          # Input variable definitions
|— vault-secret.tf       # Vault secret configurations
–— variable.d/           # Environment-specific variables
```

## Configuration

### Application Configuration

Applications are configured through variables with the following structure:

```hcl
argo_applications_by_team = {
  team_name = {
    applications = {
      app_name = {
        namespace     = "target-namespace"
        project      = "project-name"
        helm_path    = "charts/app"
        chart_version = "1.0.0"
        additional_value_files = []
        skip_crds    = true
        auto_sync    = true
      }
    }
  }
}
```

### Project Configuration

Projects are defined with these parameters:

```hcl
argo_projects = {
  project_name = {
    src_repo = ["*"]
    destinations = [{
      name      = "cluster-name"
      server    = "https://kubernetes.default.svc"
      namespace = "*"
    }]
  }
}
```

### Repository Configuration

Git repositories are configured with:

```hcl
argo_repositories = {
  repo_name = {
    repo_url  = "git@gitlab.example.com:org/repo.git"
    repo_cred = "git_credential_name"
  }
}
```

### Environment Variables

Environment-specific variables are stored in `variable.d/<org>/<env>/variables.tfvars` and include:
- Cluster-specific configurations
- Environment-specific tags
- Application versions
- Resource limits and requests

## Security

- Sensitive credentials are stored in Vault
- SSH keys for Git repositories are managed securely
- ArgoCD authentication tokens are retrieved from Vault
- All connections use secure protocols

## Maintenance

Remember to:
- Keep Helm chart versions updated
- Rotate credentials periodically
- Review and update resource whitelists as needed
- Maintain proper documentation for team-specific configurations

## Backend Configuration

This project uses an S3-compatible backend for storing Terraform state. The backend configuration is provided separately for each environment to maintain isolation and security.

## Contributing

1. Create a feature branch from main
2. Make your changes following the established patterns
3. Test your changes using `terraform plan`
4. Submit a merge request with a clear description of changes

## Support

For issues or questions, please contact the NexOps team.