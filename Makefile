.PHONY: default build run assets cleanassets

default: dev start build clean test stop

assets:
	yarn build

dev:
	make build
	make start

build:
	docker-compose build postgres
	docker-compose up -d postgres
	docker-compose build web
	docker-compose up -d web
	docker-compose run --rm web python ../create_db.py
	docker-compose run --rm web python ../test_data.py -p

start:
	docker-compose up -d

clean: cleanassets
	docker rm openoversight_web_1
	docker rm openoversight_postgres_1

cleanassets:
	rm -rf ./OpenOversight/app/static/dist/*

test:
	docker-compose run --rm web scripts/run_tests.sh

stop:
	docker-compose stop
