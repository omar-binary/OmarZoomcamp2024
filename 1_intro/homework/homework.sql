-- 3
SELECT count(*)
FROM green_tripdata
WHERE lpep_pickup_datetime >= '2019-09-18'
  AND lpep_dropoff_datetime <= '2019-09-19'
