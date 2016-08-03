use MDR1;
DROP TABLE IF EXISTS `TreeSnapnums`;
CREATE TABLE `TreeSnapnums` (
	treeSnapnum int not null, 
	snapnum int not null, 
	aexp float not null, 
	zred float not null
) ENGINE=ARIA;
