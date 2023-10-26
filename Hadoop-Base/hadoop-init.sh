#!/bin/bash

# This is just invoked as soon as the download and setup operations are already done in the whole cluster
hdfs namenode -format
start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver
yarn-daemon.sh start historyserver