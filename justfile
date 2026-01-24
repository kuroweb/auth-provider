@_list:
	just -l

up:
	docker compose up -d

down:
	docker compose down

ps:
	docker compose ps

restart-all:
	docker compose restart

restart container-name:
	docker compose restart {{container-name}}

attach container-name:
	docker attach $(docker compose ps -q {{container-name}})

logs:
	docker compose logs -f

rspec:
	docker compose exec spring rspec
