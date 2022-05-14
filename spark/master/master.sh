#!/bin/bash

export SPARK_MASTER_HOST=${SPARK_MASTER_HOST:-`hostname`}

export SPARK_HOME=/spark

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_MASTER_LOG

ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

# TODO: make this a bit more robust by running with supervisor
echo "Starting the Livy server"
echo "livy.spark.master = spark://spark-master:17077" >> /livy/conf/livy.conf
/livy/bin/livy-server start &

echo "Starting the Spark coordinator server"
cd /spark/bin && /spark/sbin/../bin/spark-class org.apache.spark.deploy.master.Master \
    --ip $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_MASTER_LOG/spark-master.out
