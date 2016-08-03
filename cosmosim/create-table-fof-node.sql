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
ENGINE=ARIA DEFAULT CHARSET=latin1;
