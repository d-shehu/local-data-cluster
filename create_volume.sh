#!/bin/bash

# This file exists since we're using Docker managed volumes
# and not mounting / binds due to performance issues with
# MacOS.

cmd=$1

if [ "$cmd" == "create" ]
then
  docker volume create --name=hadoop_name
  docker volume create --name=hadoop_data_1
  docker volume create --name=hadoop_data_2
  docker volume create --name=hadoop_data_3
  docker volume create --name=hadoop_history
  docker volume create --name=hive_metastore_pg_data
  docker volume create --name=hue_pg_data
else
  docker volume rm hadoop_name
  docker volume rm hadoop_data_1
  docker volume rm hadoop_data_2
  docker volume rm hadoop_data_3
  docker volume rm hadoop_history
  docker volume rm hive_metastore_pg_data
  docker volume rm hue_pg_data
fi
