#!/usr/bin/env python
# -- coding: utf-8 --
import configparser
import os
import sys

from src.config import config as project_config

if not os.path.exists(project_config.VERTICA_CONF):
    print("Vertica config file not exist. file: %s" % project_config.VERTICA_CONF)
    sys.exit()
config = configparser.ConfigParser()
config.read(project_config.VERTICA_CONF)

# starrocks config
vertica_host = config.get("vertica", "vertica_host")
vertica_port = config.get("vertica", "vertica_port")
vertica_user = config.get("vertica", "vertica_user")
vertica_password = config.get("vertica", "vertica_password")
vertica_db = config.get("vertica", "database")
vertica_schema = config.get('vertica', 'schema_name', fallback='tpcds')
sleep_ms = config.get("vertica", "sleep_ms")

# optional
concurrency_num_string = config.get("vertica", "concurrency_num", fallback="1")
concurrency_num_list = concurrency_num_string.split(",")
num_of_queries = config.getint("vertica", "num_of_queries", fallback=1)


