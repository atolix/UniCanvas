FROM elixir:1.15.4

RUN apt-get update && apt-get install -y inotify-tools

RUN mix local.hex --force && \
  mix archive.install hex phx_new 1.7.2 --force && \
  mix local.rebar --force

WORKDIR /app
