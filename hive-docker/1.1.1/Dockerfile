FROM twinsen/hadoop:2.7.2

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

ENV HIVE_HOME=/root/hive

ENV PATH=$PATH:$HIVE_HOME/bin:.

#http://mirrors.cnnic.cn/apache/hive/hive-1.1.1/apache-hive-1.1.1-bin.tar.gz
#https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-1.1.1/apache-hive-1.1.1-bin.tar.gz
#http://mirrors.hust.edu.cn/apache/hive/hive-1.1.1/apache-hive-1.1.1-bin.tar.gz

# 安装 Hive
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-1.1.1/apache-hive-1.1.1-bin.tar.gz && \
    tar -xzvf apache-hive-1.1.1-bin.tar.gz -C /root/ && \
    mv /root/apache-hive-1.1.1-bin $HIVE_HOME && \
    rm -rf apache-hive-1.1.1-bin.tar.gz && \
    rm -rf $HIVE_HOME/examples && \
    wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.39.tar.gz -C /root/ && \
    mv /root/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar $HIVE_HOME/lib/ && \
    rm -rf /root/mysql-connector-java-5.1.39
    

# 拷贝Hive配置文件
COPY config/* $HIVE_HOME/conf/

CMD ["/bin/bash"]