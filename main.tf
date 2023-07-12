# Create repos
resource "github_repository" "repos" {
  for_each    = var.repos
  name        = each.key
  description = "Akuity Adv. GitOps Workshop"

  visibility = "public"

  template {
    owner                = "akuity-adv-gitops-workshop"
    repository           = "${each.key}-template"
    include_all_branches = false
  }
}

# Add DEPLOY_PAT to GitHub Actions
resource "github_actions_secret" "deploy-pat" {
  for_each = var.repos

  repository      = github_repository.repos[each.key].name
  secret_name     = "DEPLOY_PAT"
  plaintext_value = var.deploy_pat
}

# Create release to show repo is ready.
# This triggers the update placeholders workflow to run and avoids issues
# where the Actions secret isn't available yet becuase the workflow ran
# too soon after repo creation.
resource "github_release" "setup-complete" {
  for_each = var.repos

  repository = github_repository.repos[each.key].name
  tag_name   = "setup-complete"
  prerelease = false
  draft      = false

  depends_on = [github_actions_secret.deploy-pat]
}