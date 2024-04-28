# Configure the required providers, in this case, GitHub
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}


provider "github" {
  token = "ghp_lS9kd********************************"
  owner = "arq-tics-terraform"
}

# Create a GitHub membership resource for a specific user
resource "github_membership" "membership_for_user_x" {
  username = "anfsanchezcu"
  role     = "member"
}

# Define a repository for Terraform lab codebase with initial commit
resource "github_repository" "lab_terraform_codebase" {
  name               = "lab-terraform-codebase"
  description        = "My awesome codebase"
  visibility         = "public"
  auto_init          = true
  allow_update_branch = true
}

# Define a repository for Terraform lab webpage with GitHub Pages enabled
resource "github_repository" "lab_terraform_webpage" {
  name        = "lab-terraform-webpage"
  description = "My awesome webpage"
  visibility  = "public"
  auto_init   = true

  pages {
    source {
      branch = "main"
      path   = "/docs"
    }
  }
}

# Create multiple branches for the codebase repository
resource "github_branch" "development_branch_codebase" {
  repository = github_repository.lab_terraform_codebase.name
  branch     = "development"
  depends_on = [github_repository.lab_terraform_codebase]
}

resource "github_branch" "feature_branch_codebase" {
  repository = github_repository.lab_terraform_codebase.name
  branch     = "feature"
  depends_on = [github_repository.lab_terraform_codebase]
}

resource "github_branch" "release_branch_codebase" {
  repository = github_repository.lab_terraform_codebase.name
  branch     = "release"
  depends_on = [github_repository.lab_terraform_codebase]
}

# Create multiple branches for the webpage repository
resource "github_branch" "development_branch_webpage" {
  repository = github_repository.lab_terraform_webpage.name
  branch     = "development"
  depends_on = [github_repository.lab_terraform_webpage]
}

resource "github_branch" "feature_branch_webpage" {
  repository = github_repository.lab_terraform_webpage.name
  branch     = "feature"
  depends_on = [github_repository.lab_terraform_webpage]
}

resource "github_branch" "release_branch_webpage" {
  repository = github_repository.lab_terraform_webpage.name
  branch     = "release"
  depends_on = [github_repository.lab_terraform_webpage]
}
