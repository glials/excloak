FROM elixir:1.13.3

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential bash

# Add a dev user with sudo privileges and set bash as the default shell
RUN adduser --disabled-password --gecos '' dev && \
    adduser dev sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev
ENV HOME /home/dev

# Install Elixir dependencies
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /excloak

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . .

CMD ["sleep", "infinity"]
