postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simplebank

dropdb:
	docker exec -it postgres12 dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:Taehyung7@localhost:5432/simplebank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:Taehyung7@localhost:5432/simplebank?sslmode=disable" -verbose down

test:
	go test -v ./db/sqlc

fixdirty:
	migrate -path db/migration -database "postgresql://postgres:Taehyung7@localhost:5432/simplebank?sslmode=disable" force 1

.PHONY:postgres createdb dropdb migrateup migratedown