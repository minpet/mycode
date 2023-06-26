terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "simplegoservice" {
  name         = "registry.gitlab.com/alta3/simplegoservice"
  keep_locally = true       # keep image after "destroy"
}

resource "docker_container" "simplegoservice" {
  # use image created above
  image = docker_image.simplegoservice.image_id
  name  = var.container_name
  # expose port 80 on host port 2224
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}
