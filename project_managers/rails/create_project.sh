#!/bin/bash

function create_default_mode {
  echo 'Creating default mode'
  cp ./project_managers/rails/Dockerfile.default ./src/Dockerfile
  docker-compose -f ./src/docker-compose.yaml run --rm web_service rails new . --force
}

function create_api_mode {
  echo 'Creating api mode'
  cp ./project_managers/rails/Dockerfile.api ./src/Dockerfile
  docker-compose -f ./src/docker-compose.yaml run --rm web_service rails new . --api --force
}

case $1 in
  'default' ) create_default_mode ;;
  'api' ) create_api_mode ;;
  * ) echo 'ERROR: Something went wrong' ;;
esac
