import os
import sys

file_path = sys.argv[1]

with open(file_path, 'r') as file:
    file_data = file.read()

file_data = file_data.replace("${MASTER_NODE}", os.environ.get("MASTER_NODE"))
file_data = file_data.replace("${SLAVE_NODE}", os.environ.get("SLAVE_NODE"))
file_data = file_data.replace("${HADOOP_HOME}", os.environ.get("HADOOP_HOME"))
print(file_data)

with open(file_path, "w") as file:
    file.write(file_data)