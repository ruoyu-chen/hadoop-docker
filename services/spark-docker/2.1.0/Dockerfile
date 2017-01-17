FROM twinsen/hive:2.1.1

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

#设置环境变量
ENV SPARK_HOME=/root/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:.

#安装spark 2.1.0
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-without-hadoop.tgz && \
    tar -xzvf spark-2.1.0-bin-without-hadoop.tgz -C /root/ && \
    mv /root/spark-2.1.0-bin-without-hadoop $SPARK_HOME && \
    rm -rf spark-2.1.0-bin-without-hadoop.tgz && \
    rm -rf $SPARK_HOME/bin/*.cmd && \
    rm -rf $SPARK_HOME/sbin/*.cmd && \
    rm -rf $SPARK_HOME/ec2 && \
    rm -rf $SPARK_HOME/examples && \
    rm -rf $SPARK_HOME/lib/spark-examples-*

#拷贝Spark配置文件
COPY config/spark/* $SPARK_HOME/conf/

CMD [ "sh", "-c", "service sshd start; bash"]