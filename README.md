Test data for a Spider-Engine MariaDB cluster
---------------------------------------------

This repository contains scripts and instructions for ingesting simple test data into a Spider cluster. More advanced test data extracted from the [CosmoSim](https://www.cosmosim.org/) database are availble in the [cosmosim](https://gitlab.aip.de/escience/spider-test-data/tree/master/cosmosim) directory of this repository.

The following builds upon the [docker setup](https://gitlab.aip.de/escience/spider-docker) of the Spider-Engine. This implies that five different MariaDB instances are accessible on `localhost` on port `33060`-`33064` and that the following credentials are in `.my.cnf`:

```
[client]
user=root
password=0000
host=127.0.0.1
```

First create a `spider` database on all nodes:

```
mysql -P 33060 -e 'CREATE DATABASE spider;'
mysql -P 33061 -e 'CREATE DATABASE spider;'
mysql -P 33062 -e 'CREATE DATABASE spider;'
mysql -P 33063 -e 'CREATE DATABASE spider;'
mysql -P 33064 -e 'CREATE DATABASE spider;'
```

Then create the servers on all nodes:

```
mysql -P 33061 < create-servers.sql
mysql -P 33062 < create-servers.sql
mysql -P 33063 < create-servers.sql
mysql -P 33064 < create-servers.sql
mysql -P 33060 < create-servers.sql
```

Next create the shard tables on every shard node:

```
mysql -P 33061 -D spider < create-table-node.sql
mysql -P 33062 -D spider < create-table-node.sql
mysql -P 33063 -D spider < create-table-node.sql
mysql -P 33064 -D spider < create-table-node.sql
```

Then create the spider table on the head node:

```
mysql -P 33060 -D spider < create-table-head.sql
```

Finally, ingest the data using the `gaussian.py` script:

```
python gaussian.py
```
