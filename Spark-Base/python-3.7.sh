sudo wget https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tgz
sudo apt-get install xz-utils
tar -xf Python-3.7.17.tgz
sudo apt update -y && apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev pkg-config make -y
cd Python-3.7.17
./configure --enable-optimizations --enable-shared
make -j 8
sudo make altinstall
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
echo "export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib" | sudo tee -a /Hadoop-Cluster-Setup/cluster-env.sh
sudo ln -s ./python /usr/bin/python3.7