# dockerails
### Create your rails project with docker

#### To Do
- [x] Postgres
- [x] Rails new
- [ ] Procfile
- [ ] Makefile
- [ ] Redis
- [ ] Sidekick

#### Build this project
```
docker-compose run --no-deps web rails new . --force --database=postgresql
docker-compose build
```

#### Connect the database

```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: locadex
  pool: 5

development:
  <<: *default
  database: dockerails_development


test:
  <<: *default
  database: dockerails_test
```

#### Boot the app
```
docker-compose up
```

#### Create the database
```
docker-compose run web rake db:create
```

#### Run this project
```
docker-compose run web rake db:create
```
