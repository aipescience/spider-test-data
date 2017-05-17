CosmoSim test data for a Spider-Engine MariaDB cluster with Docker
==================================================================

Here are the instructions for ingesting sample data extracted from CosmoSim.
This assumes that a docker setup of the Spider-Engine exists and 4 nodes have been created as described at [spider-docker](https://gitlab.aip.de/escience/spider-docker).
Some example queries are added below.

First create the database servers, if not already done:

```
for i in {00..04}; do
    mysql -u root -h spider$i < create-servers.sql;
done
```

These will be reused in the connection-string when creating a spider table on the head node.

Create a `MDR1` database on all nodes:

```
for i in {00..04}; do
    mysql -u root -h spider$i -e 'CREATE DATABASE MDR1;'
done
```

FOF data
--------

This is a random sample of ~ 12,000 friends-of-friends (FOF) dark matter clusters from the `MDR1.FOF` table at [CosmoSim](https://www.cosmosim.org/). Only a subset of the columns was chosen.

Create the shard tables on every shard node:

```
for i in {01..04}; do
    mysql -u root -h spider$i -D MDR1 < create-table-fof-node.sql
done
```

Then create the spider table on the head node. Here we reuse the servers created above for telling the spider engine to which nodes it should connect.

```
mysql -u root -h spider00 -D MDR1 < create-table-fof-head.sql
```

Finally, ingest the data from `mdr1-fof.csv` using a simple python script:

```
python insert_data.py MDR1 FOF mdr1-fof.csv
```

### Example queries for FOF-table

Now you can query the head node using either `mysql -u root -h spider00 -e '<put your query here>'` or by directly logging in to the head node and running your queries interactively with `mysql -u root -h spider00`.

Try e.g. following sample queries:

* Get the most massive objects (dark matter clusters):

    ```
    SELECT * FROM MDR1.FOF
    WHERE snapnum=85
    ORDER BY mass DESC
    LIMIT 10;
    ```

* Get the mass function for this sample of objects:

    ```
    SELECT 0.25*( ROUND(LOG10(mass)/0.25) ) AS log_mass, AVG(mass), AVG(LOG10(mass)), COUNT(*) AS num
    FROM MDR1.FOF
    WHERE snapnum=85
    GROUP BY log_mass
    ORDER BY log_mass;
    ```

    This returns 15 rows. Note that the number of objects has its peak at about log10(mass) = 11.5.

* Get all halos in a box of +-50 Mpc/h around the most massive object:

    ```
    SELECT * FROM MDR1.FOF f, (SELECT x,y,z FROM MDR1.FOF WHERE snapnum=85 ORDER BY mass DESC LIMIT 1) as c
    WHERE f.x BETWEEN c.x-50 AND c.x+50
      AND f.y BETWEEN c.y-50 AND c.y+50
      AND f.z BETWEEN c.z-50 AND c.z+50;
    ```

    This should return 15 rows of nearby objects.


FOFMtree and TreeSnapnums
-------------------------

For more variety in our example queries, let's ingest some more data. The FOFMtree data were extracted from the `MDR1.FOFMTree` table of [CosmoSim](https://www.cosmosim.org/) and contain information about the merging history of the dark matter clusters.
We follow the same receipe as before: create tables on nodes, then on the head node, and then insert the data:

Create node and head table for `FOFMtree`:

```
mysql -u root -h spider00 -D MDR1 < create-table-fofmtree-head.sql
for i in {01..04}; do
    mysql -u root -h spider$i -D MDR1 < create-table-fofmtree-node.sql
done
```

Create node and head table for `TreeSnapnums`:

```
mysql -u root -h spider00 -D MDR1 < create-table-treesnapnums-head.sql
for i in {01..04}; do
    mysql -u root -h spider$i -D MDR1 < create-table-treesnapnums-node.sql
done
```

Insert the data:

```
python insert_data.py MDR1 FOFMtree mdr1-fofmtree.csv
python insert_data.py MDR1 TreeSnapnums mdr1-treesnapnums.csv
```

### Example queries for FOFMtree and TreeSnapnums

* Get all progenitors of a dark matter cluster with more than 2000 particles:

    ```
    SELECT p.*
    FROM MDR1.FOFMtree AS p,(
        SELECT fofTreeId, lastProgId FROM MDR1.FOFMtree
        WHERE fofId=85000000000
    ) AS m
    WHERE p.fofTreeId BETWEEN m.fofTreeId AND m.lastProgId
    AND np>2000
    ORDER BY p.treeSnapnum;
    ```

* Get only the main progenitor for each timestep, add redshift zred from `TreeSnapnums`:

    ```
    SELECT p.fofId, p.x, p.y, p.z, p.mass, p.np, p.size, p.treeSnapnum, t.zred
    FROM MDR1.FOFMtree AS p,(
        SELECT fofTreeId, mainLeafId FROM MDR1.FOFMtree
        WHERE fofId=85000000000
    ) AS m, MDR1.TreeSnapnums AS t
    WHERE p.fofTreeId BETWEEN m.fofTreeId AND m.mainLeafId
    AND np>2000
    AND t.treeSnapnum = p.treeSnapnum
    ORDER BY p.treeSnapnum;
    ```
