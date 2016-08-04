CREATE TABLE `gaussian` (
    `id` BIGINT,
    `x` DOUBLE,
    `y` DOUBLE
)
ENGINE=SPIDER DEFAULT CHARSET=latin1 COMMENT='wrapper "mysql", table "gaussian"'
PARTITION BY HASH(id) (
    PARTITION pt1 COMMENT = 'srv "spider01"',
    PARTITION pt2 COMMENT = 'srv "spider02"',
    PARTITION pt3 COMMENT = 'srv "spider03"',
    PARTITION pt4 COMMENT = 'srv "spider04"'
);
