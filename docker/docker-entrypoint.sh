#!/bin/sh
set -eo pipefail
echo "Start service $PROJECT_NAME"

case $1 in
  start)       
    pm2-runtime start ecosystem.config.js
    ;;
  *) 
    exec "$@"
    ;;
esac