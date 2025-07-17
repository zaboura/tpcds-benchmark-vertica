import subprocess
import sys
import time
import os
import configparser
import re

def get_config(config_file):
    cp = configparser.ConfigParser()
    cp.read(config_file)
    vertica = cp['vertica']
    return {
        "host": vertica["vertica_host"],
        "port": vertica["vertica_port"],
        "user": vertica["vertica_user"],
        "password": vertica["vertica_password"],
        "db": vertica["database"],
        "schema": vertica["schema_name"],
        "num_runs": int(vertica.get("num_of_queries", 3)),
        "sleep_ms": int(vertica.get("sleep_ms", 500))
    }
    
def warmup_query(sql_file, conn):
    with open(sql_file) as f:
        query = f.read().strip().rstrip(';')
    full_query = f"{query};"
    cmd = [
        "vsql",
        "-h", conn["host"],
        "-p", conn["port"],
        "-U", conn["user"],
        "-w", conn["password"],
        "-d", conn["db"],
        "-X", "-A", "-q", "-f", "-"
    ]
    proc = subprocess.run(
        cmd,
        input=full_query,
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    # Optionally, check for errors
    if proc.returncode != 0:
        print(f"Warmup query failed: {proc.stderr}", file=sys.stderr)
        sys.exit(1)
    # At this point, the warmup run is fully done

def run_profile_and_get_ids(sql_file, conn):
    with open(sql_file) as f:
        query = f.read().strip().rstrip(';')
    full_query = f"PROFILE {query};"
    cmd = [
        "vsql",
        "-h", conn["host"],
        "-p", conn["port"],
        "-U", conn["user"],
        "-w", conn["password"],
        "-d", conn["db"],
        "-X", "-A", "-q", "-f", "-"
    ]
    proc = subprocess.run(
        cmd,
        input=full_query,
        encoding="utf-8",
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if proc.returncode != 0:
        print(f"Profile run failed: {proc.stderr}", file=sys.stderr)
        return None, None
    trxid, stmtid = None, None
    for line in reversed(proc.stderr.splitlines()):
        m = re.search(r"^HINT:.*?=([0-9]+).*?=([0-9]+);", line)
        if m:
            trxid, stmtid = m.group(1), m.group(2)
            break
    return trxid, stmtid

def get_query_time_ms(conn, txn_id, stmt_id):
    query = f"""
        SELECT query_duration_us
        FROM v_monitor.query_profiles
        WHERE transaction_id = {txn_id} AND statement_id = {stmt_id};
    """
    cmd = [
        "vsql",
        "-h", conn["host"],
        "-p", conn["port"],
        "-U", conn["user"],
        "-w", conn["password"],
        "-d", conn["db"],
        "-Atq", "-c", query
    ]
    out = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        encoding="utf-8"
    )
    if out.returncode != 0:
        print(f"Failed to fetch query time: {out.stderr}", file=sys.stderr)
        return None
    us = out.stdout.strip()
    if us:
        return int(float(us) // 1000)  # to ms
    else:
        print(f"WARNING: No timing found for txn={txn_id} stmt={stmt_id}", file=sys.stderr)
        return None

def main():
    if len(sys.argv) != 3:
        sys.exit(1)
    config_file, sql_file = sys.argv[1], sys.argv[2]
    conn = get_config(config_file)
    num_runs = conn["num_runs"]
    sleep_ms = conn["sleep_ms"] // 1000
    
    time.sleep(60)

    # --- Warmup runs: each run waits for completion ---
    for i in range(3):
        warmup_query(sql_file, conn)
        time.sleep(sleep_ms)  # Wait before next run

    # --- Timed runs: each run waits for completion ---
    times = []
    for i in range(num_runs):
        txn_id, stmt_id = run_profile_and_get_ids(sql_file, conn)
        if not (txn_id and stmt_id):
            times.append(-1)
            print(f"Failed to get execution time for run {i+1} of {sql_file}", file=sys.stderr)
            continue
        ms = get_query_time_ms(conn, txn_id, stmt_id)
        times.append(ms if ms is not None else -1)
        time.sleep(sleep_ms)  # Wait before next run

    valid_times = [t for t in times if t >= 0]
    avg_time = int(sum(valid_times) // len(valid_times)) if valid_times else -1
    base = os.path.basename(sql_file)
    num = re.findall(r'\d+', base)
    if num:
        query_name = f"Query{num[0]}"
    else:
        query_name = "Query"
    print(f"{query_name},{','.join(str(x) for x in times)},{avg_time:.2f}")

if __name__ == "__main__":
    main()
