FROM centos:6

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

ENV JAVA_HOME=/usr/lib/jdk8

ENV PATH=$PATH:$JAVA_HOME/bin:.

# 安装 wget,rsync
# 设置系统时区为北京时间（实际为Asia/Shanghai）

RUN yum install -y wget rsync\
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz \
    && tar -xzvf jdk-8u101-linux-x64.tar.gz -C /usr/lib/ \
    && mv /usr/lib/jdk1.8.0_101 $JAVA_HOME \
    && rm -rf jdk-8u101-linux-x64.tar.gz $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man $JAVA_HOME/jre \
    && yum clean all \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/bin/bash"]