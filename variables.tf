variable "cluster_org" {
  description = "Cluster Organization"
  type        = string
}

variable "cluster_env" {
  description = "Cluster Environment"
  type        = string
}

variable "default_project" {
  description = "Argo Project Default for each Environment"
  type        = string
  default     = "default"
}

variable "helm_source_repo" {
  type    = string
  default = "git@gitlab.nexdev.net:NEXOPS/helm-charts/helm-nexops-tools.git"
}

variable "helm_value_repo" {
  type    = string
  default = "git@gitlab.nexdev.net:iac/kubernetes/argo-app.git"
}

variable "kube_cluster_api" {
  description = "Nested map of Cluster API: org > env > url"
  type        = map(map(string))
  default = {
    starix = {
      nexprod = "https://kubernetes.default.svc"
      local   = "https://10.17.200.90:6443"
      sit     = "https://st-api-sit.playonesit.com:16445"
      hrm     = "https://st-hrm-apiserver.starixplay.com:16445"
      k3ssit  = "https://starix-k3ssit-api.playonesit.com:16443"
      k3suat  = "https://st-api-k3skluat.starixuat.com:26443"
      k3sprod = "https://st-api-k3sklprod.starixplay.com:26443"
      backup  = "https://10.10.50.136:6443"
      testlab = "https://kubernetes.default.svc"
      kc      = "https://10.70.70.220:6443"
      k3sawx  = "https://10.18.200.78:6443"
      k3skc   = "https://10.70.70.70:6443"
      k3sdr   = "https://st-api-k3sdr.starixplay.com:26443"
      dr      = "https://st-api-dr.starixplay.com:16444"
      alphadr = "https://alp-api-dr.starixplay.com:16445"
    }
    lumi = {
      lumprod = "https://kubernetes.default.svc"
      local   = "https://10.10.50.144:6443"
      sit     = "https://sc-sit-apiserver.playonesit.com:16444"
      uat     = "https://sc-api-kluat.starixplay.com:16443"
      prod    = "https://sc-api-klprod.starixplay.com:16443"
      sgprod  = "https://F74006CA89D990C1B0BAF42607B51B47.gr7.ap-southeast-1.eks.amazonaws.com"
      sguat   = "https://E6191EEBBB4840436E79DD857495912F.yl4.ap-southeast-1.eks.amazonaws.com"
      dr      = "https://sc-api-dr.starixplay.com:16443"
      sgdr    = "https://B591EA77A7679676565B45BEF979F1A0.gr7.ap-southeast-1.eks.amazonaws.com"
    }
    "12b-tools" = {
      prod = "https://CAE3D73347B8A70FD5B1819202EDDB42.yl4.ap-northeast-1.eks.amazonaws.com"
    }
  }
}

variable "argo_controller_addr" {
  description = "Nested map of ArgoCD Server Addr: org > url"
  default = {
    starix      = "argocd.nexdev.net"
    lumi        = "argocd.lumigame.com"
    "12b-tools" = "argocd.nexdev.net"
  }
}

variable "argo_applications_by_team" {
  description = "ArgoCD Application Groups by Teams"
}

variable "argo_projects" {
  description = "Map of Argo CD projects"
  type = map(object({
    src_repo = optional(list(string), ["*"])
    destinations = list(object({
      name      = string
      server    = string
      namespace = string
    }))
    cluster_resource_whitelist = optional(list(object({
      group = string
      kind  = string
      })), [
      {
        group = "*"
        kind  = "*"
      }
    ])
  }))
  default = {}
}

variable "argo_repo_credentials" {
  description = "Map of Argo Repository Credential Objects"
  type = map(object({
    vault_mount = string
    vault_path  = string
    vault_field = string
    repo_url    = string
  }))
  default = {}
}

variable "argo_repositories" {
  description = "Map of Argo Repository Objects"
  type = map(object({
    repo_url  = string
    repo_cred = string
  }))
  default = {}
}


variable "vault_secrets" {
  description = "Map of Vault Secret Object"
  type = map(object({
    mount = string
    path  = string
    field = string
  }))
  default = {}
}
