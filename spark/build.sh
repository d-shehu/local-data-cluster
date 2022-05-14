#!/bin/bash

tag=$1
if [ -z $tag ]
then
    tag="latest"
fi

targetArch=$2
if [ -z $targetArch ]
then
    targetArch=$(arch)
fi

pushd ./base
    $UTILS/build_docker.sh "data/spark_base" "$targetArch" $tag
popd
pushd ./master
    $UTILS/build_docker.sh "data/spark_master" "$targetArch" $tag
popd
pushd ./worker
    $UTILS/build_docker.sh "data/spark_worker" "$targetArch" $tag
popd
