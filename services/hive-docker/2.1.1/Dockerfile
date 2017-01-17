FROM twinsen/hadoop:2.7.2

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

ENV HIVE_HOME=/root/hive

ENV PATH=$PATH:$HIVE_HOME/bin:.

#http://mirrors.hust.edu.cn/apache/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz

# 安装 Hive
RUN wget http://mirrors.hust.edu.cn/apache/hive/hive-2.1.1/apache-hive-2.1.1-bin.tar.gz && \
    tar -xzvf apache-hive-2.1.1-bin.tar.gz -C /root/ && \
    mv /root/apache-hive-2.1.1-bin $HIVE_HOME && \
    rm -rf apache-hive-2.1.1-bin.tar.gz && \
    rm -rf $HIVE_HOME/examples && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.40.tar.gz -C /root/ && \
    mv /root/mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar $HIVE_HOME/lib/ && \
    rm -rf /root/mysql-connector-java-5.1.40 && \
    rm -rf /root/mysql-connector-java-5.1.40.tar.gz
    
# 拷贝Hive配置文件
COPY config/* $HIVE_HOME/conf/

CMD ["/bin/bash"]