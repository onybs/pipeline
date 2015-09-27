cd $PIPELINE_HOME
echo '...Building and Packaging Streaming App...'
sbt streaming/package

echo '...Starting Spark Ratings Streaming App...'
nohup spark-submit --packages org.apache.spark:spark-streaming-kafka-assembly_2.10:1.4.1,org.elasticsearch:elasticsearch-spark_2.10:2.1.0,com.datastax.spark:spark-cassandra-connector_2.10:1.4.0,redis.clients:jedis:2.7.3 --class com.fluxcapacitor.pipeline.spark.streaming.StreamingRatings $PIPELINE_HOME/streaming/target/scala-2.10/streaming_2.10-1.0.jar 2>&1 1>~/pipeline/logs/streaming/streaming-ratings-out.log &
echo '...logs available with tail -f ~/pipeline/logs/streaming/streaming-ratings-out.log...'
