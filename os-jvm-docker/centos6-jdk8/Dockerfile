FROM centos:6

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

WORKDIR /root

ENV JAVA_HOME=/usr/lib/jdk8

# 安装 wget
RUN yum install -y wget \
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz \
    && tar -xzvf jdk-8u101-linux-x64.tar.gz -C /usr/lib/ \
    && ln -s /usr/lib/jdk1.8.0_101 $JAVA_HOME \
    && rm -rf jdk-8u101-linux-x64.tar.gz $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man \
    && yum clean all

ENV PATH=$PATH:$JAVA_HOME/bin:.

CMD ["/bin/bash"]