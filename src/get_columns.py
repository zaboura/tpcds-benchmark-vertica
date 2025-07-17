#!/usr/bin/env python3
import sys


from config.columns_config import columns

if len(sys.argv) != 3:
    print("")
    sys.exit(0)

group = sys.argv[1]
table = sys.argv[2]

col_list = columns.get(group, {}).get(table, [])
if col_list:
    print("(" + ",".join(col_list) + ")")
else:
    print("")
