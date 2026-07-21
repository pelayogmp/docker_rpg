# Docker Compose Setup for Redmine, PostgreSQL, and GitLab

This repository contains a `docker-compose.yml` file to set up and manage a development environment with Redmine, PostgreSQL, and GitLab using Docker and Docker Compose.

## Prerequisites

Ensure you have the following installed on your system:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Services

This `docker-compose.yml` file defines four services:

1. **PostgreSQL**: A robust, SQL-compliant database system used by Redmine.
2. **Redmine**: An open-source project management and issue-tracking tool.
3. **GitLab**: A complete DevOps platform, delivered as a single application.
4. **GitLab Runner**: A GitLab CI/CD runner to run your pipelines.

## Setup and Configuration

### PostgreSQL Service

The PostgreSQL service is configured with the following environment variables for database connection:

- `POSTGRES_USER`: The username for the PostgreSQL database.
- `POSTGRES_PASSWORD`: The password for the PostgreSQL database.
- `POSTGRES_DB`: The database name.

### Redmine Service

The Redmine service depends on PostgreSQL and is configured to connect to it using the specified environment variables:

- `REDMINE_DB_POSTGRES`: The hostname for the PostgreSQL service.
- `REDMINE_DB_DATABASE`: The database name.
- `REDMINE_DB_USERNAME`: The username for the database.
- `REDMINE_DB_PASSWORD`: The password for the database.

### GitLab Service

The GitLab service is configured with the following ports:

- `80`: For HTTP access.
- `443`: For HTTPS access.
- `2222`: For SSH access.

The GitLab configuration is managed using the `GITLAB_OMNIBUS_CONFIG` environment variable.

### GitLab Runner Service

The GitLab Runner service is configured to use the Docker executor and mounts the Docker socket to enable Docker commands within jobs.

## Volumes

The following Docker volumes are used to persist data:

- `postgres-data`: Stores PostgreSQL data.
- `redmine-data`: Stores Redmine files.
- `gitlab-config`: Stores GitLab configuration files.
- `gitlab-logs`: Stores GitLab logs.
- `gitlab-data`: Stores GitLab data.

## Usage

### Starting the Services

To start the services, run:

```sh
docker-compose up -d
```

## Send mail through Google - Untested

```yaml
production:
  delivery_method: :smtp
  smtp_settings:
    enable_starttls_auto: true
    address: "smtp.gmail.com"
    port: 587
    domain: "smtp.gmail.com"
    authentication: :plain
    user_name: "your_email@gmail.com"
    password: "your_password"
```

