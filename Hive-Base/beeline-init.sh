#! /bin/bash

source ../cluster-env.sh
beeline -u jdbc:hive2://$MASTER_NODE:10000