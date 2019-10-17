import sys
import csv
import time
import sqlite3


from conexion import mssql_connection, get_data_from_sql, sqlite_Connection

#genera un csv con los datos de sql

def extractor():
	try: 
		query = '[sp_GetClients_B65186]'
		table = 'phones'
		
		#sql connection
		con_sb = mssql_connection()

		data = get_data_from_sql(query, table)

		if len(data) <= 0:
			print('No data retrived')
			sys.exit(0)
		else:
			timestr = time.strftime("%Y%m%d-%H%M%S")
			access = "w"
			newline = {"newline": ""}

			with open(table+timestr+".csv", access, **newline) as outfile:
				writer = csv.writer(outfile, quoting=csv.QUOTE_NONNUMERIC)
				writer.writerow([])

				for row in data:
					print(row)
					writer.writerow(row)

		fileName = table+timestr+".csv"
		conn = sqlite_Connection()
		querySQLite = """INSERT INTO extracted(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(table, fileName, "Correct")
		cur = conn.cursor()
		cur.execute(querySQLite)
		conn.commit()
		cur.close()

	except IOError as e:
		querySQLite = """INSERT INTO extracted(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(table, "", "Failed")
		cur = conn.cursor()
		cur.execute(querySQLite)
		conn.commit()
		cur.close()
		print ('Error {0} get data from sql {1}'.format(e.errno, e.strerror))

	finally: 
		con_sb.close()



extractor()