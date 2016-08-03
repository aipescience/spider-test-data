use MDR1;
DROP TABLE IF EXISTS `FOFMtree`;
CREATE TABLE FOFMtree (
	fofTreeId bigint not null,
	fofId bigint not null,
	treeSnapnum smallint not null,
	descendantId bigint not null,
	lastProgId bigint not null,
	mainLeafId bigint not null,
	treeRootId bigint not null,
	x real not null,
	y real not null,
	z real not null,
	vx real not null,
	vy real not null,
	vz real not null,
	np int not null,
	mass real not null,
	size real not null,
	spin real not null,
	ix int not null,
	iy int not null,
	iz int not null,
	phkey int not null
) ENGINE=ARIA;
