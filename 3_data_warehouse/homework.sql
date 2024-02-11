-- # 1
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-240201.development.green_2022_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://de-zoomcamp-240201_development/green_2022/green_tripdata_2022-*.parquet']
);

CREATE OR REPLACE TABLE `development.green_2022` AS SELECT * FROM `development.green_2022_external`;

SELECT COUNT(*) FROM `development.green_2022`;

-- # 2
SELECT COUNT(DISTINCT(PULocationID)) FROM `development.green_2022_external`;
SELECT COUNT(DISTINCT(PULocationID)) FROM `development.green_2022`;

-- # 3
SELECT COUNT(fare_amount) 
  FROM `development.green_2022`
 WHERE fare_amount = 0;

-- # 4
CREATE OR REPLACE TABLE `development.green_2022_partitioned`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS (
  SELECT * FROM `development.green_2022`
);

-- # 5
SELECT DISTINCT(PULocationID)
  FROM  `development.green_2022`
 WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT(PULocationID) FROM  `development.green_2022_partitioned`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
