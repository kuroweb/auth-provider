#!/bin/sh
set -e

rm -f /app/tmp/pids/server.pid
rails server -b 0.0.0.0 -p 3000

exec "$@"
