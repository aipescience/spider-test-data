#!/usr/bin/env python
import MySQLdb
import numpy as np

db = MySQLdb.connect(host="127.0.0.1", port=33060, user="root", passwd="0000", db="spider")
cur = db.cursor()

n, mu, sigma = 10000, 0, 1.0

np.random.seed(1337)

data = np.array([
    np.arange(1, n+1, dtype=np.int32),
    np.random.normal(mu, sigma, n),
    np.random.normal(mu, sigma, n)
]).T.tolist()

sql = 'INSERT INTO `gaussian` (`id`, `x`, `y`) VALUES (%s, %s, %s)'
cur.executemany(sql, data)
cur.close()
