DROP SERVER IF EXISTS spider00;
CREATE SERVER spider00 FOREIGN DATA WRAPPER mysql
OPTIONS(HOST 'spider00', USER 'root', PORT 3306);

DROP SERVER IF EXISTS spider01;
CREATE SERVER spider01 FOREIGN DATA WRAPPER mysql
OPTIONS(HOST 'spider01', USER 'root', PORT 3306);

DROP SERVER IF EXISTS spider02;
CREATE SERVER spider02 FOREIGN DATA WRAPPER mysql
OPTIONS(HOST 'spider02', USER 'root', PORT 3306);

DROP SERVER IF EXISTS spider03;
CREATE SERVER spider03 FOREIGN DATA WRAPPER mysql
OPTIONS(HOST 'spider03', USER 'root',PORT 3306);

DROP SERVER IF EXISTS spider04;
CREATE SERVER spider04 FOREIGN DATA WRAPPER mysql
OPTIONS(HOST 'spider04', USER 'root', PORT 3306);
