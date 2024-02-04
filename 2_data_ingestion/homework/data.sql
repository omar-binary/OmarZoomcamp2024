-- 1
SELECT count(*)
 FROM `mage.green_taxi`;

-- 2
SELECT count(*)
 FROM `mage.green_taxi`
 where passenger_count > 0 and trip_distance > 0;

-- 4
SELECT distinct VendorID
FROM  `mage.green_taxi`;

-- 6
SELECT count(distinct cast(lpep_pickup_datetime as date))
 FROM `mage.green_taxi`;
