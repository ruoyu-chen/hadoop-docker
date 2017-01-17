FROM twinsen/spark:1.6.2

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

ENV HBASE_HOME=/root/hbase
ENV PATH=$PATH:.:$HBASE_HOME/bin

# 1. 安装 HBase 1.2.2
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/1.2.2/hbase-1.2.2-bin.tar.gz && \
	tar -xzvf hbase-1.2.2-bin.tar.gz -C /root/ && \
    mv /root/hbase-1.2.2 $HBASE_HOME && \
	rm -rf hbase-1.2.2-bin.tar.gz && \
	rm -rf $HBASE_HOME/bin/*.cmd && \
	rm -rf $HBASE_HOME/docs && \
	rm -rf $HBASE_HOME/conf/*.cmd
	

# 拷贝HBase配置文件
ADD config/hbase/* $HBASE_HOME/conf/

# 使用HBase下的Hadoop配置替换原始Hadoop配置文件
ADD config/hadoop/* $HADOOP_CONF_DIR/

# 使用HBase下的Spark配置替换原始Spark配置文件
COPY config/spark/* $SPARK_HOME/conf/

CMD [ "sh", "-c", "service sshd start; bash"]