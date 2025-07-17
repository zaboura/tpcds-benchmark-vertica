#!/usr/bin/env python
# -- coding: utf-8 --
import logging
import os

from src.config import config as project_config
from src.config import columns_config


class ConfigUtil(object):
    """Utility class for configuration and benchmark directory management."""
    @staticmethod
    def get_sql_dir():
        """get the benchmark's sql root directory"""
        return os.path.join(project_config.SQL_ROOT, project_config.BENCHMARK)

    @staticmethod
    def get_result_dir():
        """get the benchmark's result root directory"""
        return os.path.join(project_config.RESULT_ROOT, project_config.BENCHMARK)

    @staticmethod
    def set_benchmark(benchmark_name):
        """set the benchmark for whole project"""
        if benchmark_name not in project_config.BENCHMARKS:
            logging.error("invalid benchmark name '%s', should be one of %s", benchmark_name,
                          project_config.BENCHMARKS)
        project_config.BENCHMARK = benchmark_name

    @staticmethod
    def get_columns(table_name):
        """get columns of a table for Vertica benchmark"""
        table_columns = columns_config.columns[project_config.BENCHMARK]
        return table_columns[table_name]

    @staticmethod
    def get_concurrency_num(table_name):
        """Get the concurrency number for loading a specific table."""
        concurrency_num = 1
        concurrency_load_config = project_config.CONCURRENCY_LOAD_CONFIG[project_config.BENCHMARK]
        if concurrency_load_config and table_name in concurrency_load_config:
            concurrency_num = concurrency_load_config[table_name]
            logging.info("concurrency load number for table: %s is %d.", table_name, concurrency_num)
        return concurrency_num
