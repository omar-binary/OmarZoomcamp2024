-- 1
CREATE MATERIALIZED VIEW trip_mv_stats AS

with prep as (
select (tpep_dropoff_datetime - tpep_pickup_datetime) as time_diff
     , zp.zone as pickup_zone
     , zd.zone as dropoff_zone
from trip_data t
left join taxi_zone zp
   on t.pulocationid = zp.location_id
left join taxi_zone zd
   on t.dolocationid = zd.location_id
)
select pickup_zone
     , dropoff_zone
     , min(time_diff) as min_time_diff
     , max(time_diff) as max_time_diff
     , avg(time_diff) as avg_time_diff
from prep
group by 1, 2;

select *
from trip_mv_stats
order by avg_time_diff desc
limit 1

-- 2
CREATE MATERIALIZED VIEW trip_mv_with_count AS
SELECT zp.zone AS pickup_zone,
    zd.zone AS dropoff_zone,
    COUNT(*) AS num_trips,
    AVG(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))) AS avg_trip_time,
    MIN(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))) AS min_trip_time,
    MAX(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))) AS max_trip_time
FROM trip_data td
LEFT JOIN taxi_zone zp ON td.pulocationid = zp.location_id
LEFT JOIN taxi_zone zd ON td.dolocationid = zd.location_id
GROUP BY zp.zone, zd.zone;

SELECT 
    pickup_zone,
    dropoff_zone,
    num_trips,
    avg_trip_time
FROM trip_mv_with_count
ORDER BY avg_trip_time DESC
LIMIT 1;

-- 3
SELECT tz.zone AS pickup_zone
     , COUNT(*) AS num_pickups
FROM trip_data td
left JOIN taxi_zone tz ON td.pulocationid = tz.location_id
WHERE td.tpep_pickup_datetime >= (SELECT MAX(tpep_pickup_datetime) - INTERVAL '17 hours' FROM trip_data)
  AND td.tpep_pickup_datetime <= (SELECT MAX(tpep_pickup_datetime) FROM trip_data)
GROUP BY tz.zone
ORDER BY num_pickups DESC
LIMIT 3;