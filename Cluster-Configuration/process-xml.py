import os
import sys

file_path = sys.argv[1]

with open(file_path, 'r') as file:
    file_data = file.read()

env_list = [(env, value) for env, value in os.environ.items()]

for env_var in env_list:
    file_data = file_data.replace("${" + f'{env_var[0]}' + "}", env_var[1])

with open(file_path, "w") as file:
    file.write(file_data)