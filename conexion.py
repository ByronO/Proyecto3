import pymssql
import psycopg2
import sqlite3

# ConnectionToSql
_sql_server = "DESKTOP-5CCG2CP"
_sql_database = "B65186_Proyecto3"
_sql_server_port = 1433
_sql_user = "byron"
_sql_password = "1234"

# _sql_server = "163.178.107.130"
# _sql_database = "B65186"
# _sql_server_port = 1433 
# _sql_user = "laboratorios"
# _sql_password = "Saucr.118"

#ConnectionToPostgreSQL
_postgre_server = "localhost"
_postgre_database = "B65186_Proyecto3"
_postgre_server_port = 5432
_postgre_user = "postgres"
_postgre_password = "1234"

#Connection SQLite
#pendiente

#SQL Connection
def mssql_connection():
    try:
        cnx = pymssql.connect(server=_sql_server, port=_sql_server_port,
                            user=_sql_user, password=_sql_password,database=_sql_database)
        return cnx
    except:
        print('Error: MSSQL Connection')

# PostgreSQL connection
def postgreSql_Connection():
	try:
		cnx = psycopg2.connect("host="+_postgre_server+" dbname="+_postgre_database+" user="+_postgre_user+" password="+_postgre_password)
		return cnx

	except:
		print('Error: PostgreSQL connection')

def sqlite_Connection():
    conn = None
    database = r"C:\Users\Byron Ortiz Rojas\Desktop\Project\proyecto3.db"
    
    try:
        conn = sqlite3.connect(database)
        return conn
    except:
        print('Error: SQLite connection')
 