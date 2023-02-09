provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "webservice" {
  source  = "github.com/gitlawr/modules//webservice"
  
  name      = "myapp"
  namespace = "default"
  image     = "nginx"  
  cpu = "0.2"
  memory = "256Mi"
  env = {
    FOO = "BAR"
  }
}
