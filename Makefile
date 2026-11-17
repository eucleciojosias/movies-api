.PHONY: help init up down logs build lint fmt psql seed

help:
	@echo "Targets:"
	@echo "  init    first-time setup: generate uv.lock and create the local .venv"
	@echo "  up      docker compose up --build (foreground)"
	@echo "  down    stop and remove containers"
	@echo "  logs    tail api logs"
	@echo "  build   build the runtime image only"
	@echo "  lint    ruff check"
	@echo "  fmt     ruff format"
	@echo "  psql    open a psql shell against the running postgres service"


uv.lock: pyproject.toml
	uv lock

init: uv.lock
	uv sync

up: uv.lock
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f api

build: uv.lock
	docker build -t movies-api .

lint:
	uv run ruff check app scripts

fmt:
	uv run ruff format app scripts

psql:
	docker compose exec postgres psql -U movies -d movies
