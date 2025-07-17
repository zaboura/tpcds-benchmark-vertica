#!/usr/bin/env bash
set -euo pipefail

CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/conf"
CONFIG_FILE="$CONF_DIR/vertica.conf"

V_USER=$(grep '^vertica_user=' "$CONFIG_FILE" | cut -d'=' -f2)
V_PASS=$(grep '^vertica_password=' "$CONFIG_FILE" | cut -d'=' -f2)
V_HOST=$(grep '^vertica_host=' "$CONFIG_FILE" | cut -d'=' -f2)
V_PORT=$(grep '^vertica_port=' "$CONFIG_FILE" | cut -d'=' -f2)
V_DB=$(grep '^database=' "$CONFIG_FILE" | cut -d'=' -f2)

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SQL_DIR="$BASE_DIR/sql/dbd"
SQL_FILE="$SQL_DIR/dbd.sql"
LOG_FILE="$SQL_DIR/dbd_output.log"

PDM_PATH="$SQL_DIR/pdm.sql"
DEPLOY_PATH="$SQL_DIR/deploy.sql"


echo "Running Vertica DBD optimization"

vsql -h "$V_HOST" -p "$V_PORT" -U "$V_USER" -w "$V_PASS" -d "$V_DB" \
  -v BASE_DIR="'$BASE_DIR'" \
  -f "$SQL_FILE" 2>&1 | tee "$LOG_FILE"

echo "Optimization complete. Output saved to $LOG_FILE."
