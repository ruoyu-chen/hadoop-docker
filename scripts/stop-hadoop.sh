#!/bin/bash
echo "停止YARN"
$HADOOP_HOME/sbin/stop-yarn.sh
echo "停止HDFS"
$HADOOP_HOME/sbin/stop-dfs.sh