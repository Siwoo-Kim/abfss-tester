#!/bin/bash
$SPARK_HOME/bin/spark-submit --class com.siwoo.abfs.SparkyAbfs  \
  --master local  \
  --packages io.delta:delta-core_2.11:0.6.0  \
  app.jar "YOUR STORAGE" "YOUR ACCOUNT KEY"