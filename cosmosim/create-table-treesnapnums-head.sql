use MDR1;
DROP TABLE IF EXISTS `TreeSnapnums`;
CREATE TABLE `TreeSnapnums` (
	treeSnapnum int not null, 
	snapnum int not null, 
	aexp float not null, 
	zred float not null
)
ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "TreeSnapnums"'
PARTITION BY HASH(treeSnapnum) (
    PARTITION pt1 COMMENT = 'srv "spider01"',
    PARTITION pt2 COMMENT = 'srv "spider02"',
    PARTITION pt3 COMMENT = 'srv "spider03"',
    PARTITION pt4 COMMENT = 'srv "spider04"'
);
