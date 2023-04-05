FROM elixir:1.13.3-alpine

RUN apk update && \
    apk add --no-cache bash build-base && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /excloak

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . .

CMD ["sleep", "infinity"]
