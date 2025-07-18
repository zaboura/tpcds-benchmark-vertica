#!/usr/bin/env bash
set -euo pipefail

DATADIR="$1"
CONFIG_FILE="conf/vertica.conf"
COLUMN_ORDER_FILE="conf/tpcds_column_order.conf"

# Helper: extract value for a given key, allowing leading/trailing spaces
get_conf_value() {
    local key=$1
    grep -E "^[[:space:]]*${key}[[:space:]]*=" "$CONFIG_FILE" \
      | head -n1 \
      | cut -d'=' -f2- \
      | sed 's/[[:space:]]*#.*$//;s/^[[:space:]]*//;s/[[:space:]]*$//'
}

# Helper: get column order for a table
get_column_order() {
    local table=$1
    grep -E "^${table}=" "$COLUMN_ORDER_FILE" | head -n1 | cut -d'=' -f2-
}

# Read config
VERTICA_HOST=$(get_conf_value vertica_host)
VERTICA_PORT=$(get_conf_value vertica_port)
VERTICA_USER=$(get_conf_value vertica_user)
VERTICA_PASSWORD=$(get_conf_value vertica_password)
DB_NAME=$(get_conf_value database)
SCHEMA=$(get_conf_value schema_name)
COLUMN_SEPARATOR=$(get_conf_value column_separator)
[ -z "$COLUMN_SEPARATOR" ] && COLUMN_SEPARATOR='|'

# Prepare rejects dir
REJECTEDDIR="${DATADIR}/../rejected"
mkdir -p "$REJECTEDDIR"

VSQL_OPTS=(-q -v ON_ERROR_STOP=1 -h "$VERTICA_HOST" -p "$VERTICA_PORT" -U "$VERTICA_USER" -w "$VERTICA_PASSWORD" -d "$DB_NAME")

# List of tables
tables=(
  call_center catalog_page catalog_returns catalog_sales
  customer customer_address customer_demographics date_dim
  household_demographics income_band inventory item
  promotion reason ship_mode store_returns
  store_sales store time_dim warehouse
  web_page web_returns web_sales web_site
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR/.."
PY_GETCOLS="$PROJECT_ROOT/src/get_columns.py"
GROUP="tpcds" # Adjust if you want to use a different key

for table in "${tables[@]}"; do
  # Strict matching: only files exactly for this table
  if [[ "$table" == "store" ]]; then
      pattern="${DATADIR}/store_[0-9]*.dat"
  else
      pattern="${DATADIR}/${table}_[0-9]*_[0-9]*.dat"
  fi

  # Get columns string for this table
  columns=$(python3 "$PY_GETCOLS" "$GROUP" "$table")
  
  for file in $pattern; do
    [[ -e $file ]] || continue
    [[ -s $file ]] || { echo "Skipping empty file $file"; continue; }
    echo "INFO: Loading $file → $SCHEMA.$table"
    vsql "${VSQL_OPTS[@]}" -c "
COPY $SCHEMA.$table $columns
  FROM LOCAL '$file'
  DELIMITER '$COLUMN_SEPARATOR'
  NULL '\\N'
  DIRECT
  REJECTED DATA '${DATADIR}/../rejected/${table}_rejected.txt'
  EXCEPTIONS   '${DATADIR}/../rejected/${table}_exceptions.txt';
"
  done
done
echo "INFO: Loading completed"