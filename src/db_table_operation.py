#!/usr/bin/env python
# -- coding: utf-8 --
import argparse
import logging
import os
import sys
import re

from src.lib import conf_parser
from src.lib import vertica_lib
from src.lib.config_util import ConfigUtil
from src.utility import logger




class VerticaDbTableOperation(object):
    def __init__(self):
        self.lib = vertica_lib.VerticaLib()

    def connect_vertica(self):
        self.lib.connect()

    def close_vertica(self):
        self.lib.close()

    def create_database(self, db_name):
        return self.lib.create_schema(db_name)

    def create_db_table(self, data_dir_path):
        self.connect_vertica()
        try:
            vertica_schema = conf_parser.vertica_schema
            res = self.lib.create_schema(vertica_schema)
            if res is None:
                print("create schema error.")
                sys.exit(-1)
            if not res["status"]:
                print("create schema error, msg: %s" % (res["msg"]))
                sys.exit(-1)

            # get create db table sql
            ddl_sqls = self.lib.get_create_db_table_sqls(data_dir_path)
            if not ddl_sqls:
                logging.error("no valid sql file under directory: %s", data_dir_path)

            for sql_dict in ddl_sqls:
                sql_file_path = os.path.join(data_dir_path, sql_dict["file_path"])
                # Prepend schema to table creation if not present
                sql = sql_dict["sql"]
                if f"{vertica_schema}." not in sql:
                    # crude replace for CREATE TABLE table_name -> CREATE TABLE schema.table_name
                    sql = re.sub(r'(CREATE\s+TABLE\s+)(\w+)', f"\\1{vertica_schema}.\\2", sql, flags=re.IGNORECASE)
                res = self.lib.execute_sql(sql, "ddl")
                if res is None:
                    logging.error("failed to create table. sql: %s", sql_file_path)

                if not res["status"]:
                    logging.warning("create table error. sql: %s, msg: %s", sql_file_path, res["msg"])
                else:
                    logging.info("create table success. sql: %s", sql_file_path)
        finally:
            self.close_vertica()

    def flat_insert(self):
        self.connect_vertica()
        try:
            # get flat insert sql
            insert_sqls = self.lib.get_flat_insert_sqls()
            for sql_dict in insert_sqls:
                print("sql: %s start" % (sql_dict["file_name"]))
                res = self.lib.execute_sql(sql_dict["sql"], "dml")
                if res is None:
                    print("sql: %s. flat insert error" % (sql_dict["file_name"]))

                if not res["status"]:
                    print("sql: %s. flat insert error, msg: %s" % (sql_dict["file_name"], res["msg"]))
                else:
                    print("sql: %s success" % (sql_dict["file_name"]))
        finally:
            self.close_vertica()

    def parse_args(self):
        """
        parse args
        """
        parser = argparse.ArgumentParser(prog="db_table_operation.py",
                                         description="db/table operation args parser")
        parser.add_argument("-q", "--quiet", dest="log_quiet", action="store_true",
                            default=False, help="whether not to print INFO logs")
        parser.add_argument("-v", "--verbose", dest="log_verbose", action="store_true",
                            default=False, help="whether to print DEBUG logs")
        subparsers = parser.add_subparsers(dest="operation_type", help="sub-command help")
        parser_create = subparsers.add_parser("create", help="create tables")
        self.parse_create_args(parser_create)
        parser_flat_insert = subparsers.add_parser("flat_insert", help="flat insert data")
        self.parse_flat_insert(parser_flat_insert)
        return parser

    def parse_create_args(self, parser):
        parser.add_argument("sql_dir", type=str, help="directory with create table sql files")

    def parse_flat_insert(self, parser):
        pass


if __name__ == '__main__':
    vertica_operation = VerticaDbTableOperation()
    args_parser = vertica_operation.parse_args()
    args = args_parser.parse_args()

    if args.log_quiet:
        logger.LOG_LEVEL = logging.WARN
    elif args.log_verbose:
        logger.LOG_LEVEL = logging.DEBUG
    logger.init_logging(level=logger.LOG_LEVEL)
    logging.debug("args: %s", args)

    if args.operation_type == "create":
        vertica_operation.create_db_table(args.sql_dir)
    elif args.operation_type == "flat_insert":
        vertica_operation.flat_insert()
    elif not args.operation_type:
        logging.error("should specify the operation type.")
        args_parser.print_help()
    else:
        logging.error("error operation type=%s", args.operation_type)
