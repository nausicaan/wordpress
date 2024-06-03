# WordPress Stack

Create a fully functioning WordPress Stack with NGiNX, MariaDB, and WordPress ( including Composer and WP-CLI ) using Docker.

![Stack](stack.webp)
 
## Prerequisites

Applications needed will be:

- Docker Hub or Podman Desktop
- Docker CLI ( or Podman CLI )
- Visual Studio Code or equivilent code editor
- A Docker or Quay.io ( RedHat ) account to create repositories.

## Build

Individually, the images can be built, tagged, and pushed to a repo for easy access.

1. docker build -f Dockerfile -t [name] .
2. docker image tag [name]:latest [repo]/[name]:[version]
3. docker push [repo]/[name]:[version]

### Extras

MariaDB requires a `.env` file with the following values:

```bash
DB_NAME=''
DB_USER=''
DB_PASSWORD=''
DB_ROOT_PASSWORD=''
DB_HOST=''
WP_ENV=''
WP_HOME='http://'
WP_SITEURL='http://wp'

# Generate your keys here: https://roots.io/salts.html
AUTH_KEY=''
SECURE_AUTH_KEY=''
LOGGED_IN_KEY=''
NONCE_KEY=''
AUTH_SALT=''
SECURE_AUTH_SALT=''
LOGGED_IN_SALT=''
NONCE_SALT=''
```

## Run

To create containers all at once, simply execute the docker compose file:

```bash
docker compose up -d
```

Then create the bedrock project with this command:

```bash
composer create-project roots/bedrock
```

Finally, copy the .env file to bedrock folder and run:

```bash
wp core install --url="{WP_HOME}" --title="{PAGE TITLE}" --admin_user="{USERNAME}" --admin_password="{PASSWORD}" --admin_email="{EMAIL}" --allow-root
```