#!/usr/bin/env python
# -- coding: utf-8 --
###########################################################################
#
# Copyright (c) 2020 Copyright (c) 2020, Dingshi Inc.  All rights reserved.
#
###########################################################################
"""
Vertica API library for benchmark and ETL operations
"""
import logging
import os
import vertica_python

from src.lib.config_util import ConfigUtil
from src.lib import conf_parser


class VerticaException(Exception):
    """Custom exception for Vertica-related errors."""
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return repr(self.value)


class VerticaLib(object):
    """Vertica API lib"""

    def __init__(self):
        self.conn = None
        self.cursor = None
        self.vertica_host = ""
        self.vertica_port = ""
        self.vertica_user = ""
        self.vertica_password = ""
        self.database = ""
        self.schema = ""
        self.base_sql_file_dir = ConfigUtil.get_sql_dir()
        self.query_sql_dir = f"{self.base_sql_file_dir}/query"
        self.create_db_table_sql_dir = self.base_sql_file_dir
        self.flat_insert_sql_dir = f"{self.base_sql_file_dir}/insert"
        self.result_file_dir = ConfigUtil.get_result_dir()
        self.read_conf()

    def read_conf(self):
        """Read Vertica connection configuration from conf_parser."""
        self.vertica_host = conf_parser.vertica_host
        self.vertica_port = conf_parser.vertica_port
        self.vertica_user = conf_parser.vertica_user
        self.vertica_password = conf_parser.vertica_password
        self.database = conf_parser.vertica_db
        self.schema = conf_parser.vertica_schema

    def connect(self):
        """Establish a connection to the Vertica database."""
        conn_info = {
            'host': self.vertica_host,
            'port': int(self.vertica_port),
            'user': self.vertica_user,
            'password': self.vertica_password,
            'database': self.database,
            'autocommit': True
        }
        self.conn = vertica_python.connect(**conn_info)
        self.cursor = self.conn.cursor()

    def close(self):
        """Close the Vertica database connection and cursor."""
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()

    def execute_sql(self, sql, sql_type):
        """Execute a SQL statement of the given type ('ddl' or 'dml')."""
        try:
            self.cursor.execute(sql)
            if sql_type == "ddl":
                return {"status": True, "msg": "DDL executed"}
            elif sql_type == "dml":
                result = self.cursor.fetchall()
                return {"status": True, "result": result, "msg": "DML executed"}
            else:
                return {"status": False, "msg": "Unknown SQL type"}
        except Exception as e:
            return {"status": False, "msg": str(e)}

    def get_sqls_from_file(self, sql_file):
        """Read SQL statements from a file and return as a list."""
        sql_list = []
        with open(sql_file, 'r', encoding='utf-8') as f:
            for line in f.readlines():
                sql_list.append(line)
        return sql_list

    def get_sql_from_file(self, sql_path):
        """Read and concatenate SQL statements from a file, ignoring comments."""
        with open(sql_path, 'r', encoding='utf-8') as f:
            sql = ""
            for line in f.readlines():
                line = line.strip()
                if not line.startswith("--"):
                    sql += " " + line
        return sql

    def get_sqls_from_dir(self, dir_path):
        """Read all SQL files in a directory and return their contents as a list of dicts."""
        sql_list = []
        if not os.path.isdir(dir_path):
            logging.error("it is not a valid directory. dir_path: %s", dir_path)
            return sql_list
        files = os.listdir(dir_path)
        for create_file in files:
            if create_file.startswith(".") or not create_file.endswith(".sql"):
                continue
            file_path = os.path.join(dir_path, create_file)
            if not os.path.isfile(file_path):
                continue
            logging.debug("get single sql info from file:%s", file_path)
            sql = self.get_sql_from_file(file_path)
            sql_dict = {"file_name": create_file.split(".")[0],
                        "file_path": file_path,
                        "sql": sql}
            logging.debug("sql info is:%s", sql_dict)
            sql_list.append(sql_dict)
        return sql_list

    def get_query_table_sqls(self, dir_name):
        """Get SQL files for queries from a given directory name."""
        query_dir = os.path.abspath(os.path.join(self.query_sql_dir, dir_name))
        return self.get_sqls_from_dir(query_dir)

    def get_create_db_table_sqls(self, dir_name):
        """Get SQL files for creating DB tables from a given directory name."""
        create_sql_dir = os.path.abspath(os.path.join(self.create_db_table_sql_dir, dir_name))
        return self.get_sqls_from_dir(create_sql_dir)

    def get_flat_insert_sqls(self):
        """Get SQL files for flat insert operations."""
        return self.get_sqls_from_dir(self.flat_insert_sql_dir)

    def get_query_sql_dirs(self):
        """Get a list of subdirectories in the query directory."""
        logging.debug("find sub directory in query dir:%s", self.query_sql_dir)
        sql_dirs = os.listdir(self.query_sql_dir)
        abs_sql_dirs = [sql_dir for sql_dir in sql_dirs
                        if os.path.isdir(f"{self.query_sql_dir}/{sql_dir}")]
        return abs_sql_dirs or ["."]

    def get_query_base_result(self, sql_dir, scale, file_name):
        """Read the base result file for a query and return its lines as a list."""
        result_file_name = f"{file_name}.sql.res"
        result_file_path = f"{self.result_file_dir}/{scale}/{sql_dir}/{result_file_name}"
        if not os.path.isfile(result_file_path):
            return None
        base_result = []
        with open(result_file_path, "r", encoding='utf-8') as f:
            for line in f:
                base_result.append(line.strip("\n"))
        return base_result

    def create_schema(self, schema_name=None):
        """Create a schema in Vertica if it does not already exist."""
        if schema_name is None:
            schema_name = self.schema
        sql = f"CREATE SCHEMA IF NOT EXISTS {schema_name}"
        return self.execute_sql(sql, "ddl")

    # def use_database(self, db_name):
    #     """Acknowledge database selection; Vertica uses per-connection databases."""
    #     return {"status": True, "msg": f"Connected to {db_name}"}

    # def create_and_use_database(self):
    #     """Create the configured database schema and acknowledge its use."""
    #     self.create_schema(self.database)
    #     return self.use_database(self.database)

    def show_databases(self):
        """Retrieve all schema names from Vertica."""
        sql = "SELECT schema_name FROM v_catalog.schemata"
        return self.execute_sql(sql, "dml")

    def exists_database(self, schema_name):
        """Check if a schema exists in Vertica."""
        res = self.show_databases()["result"]
        return schema_name in [x[0] for x in res]
