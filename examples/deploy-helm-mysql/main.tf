provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "mysql" {
  #source  = "github.com/gitlawr/modules//webservice"
  source = "/Users/lawrence/Workspace/github.com/gitlawr/modules/mysql" 
 
  name      = "db-instance-1"
  namespace = "default"
  database = "test"
  username = "test"
  password = "test"
  init_db_script = "CREATE USER foo;"
}

