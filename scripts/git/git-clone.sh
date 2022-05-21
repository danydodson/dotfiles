#!/bin/bash

# Clone github repositories to local machine

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info "Cloning repositories..."

# Served directory
served_dir=$HOME/Developer/Served

# Sites to clone
github=(
  angolia
  blog
  booksbot
  chiang
  colour-ntp
  comments
  cors-anywhere
  cpp-demo
  danys-art
  developer
  docker-lightsail
  docker-micros
  docker-todo
  doodles
  electron-react-boilerplate
  energetic-triceratops
  es8
  eslint-config-react
  express-hello
  fastify-gateway
  fonts
  foam-template
  files
  fly-imaginary
  gatsby-4-rendering-modes
  github
  git-commands
  gocasts
  hexo-vercel
  instaclone
  interactive-js
  javascript-code-book
  js-visualizers
  leafy
  leaf-and-eye
  mailout
  microservices
  marketplace
  mediastream
  monk
  node-api-boilerplate
  noted-code
  nonce
  nodetuber
  nginx-letsencrypt
  nginx-local-tunnel
  nginx-config
  openresty-web-dev
  photobooth
  prettier-config
  robot-shop
  resume
  seesee
  seesee-observer
  shell-scripts
  social-mern
  social-network
  socketio-v2
  spa-from-scratch
  virtual-event
  vscode-remote-try-node
  vs-remote-node
  wakabox
  webstack
  webstack-micro
  whats-your-average
  webpack-userscript-template
  rocket-docs
  zeit-react-app
)

for site in "${github[@]}"; do
  if [ ! -d "$served_dir/$site" ]; then
    __info "Cloning $site to $served_dir"
    gh repo clone "danydodson/$site" "$served_dir/$site" && __ok "Cloned $site"
  fi
done

served=(
  connected
  conduit
  crwn-clothing
  dany-dev
  danydodson
  danydodson-dev
  danydodson.github.io
  danydodson_
  evently
  fat-cats
  floresh
  madhouse
  nutrit
  prop-mayhem
  spotify-tracks
  Syntax
  twinkling
)

for site in "${served[@]}"; do
  if [ ! -d "$served_dir/$site" ]; then
    __info "Cloning $site to $served_dir"
    gh repo clone "danydodson/$site" "$served_dir/$site" && __ok "Cloned $site"
  fi
done
