#!/usr/bin/env bash
set -euo pipefail

############################################################
# Usage:
#   ./benchmark.sh                # Run all SQL files in the default query directory
#   ./benchmark.sh file1.sql      # Run a specific SQL file
#   ./benchmark.sh file1.sql file2.sql ...  # Run multiple specific SQL files
#
# Background execution examples:
#   nohup ./benchmark.sh > log.txt 2>&1 &
#   nohup ./benchmark.sh file1.sql file2.sql > log.txt 2>&1 &
#
# Note:
#   - SQL files can be specified with full path or just the filename (if in the query dir).
#   - Output is saved to query_timings.csv
############################################################
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$DIR/conf/vertica.conf"
QUERY_DIR="$DIR/sql/tpcds/query/tpcds"
RESULTS="$DIR/query_timings.csv"
PYTHON="$DIR/src/run_query.py"

echo "SQL,run1_ms,run2_ms,run3_ms,avg_ms" > "$RESULTS"

declare -A seen  # To track duplicates

if [ $# -ge 1 ]; then
    # Only run provided files, but sorted by query number
    files=()
    for arg in "$@"; do
        if [[ -f "$arg" ]]; then
            files+=("$arg")
        elif [[ -f "$QUERY_DIR/$arg" ]]; then
            files+=("$QUERY_DIR/$arg")
        else
            echo "SQL file not found: $arg"
            continue
        fi
    done
else
    # Gather all .sql files, sort by Query number
    files=($(ls "$QUERY_DIR"/query*.sql | sort -V))
fi

for sql in "${files[@]}"; do
    base=$(basename "$sql")
    # Extract query number for duplicate check
    qnum="${base//[!0-9]/}"
    if [[ -n "$qnum" && -n "${seen[$qnum]:-}" ]]; then
        echo "Skipping duplicate: $base"
        continue
    fi
    seen[$qnum]=1
    python3 "$PYTHON" "$CONFIG_FILE" "$sql" >> "$RESULTS"
done

echo "All queries complete. See $RESULTS."