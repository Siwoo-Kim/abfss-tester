FROM openjdk:8u272
WORKDIR app
RUN apt-get update \
    && apt-get install -y curl apt-utils wget unzip
RUN wget https://www-eu.apache.org/dist/spark/spark-2.4.7/spark-2.4.7-bin-without-hadoop.tgz
RUN wget https://www-eu.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
RUN tar -zxvf spark-2.4.7-bin-without-hadoop.tgz
RUN tar -zxvf hadoop-3.2.1.tar.gz

ENV HADOOP_HOME=./hadoop-3.2.1
ENV PATH=${HADOOP_HOME}/bin:${PATH}
ENV SPARK_DIST_CLASSPATH=$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*
ENV SPARK_HOME=./spark-2.4.7-bin-without-hadoop
ENV PATH=${SPARK_HOME}/bin:${PATH}
ENV HADOOP_SHELL_SCRIPT_DEBUG=true

#Debugging
RUN echo DEBUGGING! $HADOOP_HOME
RUN echo DEBUGGING! $SPARK_DIST_CLASSPATH
RUN echo DEBUGGING! $SPARK_HOME
RUN echo DEBUGGING! $PATH

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
COPY target/*.jar app.jar

COPY ./run.sh /
RUN chmod 755 /run.sh
ENTRYPOINT ["/run.sh"]
