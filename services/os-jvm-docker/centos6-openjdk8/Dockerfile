FROM centos:6

MAINTAINER twinsen <ruoyu-chen@foxmail.com>

USER root

ENV JAVA_HOME=/usr/lib/jvm/java-openjdk

ENV PATH=$PATH:$JAVA_HOME/bin:.

# 安装 OpenJDK, wget, rsync
# 设置系统时区为北京时间（实际为Asia/Shanghai）
RUN yum install -y java-1.8.0-openjdk-devel wget rsync && yum clean all && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/bin/bash"]