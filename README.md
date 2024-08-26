# WaveConnect
[![Docker CI](https://github.com/xavius-rb/wave-connect/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/xavius-rb/wave-connect/actions/workflows/docker-image.yml)

Empowering software engineers with streamlined application management.

## Local Development

1. Git clone repo:

`git clone git@github.com:xavius-rb/wave-connect.git`

2. Build the app image:

`docker compose build`

3. Start the app and attached resources:
`docker compose up -d`

### Attached Resources (Containers)

Attached resources are the application dependencies on any deployment environment

* Network
`docker network create wave-connect_default`

* Redis (Cache)
`docker run --rm --name redis --network wave-connect_default --network-alias cache -d redis:7-alpine`

* PostgreSQL (Database)
```
docker run --rm --name postgres --network-alias database --network wave-connect_default -e POSTGRES_PASSWORD=dbpassword -e POSTGRES_USER=dbuser -e POSTGRES_INITDB_ARGS="--username=dbuser" -d postgres:16-alpine
```

* Web Container
```
docker run --rm --network wave-connect_default --name wave_web -p 3000:3000 \
  -e RAILS_ENV=development \
  -e REDIS_URL=redis://redis:6379/0 \
  -e DATABASE_URL="postgresql://dbuser:dbpassword@database:5432/wave?" \
  -e SECRET_KEY_BASE=299dbb64f500e962bcd1...1a3f97e8c4 \
  xavius/wave:latest

```