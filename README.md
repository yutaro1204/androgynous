# Androgynous

```md
                   _
    __ _ _ __   __| |_ __ ___   __ _ _   _ _ __   ___  _   _ ___
   / _` | '_ \ / _` | '__/ _ \ / _` | | | | '_ \ / _ \| | | / __|
  | (_| | | | | (_| | | | (_) | (_| | |_| | | | | (_) | |_| \__ \
   \__,_|_| |_|\__,_|_|  \___/ \__, |\__, |_| |_|\___/ \__,_|___/
                               |___/ |___/
```

Androgyny is being having both male and female organs.

This provisioning system is entitled Androgynous, having diversity to create multiple projects over languages.

Frameworks Androgynous covers now
- echo(Golang)
- Springboot(Java)
- Laravel(PHP)
- flask(Python)
- Django(Python)
- bottle(Python)
- Ruby on Rails(Ruby)

## Prerequisite
- Docker
- DockerCompose

## How to start

Just run `provisioning.sh` and select your favorite framework.

```shell
$ sh provisioning.sh
```

## Useful DockerCompose commands

Commands for building, running with daemon, runninng with commands, removing all containers and images.

```shell
$ docker-compose build
$ docker-compose up -d
$ docker-compose run --rm web_service some_commands
$ docker-compose down --rmi all
```

## Notes

### Django Services

Django project includes PostgreSQL container, so if you intend to use DB you need to configure DB in `project/setting.py`.

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}
```

Reference: [Quickstart: Compose and Django](https://docs.docker.com/compose/django/)


### Springboot Services

Androgynous will not create Springboot project directory.

The project is supposed to be created in advance with STS, [Spring initializr](https://start.spring.io/) or something.

#### Procedure

1. Locate the project directory in the root directory as `src`.
2. The project must have `target/` directory which has `*.jar` with `maven install` or something.
3. Run `provisioning.sh` and select `7. Springboot by Java`

Then the docker containers will be running, and have good time!

#### Set up

```shell
DC_PATH = ./project_managers/springboot/docker-compose.composer.yaml
```

##### Create Springboot containers

```shell
$ docker-compose -f $DC_PATH build
```

##### Start running Springboot Services

```shell
$ docker-compose -f $DC_PATH up
```
