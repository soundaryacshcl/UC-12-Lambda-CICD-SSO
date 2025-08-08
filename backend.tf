terraform {
  backend "s3" {
    bucket         = "terraform-usecases-hcl-us-east"
    key            = "usecase12/terraform.tfstate"
    region         = "us-east-1"                
    #use_lockfile = true

  }
}
