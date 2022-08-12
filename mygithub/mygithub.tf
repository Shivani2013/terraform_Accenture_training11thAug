terraform {
required_providers {
github = {
      source = "integrations/github"
      version = "4.3.2"
    }
}
}

provider "github" {
token = "****************************"
}

resource "github_repository" "examplerepo" {
  name = "terraform_Accenture_training11thAug"
  visibility = "public"
}

resource "github_branch" "dev" {
  repository = "terraform_Accenture_training11thAug"
  branch = "dev"
}

