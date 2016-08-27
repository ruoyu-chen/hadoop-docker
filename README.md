#基于Docker的Hadoop开发测试环境使用说明

## 内容安排
1. 基本软件环境介绍
2. 使用方法简介
3. 已知问题
4. 注意事项

## 1.基本软件环境介绍

- 操作系统: CentOS 6
- Java环境: OpenJDK 8
- Hadoop: 2.7.2
- Spark: 1.6.2
- Hive: 1.1.1
- HBase: 1.2.2
- Zookeeper: 3.4.8
- 基于docker-compose管理镜像和容器，并进行集群的编排
- 所有软件的二进制包均通过网络下载。其中包含自行编译的Hadoop和Protobuf二进制包，保存在Github上，其它软件的二进制包均使用Apache官方镜像。

## 2.使用方法简介

1. 镜像依赖关系图


![镜像依赖关系图](https://github.com/ruoyu-chen/hadoop-docker/raw/master/arch.jpg “镜像依赖关系图”)
	
    上图中，灰色的镜像（centos:6）为docker hub官方基础镜像。其它镜像（twinsen/hadoop:2.7.2等）都是在下层镜像的基础上实现的。
    这一镜像之间的依赖关系，决定了镜像的编译顺序

2. 构建镜像：

	根据上一节所述，可以在工程根目录下，依次使用下列命令构建镜像：
	
    - 构建基本操作系统和OpenJDK环境：
    
`docker-compose -f docker-compose-build-all.yml build os-jvm`


	- 构建hadoop环境：

`docker-compose -f docker-compose-build-all.yml build hadoop`

`docker-compose -f docker-compose-build-all.yml build hive`

`docker-compose -f docker-compose-build-all.yml build spark`

`docker-compose -f docker-compose-build-all.yml build hbase`


启动Hadoop集群：
1. 启动容器：
docker-compose -f docker-compose-hadoop.yml up -d hadoop-master

2. 第一次启动集群时，需要格式化namenode
docker-compose -f docker-compose-hadoop.yml exec hadoop-master hdfs namenode -format

3. 启动集群进程：
docker-compose -f docker-compose-hadoop.yml exec hadoop-master /root/scripts/start-hadoop.sh

停止Hadoop集群：
1. 停止集群进程：
docker-compose -f docker-compose-hadoop.yml exec hadoop-master /root/scripts/stop-hadoop.sh
2. 停止容器：
docker-compose -f docker-compose-hadoop.yml stop


启动Spark集群：
1. 启动容器：
docker-compose -f docker-compose-spark.yml up -d spark-master
2. 启动集群进程：
docker-compose -f docker-compose-spark.yml exec spark-master /root/scripts/start-hadoop.sh
docker-compose -f docker-compose-spark.yml exec spark-master /root/scripts/start-spark.sh

停止Hadoop集群：
1. 停止集群进程：
docker-compose -f docker-compose-spark.yml exec spark-master /root/scripts/stop-spark.sh
docker-compose -f docker-compose-spark.yml exec spark-master /root/scripts/stop-hadoop.sh
2. 停止容器：
docker-compose -f docker-compose-spark.yml stop

启动HBase集群
1. 创建集群专用网络，名为hadoop-docker
docker network create hadoop-docker 
2. 启动容器：
docker-compose -f docker-compose-hbase.yml up -d
3. 第一次启动集群时，需要格式化namenode
docker-compose -f docker-compose-hbase.yml exec hbase-master hdfs namenode -format
4. 启动HDFS进程：
docker-compose -f docker-compose-hbase.yml exec hbase-master start-dfs.sh
5. 启动Yarn进程：
docker-compose -f docker-compose-hbase.yml exec hbase-master start-yarn.sh
6. 启动HBase进程：
docker-compose -f docker-compose-hbase.yml exec hbase-master start-hbase.sh
7. 启动Spark进程：
docker-compose -f docker-compose-hbase.yml exec hbase-master start-all.sh

停止HBase集群：
1. 停止集群进程：
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-all.sh
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-hbase.sh
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-yarn.sh
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-dfs.sh

2. 停止容器：
docker-compose -f docker-compose-hbase.yml stop
或
docker-compose -f docker-compose-hbase.yml down
