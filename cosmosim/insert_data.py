#!/usr/bin/env python
import MySQLdb
import csv
import argparse

# Simple python script for ingesting data from csv-file

def main():

    # read command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("database", type=str, help="Name of database")
    parser.add_argument("table", type=str, help="Name of database table")
    parser.add_argument("csvfile", type=str, help="Name of the csv file with the data")
    args = parser.parse_args()

    database = args.database
    table = args.table
    csvfile = args.csvfile

    # connection parameters
    host = "127.0.0.1"
    port = 33060
    username = "root"
    password = "0000"

    # connect with database
    db = MySQLdb.connect(host="127.0.0.1", port=33060, user="root", passwd="0000", db="MDR1")
    cur = db.cursor()

    # read csv-file with data
    fh = open(csvfile, 'r')
    csvreader = csv.reader(fh, delimiter=',', lineterminator='\n')
    
    # find number of columns (from first line) for constructing ingest-string
    ncolumns = len(next(csvreader))
    fh.seek(0)  # go back

    valuestring = "%s, " * (ncolumns-1) + "%s"
    sql = "INSERT INTO `%s`.`%s` VALUES (%s)" % (database, table, valuestring)

    # run the sql command, row by row (it's not fast, but easy ...)
    print "Ingesting data ..."
    cur.executemany(sql, csvreader)

    cur.close()
    fh.close()

    print "Ingest done for table %s.%s from file %s." % (database, table, csvfile)

if __name__ == '__main__':
    main()
