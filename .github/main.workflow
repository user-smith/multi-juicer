workflow "Build docker image" {
  resolves = ["GitHub Action for Docker"]
  on = "push"
}

action "Build Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "build -t docker.pkg.github.com/j12934/juice-balancer-v2/balancer ."
}

action "Login to Docker Registry" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["GitHub Action for Docker"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    DOCKER_REGISTRY_URL = "docker.pkg.github.com"
  }
}

action "Push Image" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Docker Registry"]
  args = "push docker.pkg.github.com/j12934/juice-balancer-v2/balancer"
}