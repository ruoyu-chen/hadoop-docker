#基于Docker的Hadoop开发测试环境使用说明

## 0.内容
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

###1. 镜像依赖关系
![镜像依赖关系图](https://github.com/ruoyu-chen/hadoop-docker/raw/master/arch.jpg "镜像依赖关系")
上图中，灰色的镜像（centos:6）为docker hub官方基础镜像。其它镜像（twinsen/hadoop:2.7.2等）都是在下层镜像的基础上实现的。这一镜像之间的依赖关系，决定了镜像的编译顺序.

###2. 构建镜像
根据上一节所述，可以在工程根目录下，依次使用下列命令构建镜像：
	
- 构建基本操作系统和OpenJDK环境，包含CentOS 6和OpenJDK 8
    
`docker-compose -f docker-compose-build-all.yml build os-jvm`

- 构建Hadoop环境，包含Hadoop 2.7.2，并已启用SSHD服务 

`docker-compose -f docker-compose-build-all.yml build hadoop`

- 构建Hive环境，包含Hive 1.1.1，同时依赖于MySQL 5.7

`docker-compose -f docker-compose-build-all.yml build hive`

- 构建Spark环境，包含Spark 1.6.2

`docker-compose -f docker-compose-build-all.yml build spark`

- 构建HBase环境，包含HBase 1.2.2

`docker-compose -f docker-compose-build-all.yml build hbase`
###3. 启动、关闭集群服务

####1. Hadoop集群

- 启动容器
    
<pre><code>docker-compose -f docker-compose-hadoop.yml up -d</code></pre>
	
- 第一次启动集群时，需要格式化namenode

<pre><code>docker-compose -f docker-compose-hadoop.yml exec hadoop-master hdfs namenode -format</code></pre>

- 启动集群进程，依次执行：

<pre><code>
#[启动HDFS]
docker-compose -f docker-compose-hadoop.yml exec hadoop-master start-dfs.sh
#[启动YARN]
docker-compose -f docker-compose-hadoop.yml exec hadoop-master start-yarn.sh
</code></pre>

- 停止Hadoop集群，依次执行：

<pre><code>
#[停止YARN]
docker-compose -f docker-compose-hadoop.yml exec hadoop-master stop-yarn.sh
#[停止HDFS]
docker-compose -f docker-compose-hadoop.yml exec hadoop-master stop-dfs.sh
#[停止容器]
docker-compose -f docker-compose-hadoop.yml stop</code></pre>

####2. Spark集群
- 启动容器

<pre><code>docker-compose -f docker-compose-spark.yml up -d</code></pre>

- 启动集群进程，依次执行：

<pre><code>
#[启动HDFS]
docker-compose -f docker-compose-spark.yml exec spark-master start-dfs.sh
[启动YARN]
docker-compose -f docker-compose-spark.yml exec spark-master start-yarn.sh
[启动Spark]
docker-compose -f docker-compose-spark.yml exec spark-master start-all.sh
</code></pre>

- 停止Spark集群，依次执行：

<pre><code>
#[停止Spark]
docker-compose -f docker-compose-spark.yml exec spark-master stop-all.sh
#[停止YARN]
docker-compose -f docker-compose-spark.yml exec spark-master stop-yarn.sh
#[停止HDFS]
docker-compose -f docker-compose-spark.yml exec spark-master stop-dfs.sh
#[停止容器]
docker-compose -f docker-compose-spark.yml stop</code></pre>

####3. HBase集群

- 创建集群专用网络，名为hadoop-docker

<pre><code>docker network create hadoop-docker</code></pre>

- 启动容器：

<pre><code>docker-compose -f docker-compose-hbase.yml up -d</code></pre>

- 第一次启动集群时，需要格式化namenode

<pre><code>docker-compose -f docker-compose-hbase.yml exec hbase-master hdfs namenode -format</code></pre>

- 启动集群进程，依次执行：

<pre><code>
#[启动HDFS]
docker-compose -f docker-compose-hbase.yml exec hbase-master start-dfs.sh
#[启动HBase]
docker-compose -f docker-compose-hbase.yml exec hbase-master start-hbase.sh
</code></pre>


此外还可以按照需要启动YARN，SPARK

<pre><code>
#[启动YARN]
docker-compose -f docker-compose-hbase.yml exec hbase-master start-yarn.sh
#[启动Spark]
docker-compose -f docker-compose-spark.yml exec spark-master start-all.sh</code></pre>

- 停止HBase集群：

<pre><code>
#[停止SPARK]
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-all.sh
#[停止HBase]
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-hbase.sh
#[停止YARN]
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-yarn.sh
#[停止HDFS]
docker-compose -f docker-compose-hbase.yml exec hbase-master stop-dfs.sh
#[停止容器]
docker-compose -f docker-compose-hbase.yml stop
</code></pre>

####4. 开发与测试过程中的集群使用方法

目前集群中采用的是1个master节点和3个slave节点的分配方案，可以通过调整docker-compose配置文件以及相应软件的配置文件来实现集群扩容，暂时无法做到自动化扩容。

编写程序可以使用任意的IDE和操作系统，程序编写完成后，打包为jar文件，然后放在./volume/code/目录下。任何一个集群环境下，都在集群启动时将code目录挂载在master节点的/code路径下。

以Hadoop为例，如果要执行wordcount程序（在volume/code/tests/mapreduce-test目录下已经包含了）。在启动集群并启动各服务进程后。执行下列语句，可以进入master节点的命令行环境：

<pre><code>docker-compose -f docker-compose-hadoop.yml exec hadoop-master /bin/bash
</code></pre>

然后可以进入/code目录提交任务，完成计算。如下图所示：
![命令行环境下提交任务](https://github.com/ruoyu-chen/hadoop-docker/raw/master/submitJob.png)
##3.已知问题

待完善
##4.注意事项

待完善
