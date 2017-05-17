Test data for a Spider-Engine MariaDB cluster
---------------------------------------------

The following builds upon the [docker setup](https://github.com/aipescience/spider-docker) of the Spider-Engine. This implies that five different MariaDB instances are accessible on `spider00` - `spider04`.

First create a `spider` database on all nodes:

```
for i in {00..04}; do
    mysql -u root -h spider$i -e 'CREATE DATABASE spider;'
done
```

Then create the servers on all nodes:

```
for i in {00..04}; do
    mysql -u root -h spider$i < create-servers.sql;
done
```

Next create the shard tables on every shard node:

```
for i in {01..04}; do
    mysql -u root -h spider$i -D spider < create-table-node.sql
done
```

Then create the spider table on the head node:

```
mysql -u root -h spider00 -D spider < create-table-head.sql
```

Finally, ingest the data using the `gaussian.py` script:

```
python gaussian.py
```
