workflow "Deploy on Heroku" {
  on = "push"
  resolves = [
    "verify-staging",
    "verify-production",
  ]
}

# Login
action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

# Push
action "push-staging" {
  needs = ["login"]
  uses = "actions/heroku@master"
  args = ["container:push", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-develop"
  }
}

# Release
action "release-staging" {
  needs = ["push-staging"]
  uses = "actions/heroku@master"
  args = ["container:release", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-develop"
  }
}

# Verify
action "verify-staging" {
  needs = ["release-staging"]
  uses = "actions/heroku@master"
  args = ["apps:info", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-develop"
  }
}

# Push to master
action "master-branch-filter" {
  needs = ["verify-staging"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "push-production" {
  needs = ["master-branch-filter"]
  uses = "actions/heroku@master"
  args = ["container:push", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-shopify"
  }
}

action "release-production" {
  needs = ["push-production"]
  uses = "actions/heroku@master"
  args = ["container:release", "--app", "$HEROKU_APP", "web"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-shopify"
  }
}

action "verify-production" {
  needs = ["release-production"]
  uses = "actions/heroku@master"
  args = ["apps:info", "$HEROKU_APP"]
  secrets = ["HEROKU_API_KEY"]
  env = {
    HEROKU_APP = "digital-climate-strike-shopify"
  }
}
