#!/bin/bash
echo "启动HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
echo "启动YARN"
$HADOOP_HOME/sbin/start-yarn.sh