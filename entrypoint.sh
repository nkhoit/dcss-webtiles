#!/bin/sh
set -e

DATA_DIR="${DATA_DIR:-/data}"

mkdir -p "${DATA_DIR}/rcs" "${DATA_DIR}/webserver"

cd /app
exec ./webserver/server.py "$@"
