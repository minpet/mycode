# Peter
# purpose: spin up nginx as docker container; assumes docker is avaiable for current user

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true       # keep image after "destroy"
}

resource "docker_container" "nginx" {
  # use image created above
  image = docker_image.nginx.image_id
  name  = "tutorial"
  # expose port 80 on host port 2224
  ports {
    internal = 80
    external = 2224
  }
}
