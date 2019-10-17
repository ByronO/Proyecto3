import sys
import csv
import time

from conexion import mssql_connection, get_data_from_sql

#genera un csv con los datos de sql

def extractor():
	try: 
		query = '[COURSE].[spTest_GetAll]'

		#sql connection
		con_sb = mssql_connection()

		data = get_data_from_sql(query)

		if len(data) <= 0:
			print('No data retrived')
			sys.exit(0)
		else:
			timestr = time.strftime("%Y%m%d-%H%M%S")
			access = "w"
			newline = {"newline": ""}

			with open(timestr+".csv", access, **newline) as outfile:
				writer = csv.writer(outfile, quoting=csv.QUOTE_NONNUMERIC)
				writer.writerow(["ID", "PERSONAL_ID", "NAME", "PHONE", "ADDRESS"])

				for row in data:
					print(row)
					writer.writerow(row)

	except IOError as e:
		print ('Error {0} get data from sql {1}'.format(e.errno, e.strerror))

	finally: 
		con_sb.close()



extractor()