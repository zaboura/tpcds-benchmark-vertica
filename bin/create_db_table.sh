#!/bin/bash
set -e

# --- config parser ----------------------------------------------------------
function get_conf_value() {
    local key=$1
    grep -E "^[[:space:]]*${key}[[:space:]]*=" conf/vertica.conf \
      | tail -1 \
      | cut -d'=' -f2- \
      | sed -e 's/[[:space:]]*#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

# Load Vertica config
VERTICA_HOST=$(get_conf_value vertica_host)
VERTICA_PORT=$(get_conf_value vertica_port)
VERTICA_USER=$(get_conf_value vertica_user)
VERTICA_PASSWORD=$(get_conf_value vertica_password)
VERTICA_DB=$(get_conf_value database)
SCHEMA=$(get_conf_value schema_name)

VSQL="vsql -q -v ON_ERROR_STOP=1 \
    -h $VERTICA_HOST -p $VERTICA_PORT \
    -U $VERTICA_USER -w $VERTICA_PASSWORD \
    -d $VERTICA_DB"

# --- args & detection -------------------------------------------------------
DDL_DIR="$1"
shift
if [[ -z "$DDL_DIR" ]]; then
  echo "Usage: $0 <ddl_dir> [table1 table2 ...]"
  exit 1
fi

BASE="sql/tpcds/$DDL_DIR"
COMBINED="$BASE/tpcds_create.sql"

declare -a SQL_FILES TABLES_TO_RUN

if [[ -f "$COMBINED" ]]; then
  MODE="combined"
  SQL_FILES=("$COMBINED")
elif [[ $# -gt 0 ]]; then
  MODE="subset"
  for tbl in "$@"; do
    f="$BASE/${tbl}.sql"
    [[ -f "$f" ]] || { echo "ERROR: No DDL for table '$tbl' at $f"; exit 2; }
    SQL_FILES+=("$f")
    TABLES_TO_RUN+=("$tbl")
  done
else
  MODE="all"
  for f in "$BASE"/*.sql; do [[ -f "$f" ]] && SQL_FILES+=("$f"); done
fi

# --- schema vs table drop ---------------------------------------------------
if [[ "$MODE" == "combined" || "$MODE" == "all" ]]; then
  echo "INFO: Recreating schema '$SCHEMA' (all tables)…"
  $VSQL -c "DROP SCHEMA IF EXISTS $SCHEMA CASCADE; CREATE SCHEMA $SCHEMA;"
else
  echo "INFO: Keeping schema '$SCHEMA' intact."
  for tbl in "${TABLES_TO_RUN[@]}"; do
    echo "INFO: Dropping table '$SCHEMA.$tbl' if exists…"
    $VSQL -c "DROP TABLE IF EXISTS $SCHEMA.$tbl;"
  done
fi

# --- apply DDL --------------------------------------------------------------
echo "INFO: Applying DDL for ${#SQL_FILES[@]} table(s)…"
for sql in "${SQL_FILES[@]}"; do
  tbl=$(basename "$sql" .sql)
  echo "  ↪ $tbl"
  TMP="/tmp/${tbl}_${SCHEMA}_$$.sql"
  sed "s/{SCHEMA}/$SCHEMA/g" "$sql" > "$TMP"
  $VSQL -f "$TMP"
  rm -f "$TMP"
done

# --- summary ----------------------------------------------------------------
if [[ "$MODE" == "subset" ]]; then
  echo "INFO: ✔ Recreated tables: ${TABLES_TO_RUN[*]}"
else
  echo "INFO: ✔ Created ${#SQL_FILES[@]} table(s) in schema '$SCHEMA'."
fi

exit 0
