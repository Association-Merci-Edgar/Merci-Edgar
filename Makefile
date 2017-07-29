## Test Makefile

test: ## Run the tests
	docker-compose run --rm test

install: ## Install or update dependencies
	docker-compose build

run: ## Start the app server
	docker-compose up --no-recreate -d && docker-compose logs -f

clean: ## Clean temporary files and installed dependencies
	docker-compose stop && docker-compose rm worker webapp test

.PHONY: install run test clean

