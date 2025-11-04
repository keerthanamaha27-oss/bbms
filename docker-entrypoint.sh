#!/bin/bash
set -e
# If Render (or another host) provides $PORT, update Apache to listen on it
if [ -n "$PORT" ]; then
  echo "Setting Apache to listen on port $PORT"
  sed -ri "s/Listen [0-9]+/Listen ${PORT}/g" /etc/apache2/ports.conf || true
  sed -ri "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${PORT}>/g" /etc/apache2/sites-available/000-default.conf || true
fi

# Execute the upstream entrypoint (ensures PHP environment is initialized) and start Apache
exec docker-php-entrypoint "$@"
