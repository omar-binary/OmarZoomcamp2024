import pyspark
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .master("local[*]") \
    .appName('test') \
    .getOrCreate()

spark.version


filename = 'fhv_tripdata_2019-10.csv.gz'

schema = types.StructType([
    types.StructField('dispatching_base_num', types.StringType(), True),
    types.StructField('pickup_datetime', types.TimestampType(), True),
    types.StructField('dropOff_datetime', types.TimestampType(), True),
    types.StructField('PUlocationID', types.IntegerType(), True),
    types.StructField('DOlocationID', types.IntegerType(), True),
    types.StructField('SR_Flag', types.StringType(), True),
    types.StructField('Affiliated_base_number', types.StringType(), True),
])

df_fhv = spark.read \
    .option("header", "true") \
    .schema(schema) \
    .csv(filename)

# Print the schema
df_fhv.printSchema()

df_fhv = df_fhv.repartition(6)

df_fhv.write.parquet('fhv/2019/10/')

df_fhv.show()



df_fhv.registerTempTable('fhv_2019_10')

# Execute a SQL query using Spark SQL
spark.sql("""
SELECT COUNT(1)
FROM  fhv_2019_10
WHERE to_date(pickup_datetime) = '2019-10-15';
""").show()



df_zones = spark.read \
    .option("header", "true") \
    .csv('taxi_zone_lookup.csv')

df_zones.show()

df_zones = spark.read.parquet('zones/')
zone_counts.orderBy("count").show()