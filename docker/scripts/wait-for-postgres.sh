#!/bin/bash

# set -e
# shift
# cmd="$@"
export PGPASSWORD="$DATABASE_PASSWORD"

until psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USERNAME" postgres -c '\l'; do
    >&2 echo "waiting for postgres..."
    sleep 1
done

>&2 echo "connected to postgres"
# exec $cmd
