#!/bin/bash
set -e

# Ensure the gems are installed
bundle check || bundle install

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec bundle exec "$@"
