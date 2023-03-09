#!/bin/bash

echo "                   _                                                \n" \
     "   __ _ _ __   __| |_ __ ___   __ _ _   _ _ __   ___  _   _ ___     \n" \
     "  / _\` | '_ \ / _\` | '__/ _ \ / _\` | | | | '_ \ / _ \| | | / __| \n" \
     " | (_| | | | | (_| | | | (_) | (_| | |_| | | | | (_) | |_| \__ \    \n" \
     "  \__,_|_| |_|\__,_|_|  \___/ \__, |\__, |_| |_|\___/ \__,_|___/    \n" \
     "                              |___/ |___/                           \n"
echo "\033[0;33mCaution: Docker and DockerCompose needed to be installed beforehand.\033[0;39m"
echo '\n'

echo 'Which framework do you intend to use?'
echo '1. echo by Go'
echo '2. django by Python'
echo '3. flask by Python'
echo '4. bottle by Python'
echo '5. Laravel by PHP'
echo '6. Ruby on Rails by Ruby'
echo '7. Springboot by Java'
read framework

# Refresh workspace `src`
function refresh_workspace {
  rm -rf src
  mkdir src
}

function select_go_version {
  echo 'go versions'
  echo 'Docker image: golang:1.14.6'
}

function select_python_version {
  echo 'python versions'
  echo 'Docker image: python:3.8.12'
}

function select_php_version {
  echo 'php versions'
  echo 'Docker image: php:7.4-fpm'
}

function select_ruby_version {
  echo 'ruby versions'
  echo 'Docker image: ruby:3.1.0'
}

function select_java_version {
  echo 'java versions'
  echo 'Docker image: openjdk:11'
}

# Create echo project
function build_echo_project {
  echo 'Building echo project...'

  refresh_workspace

  echo 'Phase1: Getting ready for docker-compose build...'
  cp ./project_managers/echo/base.go ./src/main.go
  cp ./project_managers/echo/go.mod ./src/go.mod
  cp ./project_managers/echo/Dockerfile ./src/Dockerfile
  cp ./project_managers/echo/docker-compose.yaml ./src/docker-compose.yaml

  echo 'Phase2: DockerCompose building...'
  docker-compose -f ./src/docker-compose.yaml build

  echo 'Phase3: Go modules initialization...'
  docker-compose -f ./src/docker-compose.yaml run --rm web_service go mod init app
}
# Run echo project
function run_echo_project {
  echo 'Running echo project...'

  echo 'Phase4: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running echo project by daemon.'
  echo 'Visit localhost:8080 to see if the service is running.'
}

# Create Django project
function build_django_project {
  echo 'Building Django project...'

  refresh_workspace

  echo 'Phase1: DockerCompose building...'
  cp ./project_managers/django/Dockerfile ./src/Dockerfile
  cp ./project_managers/django/docker-compose.yaml ./src/docker-compose.yaml
  cp ./project_managers/django/requirements.txt ./src/requirements.txt
  docker-compose -f ./src/docker-compose.yaml run web_service django-admin startproject project .
}
# Run flask project
function run_django_project {
  echo 'Running Django project...'

  echo 'Phase2: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running Django project by daemon.'
  echo 'Visit localhost:8000 to see if the service is running.'
}

# Create flask project
function build_flask_project {
  echo 'Building flask project...'

  refresh_workspace

  echo 'Phase1: Getting ready for docker-compose build...'
  cp ./project_managers/flask/base.py ./src/app.py
  cp ./project_managers/flask/Dockerfile ./src/Dockerfile
  cp ./project_managers/flask/docker-compose.yaml ./src/docker-compose.yaml

  echo 'Phase2: DockerCompose building...'
  docker-compose -f ./src/docker-compose.yaml build
}
# Run flask project
function run_flask_project {
  echo 'Running flask project...'

  echo 'Phase3: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running flask project by daemon.'
  echo 'Visit localhost:5000 to see if the service is running.'
}

# Create bottle project
function build_bottle_project {
  echo 'Building bottle project...'

  refresh_workspace

  echo 'Phase1: Getting ready for docker-compose build...'
  cp ./project_managers/bottle/base.py ./src/app.py
  cp ./project_managers/bottle/Dockerfile ./src/Dockerfile
  cp ./project_managers/bottle/docker-compose.yaml ./src/docker-compose.yaml

  echo 'Phase2: DockerCompose building...'
  docker-compose -f ./src/docker-compose.yaml build
}
# Run bottle project
function run_bottle_project {
  echo 'Running bottle project...'

  echo 'Phase3: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running bottle project by daemon.'
  echo 'Visit localhost:5000 to see if the service is running.'
}

# Create Laravel project
function build_laravel_project {
  echo 'Building Laravel project...'

  refresh_workspace

  echo 'Phase1: Getting ready for docker-compose build...'
  docker-compose -f ./project_managers/laravel/docker-compose.composer.yaml up
  docker-compose -f ./project_managers/laravel/docker-compose.composer.yaml down --rmi all

  echo 'Phase2: DockerCompose building...'
  cp ./project_managers/laravel/Dockerfile ./src/Dockerfile
  cp ./project_managers/laravel/docker-compose.laravel.yaml ./src/docker-compose.yaml
  docker-compose -f ./src/docker-compose.yaml build
}
# Run Laravel project
function run_laravel_project {
  echo 'Running Laravel project...'

  echo 'Phase3: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running Laravel project by daemon.'
  echo 'Visit localhost:8000 to see if the service is running.'
}

# Create Ruby on Rails project
function build_ruby_on_rails_project {
  echo 'This project is to be created as API mode? [y/N]'
  read mode

  echo 'Building Ruby on Rails project...'

  refresh_workspace

  echo 'Phase1: Getting ready for docker-compose build...'
  cp ./project_managers/rails/Gemfile ./src/Gemfile
  touch ./src/Gemfile.lock
  cp ./project_managers/rails/entrypoint.sh ./src/entrypoint.sh
  cp ./project_managers/rails/docker-compose.yaml ./src/docker-compose.yaml
  # Dockerfile respectively differs from each mode
  case $mode in
    'y' | 'Y' ) bash ./project_managers/rails/create_project.sh api ;;
    'n' | 'N' | '' ) bash ./project_managers/rails/create_project.sh default ;;
    * )
      echo 'ERROR: Type y/Y for Yes, n/N for No'
      exit 1
      ;;
  esac

  echo 'Phase2: DockerCompose building...'
  docker-compose -f ./src/docker-compose.yaml build
}
# Run Ruby on Rails project
function run_ruby_on_rails_project {
  echo 'Running Ruby on Rails project...'

  echo 'Phase3: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running Ruby on Rails project by daemon.'
  echo 'Visit localhost:3000 to see if the service is running.'
}

# Create Springboot project
function build_springboot_project {
  echo 'Building Springboot project...'

  # Never refresh workspace for springboot

  echo 'Phase1: Getting ready for docker-compose build...'
  cp ./project_managers/springboot/Dockerfile ./src/Dockerfile
  cp ./project_managers/springboot/docker-compose.yaml ./src/docker-compose.yaml

  echo 'Phase2: DockerCompose building...'
  docker-compose -f ./src/docker-compose.yaml build
}
# Run Springboot project
function run_springboot_project {
  echo 'Running Springboot project...'

  echo 'Phase3: DockerCompose running...'
  docker-compose -f ./src/docker-compose.yaml up -d

  echo 'Started running Springboot project by daemon.'
  echo 'Visit localhost:8080 to see if the service is running.'
}

case $framework in
  1 )
    echo '\n'
    select_go_version
    echo '\n'
    build_echo_project
    ;;
  2 )
    echo '\n'
    select_python_version
    echo '\n'
    build_django_project
    ;;
  3 )
    echo '\n'
    select_python_version
    echo '\n'
    build_flask_project
    ;;
  4 )
    echo '\n'
    select_python_version
    echo '\n'
    build_bottle_project
    ;;
  5 )
    echo '\n'
    select_php_version
    echo '\n'
    build_laravel_project
    ;;
  6 )
    echo '\n'
    select_ruby_version
    echo '\n'
    build_ruby_on_rails_project
    ;;
  7 )
    echo '\n'
    select_java_version
    echo '\n'
    build_springboot_project
    ;;
  * )
    echo 'ERROR: Allowed input must be the integer number from 1 to 4'
    exit 1
    ;;
esac

function run_project {
  case $framework in
    1 ) run_echo_project ;;
    2 ) run_django_project ;;
    3 ) run_flask_project ;;
    4 ) run_bottle_project ;;
    5 ) run_laravel_project ;;
    6 ) run_ruby_on_rails_project ;;
    7 ) run_springboot_project ;;
    * )
      echo 'ERROR: No framework selected'
      exit 1
      ;;
  esac
}

echo 'Running project is optional.'
echo 'Start running project? [Y/n]'
read running

case $running in
  'y' | 'Y' | '' ) run_project ;;
  'n' | 'N' ) echo 'Skipped to run project.' ;;
  * )
    echo 'ERROR: Type y/Y for Yes, n/N for No'
    exit 1
    ;;
esac

echo '\n'
echo 'Have a nice day!'
