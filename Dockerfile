FROM ruby:2.6.3-alpine

ENV RAILS_ROOT /var/www/axes_ruby
ENV EXPOSE_PORT 3003

RUN apk update && \
    apk add build-base nodejs postgresql-dev postgresql-client git curl && \
    gem install bundler

RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .
COPY config/database.sample.yml config/database.yml
COPY config/storage.sample.yml config/storage.yml

RUN ["chmod", "+x", "docker/scripts/entrypoint.sh"]
ENTRYPOINT [ "docker/scripts/entrypoint.sh" ]

HEALTHCHECK --interval=1m --timeout=5s \
    CMD curl -f http://localhost:$EXPOSE_PORT/flows || exit 1