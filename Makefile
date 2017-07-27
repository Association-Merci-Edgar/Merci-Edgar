## Test Makefile

test: ## Run the tests
	docker-compose up -d && docker-compose run --rm webapp rspec

install: ## Install or update dependencies
	docker-compose build

run: ## Start the app server
	docker-compose up -d && docker-compose logs -f

clean: ## Clean temporary files and installed dependencies
	docker-compose rm --all

.PHONY: install run test clean

