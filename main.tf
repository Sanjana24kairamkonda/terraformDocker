terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Pull the latest NGINX image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create a container from the NGINX image
resource "docker_container" "web" {
  name  = "terraform-nginx"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }
}

output "web_address" {
  value = "http://localhost:8080"
}

