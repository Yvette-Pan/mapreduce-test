#!/bin/sh
echo 'Type in your time range: ' $1
../../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../mapreduce-test-data/access.log /logstat_lab1/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../mapreduce-test-python/logstat_lab1/mapper_p2.py -mapper "../../mapreduce-test-python/logstat_lab1/mapper_p2.py $1" \
-file ../../mapreduce-test-python/logstat_lab1/reducer_p2.py -reducer ../../mapreduce-test-python/logstat_lab1/reducer_p2.py \
-input /logstat_lab1/input/* -output /logstat_lab1/output/
/usr/local/hadoop/bin/hdfs dfs -cat /logstat_lab1/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /logstat_lab1/output/
../../stop.sh
