import sys
import csv
import time
import os
import psycopg2
import sqlite3

from conexion import postgreSql_Connection, mssql_connection, sqlite_Connection


def pg_load_table(file_path, table_name):

    try:
        conn = postgreSql_Connection()
        print("Connecting to Database")
        cur = conn.cursor()
        f = open(file_path, "r")

        cur.execute("Truncate {} Cascade;".format(table_name))
        print("Truncated {}".format(table_name))

        cur.copy_expert(
            "copy {} from STDIN CSV HEADER QUOTE '\"'".format(table_name), f)
        cur.execute("commit;")
        print("Loaded data into {}".format(table_name))
        conn.close()
        print("DB connection closed.")

        f.close()

        # CAMBIAR ESTADO A MIGRADO EN SQL
        sp = '[sp_setMigrated_B65186]'
        con = mssql_connection()
        cur = con.cursor()
        cur.execute("exec {0} @table='{1}', @OUTPUT_ISSUCCESSFULL=0, @OUTPUT_STATUS=0".format(
            sp, table_name))
        con.commit()

        sp = '[sp_deleteData_B65186]'
        con = mssql_connection()
        cur = con.cursor()
        cur.execute("exec {0} @table='{1}'".format(sp, table_name))
        con.commit()

        conn = sqlite_Connection()
        querySQLite = """INSERT INTO migrated(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(
            table_name, file_path, "Correct")
        cur = conn.cursor()
        cur.execute(querySQLite)
        conn.commit()
        cur.close()

        os.remove(file_path)

    except Exception as e:
        conn = sqlite_Connection()
        querySQLite = """INSERT INTO migrated(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(
            table_name, file_path, "Failed")
        cur = conn.cursor()
        cur.execute(querySQLite)
        conn.commit()
        cur.close()
        print("Error: {}".format(str(e)))
        sys.exit(1)


def delete_file(file_path):
    try:

        os.remove(file_path)

    except Exception as e:
        print("Error: {}".format(str(e)))
        sys.exit(1)


# Execution Example
file_path = 'sales20191016-213933.csv'
table_name = 'sales'
pg_load_table(file_path, table_name)
delete_file(file_path)
