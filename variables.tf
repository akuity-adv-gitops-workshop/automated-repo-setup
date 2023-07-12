variable "deploy_pat" {
  type = string
}

variable "repos" {
  type = set(string)
  default = [
    "control-plane",
    "demo-app",
    "demo-app-deploy"
  ]
}