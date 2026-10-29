# NZ Personal Income Tax Calculator

A small Rails app that works out New Zealand personal income tax for the 2025/26 tax year. Enter a yearly income and it shows the tax in each income band, the total tax, take-home pay and the effective tax rate.

## Tech

- Ruby 3.3, Rails 8.1
- No database tables: the form uses an Active Model object, not Active Record
- Runs locally in Docker, so you don't need Ruby installed on your machine

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine with the Compose plugin)

## Getting started

Run these from the project folder.

1. Install the gems (first time only, and after changing the `Gemfile`):

   ```bash
   docker compose run --rm app bundle install
   ```

2. Start the server:

   ```bash
   docker compose up
   ```

3. Open <http://localhost:3001>.

Stop the server with `Ctrl+C`, or `docker compose down` from another terminal.

The app listens on port 3000 inside the container and is published on port
**3001** on your machine. To use a different port, change the left-hand number
in `ports` in `docker-compose.yml`.

## Running the tests

```bash
docker compose run --rm app bin/rails test
```

If the server is already running, this is faster:

```bash
docker compose exec app bin/rails test
```

Linting and a security scan:

```bash
docker compose run --rm app bin/rubocop
docker compose run --rm app bin/brakeman
```

## Useful commands

| Command | What it does |
| --- | --- |
| `docker compose run --rm app bin/rails console` | Rails console |
| `docker compose run --rm app bash` | Shell inside the container |
| `docker compose restart app` | Restart the server (needed after adding a new folder under `app/`) |
| `docker compose down -v` | Stop everything and delete the installed gems |
