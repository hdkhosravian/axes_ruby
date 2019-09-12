#!/bin/bash
set -e

# wait for postgres to be ready
sh /var/www/axes_ruby/docker/scripts/wait-for-postgres.sh

# database existance check
rails db:create && echo 'database existing'
# don't worry! seeds will not create duplicate records.
rails db:migrate 
echo 'migration & seeds updated'

echo 'compile assets'
rails assets:precompile
echo 'compile assets is finished.'

echo 'run redis-server sidekiq'
redis-server &
bundle exec sidekiq -d

puma -C config/puma.rb

exec "$@"