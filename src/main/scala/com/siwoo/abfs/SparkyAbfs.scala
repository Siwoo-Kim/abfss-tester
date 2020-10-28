package com.siwoo.abfs

import org.apache.spark.sql.SparkSession

object SparkyAbfs {

    def getSparkSession(args: Array[String]): SparkSession = {
        //az storage account list -g $resource_group -o table
        //az storage account show-connection-string -n $storage
        val storageAccount = args(0)
        val accountKey = args(1)
        val spark = SparkSession.builder()
                .master("local[*]")
                .appName("sparkyabfs")
                .getOrCreate()
        spark.conf.set(s"fs.azure.account.key.${storageAccount}.dfs.core.windows.net", accountKey)
        spark
    }

    def main(args: Array[String]): Unit = {
        val storageAccount = args(0)
        val accountKey = args(1)
        val spark = getSparkSession(args)
        val df = spark.read
                .format("delta")
                .load(s"abfss://logs@${storageAccount}.dfs.core.windows.net/delta_files/orgUUID=0027F8E9-F41C-4141-9831-E23B13A74BA1/timeBucket=2019_01")
        df.show()
    }
}
