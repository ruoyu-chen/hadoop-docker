FROM centos:6

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

# 安装 OpenJDK和wget
RUN yum install -y java-1.8.0-openjdk-devel wget rsync && yum clean all

ENV JAVA_HOME=/usr/lib/jvm/java-openjdk

ENV PATH=$PATH:$JAVA_HOME/bin:.

CMD ["/bin/bash"]