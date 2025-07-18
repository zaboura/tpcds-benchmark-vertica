# 🧪 Vertica TPC-DS Benchmark

A toolkit to generate, load, and benchmark [TPC-DS](https://www.tpc.org/tpcds/) datasets on [Vertica](https://www.vertica.com/).

---

## 📋 Overview

This project enables you to:

- Generate TPC-DS data at various scales
- Automatically create Vertica-compatible schemas
- Load benchmark data efficiently
- Run TPC-DS benchmark queries and analyze Vertica performance

---

## 🚀 Quick Start

### 1. 📦 Generate TPC-DS Data

Unzip the package and generate data:

```bash
unzip tpcds-benchmark-vertica.zip
cd tpcds-benchmark-vertica

# Replace 100 with desired scale in GB (e.g., 1, 10, 100, 1000)
sh bin/gen_data/gen-tpcds.sh 100 data_100
```

*This uses dsdgen to generate the data. Ensure you have the required generator built.*

---

### 2. 🏗️ Create Table Structure in Vertica

Configure your Vertica connection:

```bash
nano conf/vertica.conf
```

Update the following fields:

- `host`: Vertica node IP or hostname
- `port`: Default is `5433`
- `user` and `password`: As required

Then, create the database tables:

```bash
sh bin/create_db_tables.sh ddl_100
```

*Adjust the schema/DDL directory as needed.*

---

### 3. 📥 Load Data into Vertica

Import the generated dataset:

```bash
sh bin/load_data.sh data_100
```

---
### 4. 🛠️ Database Physical Design & Optimization

To achieve optimal query performance on Vertica, this toolkit includes a helper script that leverages Vertica's Database Designer:

### `bin/run_dbd_optimize.sh`

This script runs Vertica's comprehensive Database Designer tool to analyze your schema, query workload, and data distribution, then generates and deploys optimal physical projections for all TPC-DS tables.

```bash
sh bin/run_dbd_optimize.sh
```

---

### 5. 🚦 Run the TPC-DS Benchmark

Execute all benchmark queries:

```bash
sh bin/benchmark.sh
```

Results and logs will be saved in the `root` directory.

---

## 📁 Project Structure

```text
tpcds-benchmark-vertica/
│   .gitignore
│   README.md
│
├── bin/
│   ├── benchmark.sh
│   ├── create_db_tables.sh
│   ├── load_tpcds.sh
│   └── gen_data/
│       └── gen-tpcds.sh
│
├── conf/
│   └── vertica.conf
│
├── sql/
│   ├── dbd/
│   │   └── dbd.sql        # DBD-based physical design/optimization script
│   │   
│   └── tpcds/
│       ├── ddl_100/
│       │   └── tpcds_create.sql
│       ├── ddl_1000/
│       │   └── tpcds_create.sql
│       ├── ddl_500/
│       │   └── tpcds_create.sql
│       └── query/tpcds/
│           ├── query01.sql
│           ├── query02.sql
│           └── ... (TPC-DS queries)
│
├── src/
│   ├── benchmark.py
│   ├── db_table_operation.py
│   ├── get_columns.py
│   └── ... (other modules)
│
└── thirdparty/
    └── tpcds-dbgen/
        ├── dsdgen         # Built data generator binary
        ├── ... (C sources, makefile, etc.)
```

---

## 📝 Requirements

- Bash or compatible shell
- Vertica client utilities (vsql)
- Built TPC-DS data generator (dsdgen) for your platform
- Python 3 (if your scripts include Python utilities)

---

## 🛠️ Customization

- Edit `conf/vertica.conf` for your environment.
- Adjust scale and paths in `gen-tpcds.sh`.
- You can modify or extend query sets in the `queries/` directory.

---

## 🤔 Troubleshooting

- If data generation fails, ensure `dsdgen` is built and available in `bin/gen_data/`.
- If you get connection errors, check `vertica.conf` and your Vertica server/network.
- Windows users: Prefer Git Bash or WSL for Unix-style scripts.

---

## 📚 References

- [TPC-DS Benchmark](https://www.tpc.org/tpcds/)
- [Vertica Documentation](https://www.vertica.com/documentation/)
- [dsdgen Source](https://github.com/databricks/tpcds-kit)

---

## 📄 License

MIT License

---

**Happy benchmarking! 🚀**

