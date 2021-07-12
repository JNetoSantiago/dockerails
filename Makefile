# https://stackoverflow.com/a/14061796/2237879
#
# This hack allows you to run make commands with any set of arguments.
#
# For example, these lines are the same:
#   > make g devise:install
#   > bundle exec rails generate devise:install
# And these:
#   > make add-migration add_deleted_at_to_users deleted_at:datetime
#   > bundle exec rails g migration add_deleted_at_to_users deleted_at:datetime
# And these:
#   > make add-model Order user:references record:references{polymorphic}
#   > bundle exec rails g model Order user:references record:references{polymorphic}
#
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

new-project:
	docker-compose run --no-deps web rails new . --force --database=postgresql

build:
	docker-compose build

add-migration:
	docker-compose run web bundle exec rails g migration $(RUN_ARGS)

add-model:
	docker-compose run web bundle exec rails g model $(RUN_ARGS)



db-create:
	docker-compose run web bundle exec rake db:create

db-migrate:
	docker-compose run web bundle exec rake db:migrate

db-rollback:
	docker-compose run web bundle exec rake db:rollback



lint-ruby-setup:
	bundle exec rubocop --auto-gen-config

lint-ruby:
	bundle exec rubocop -a

lint-security:
	brakeman



run-console:
	docker-compose run web bundle exec rails console

run-generate:
	docker-compose run web bundle exec rails generate $(RUN_ARGS)

stop:
	docker-compose down

up:
	docker-compose up

b: build

c: run-console

g: run-generate

s: run-rails

u: up