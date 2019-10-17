import sys
import csv
import time
import sqlite3


from conexion import mssql_connection, sqlite_Connection

#genera un csv con los datos de sql
#Extracting data 
def get_data_from_sql(sp, date1, date2, table):
    try:
        
        con = mssql_connection()
        cur = con.cursor()
        cur.execute("exec {0} @table='{1}', @date1='{2}', @date2='{3}', @OUTPUT_ISSUCCESSFULL=0, @OUTPUT_STATUS=0".format(sp, table, date1, date2))
        data_return = cur.fetchall()
        con.commit()

        return data_return
    except IOError as e:
        print("Error {0} Getting data from SQL Server: {1}".format(
            e.errno, e.strerror))

def extractor(date1, date2):
	try: 
		query = '[sp_GetClients_B65186]'
		table = 'phones'
		
		#sql connection
		con_sb = mssql_connection()

		data = get_data_from_sql(query, date1, date2, table)

		if len(data) <= 0:
			print('No data retrived')
			sys.exit(0)
		else:
			timestr = time.strftime("%Y%m%d-%H%M%S")
			access = "w"
			newline = {"newline": ""}

			with open(date1+"_"+date2+"_"+table+".csv", access, **newline) as outfile:
				writer = csv.writer(outfile, quoting=csv.QUOTE_NONNUMERIC)
				writer.writerow([])

				for row in data:
					print(row)
					writer.writerow(row)

		# INSERTA EN BITACORA CORRECTO
		fileName = date1+"_"+date2+"_"+table+".csv"
		conn = sqlite_Connection()
		querySQLite = """INSERT INTO extracted(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(table, fileName, "Correct")
		cur = conn.cursor()
		cur.execute(querySQLite)
		conn.commit()
		cur.close()

	except IOError as e:
		# INSERTA EN BITACORA FALLIDO
		querySQLite = """INSERT INTO extracted(tableName,file,status)  VALUES('{0}','{1}','{2}')""".format(table, "", "Failed")
		cur = conn.cursor()
		cur.execute(querySQLite)
		conn.commit()
		cur.close()
		print ('Error {0} get data from sql {1}'.format(e.errno, e.strerror))

	finally: 
		con_sb.close()


date1 = "2019-9-16"
date2 = "2019-10-17"
extractor(date1, date2)