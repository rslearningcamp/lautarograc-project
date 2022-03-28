# README

## How to use Docker

### Install Docker
- Download it at https://www.docker.com/products/docker-desktop

### Useful commands

- `docker-compose up --build` to run app locally at http://localhost:3000
- `docker compose run --rm test rspec` to run tests
- `docker compose run --rm development rake code_analysis` to run code analysis tools
- `docker compose run --rm development bundle install` to install gems
- `docker compose down -v` to delete all Docker containers and volumes
