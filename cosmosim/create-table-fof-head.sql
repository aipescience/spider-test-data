DROP TABLE IF EXISTS `FOF`;
CREATE TABLE `FOF` (
    `fofId` BIGINT,
    `snapnum` INT,
    `level` INT,
    `NInFile` INT,
    `x` DOUBLE,
    `y` DOUBLE,
    `z` DOUBLE,
    `vx` DOUBLE,
    `vy` DOUBLE,
    `vz` DOUBLE,
    `np` INT,
    `mass` DOUBLE,
    `size` DOUBLE,
    `ix` INT,
    `iy` INT,
    `iz` INT,
    `phkey` BIGINT
)
ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "FOF"'
PARTITION BY HASH(fofId) (
    PARTITION pt1 COMMENT = 'srv "spider01"',
    PARTITION pt2 COMMENT = 'srv "spider02"',
    PARTITION pt3 COMMENT = 'srv "spider03"',
    PARTITION pt4 COMMENT = 'srv "spider04"'
);
