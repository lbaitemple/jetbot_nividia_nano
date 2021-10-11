sudo apt install python3-pip python3-pil python3-matplotlib -y
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev -y
sudo pip3 install Cython cython
sudo pip3 install numpy torch-1.9.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev -y
git clone https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
git checkout tags/v0.10.0
export BUILD_VERSION=0.10.0
sudo python3 setup.py install
sudo apt install python3-smbus curl cmake  -y
cd ~/jetbot
sudo python3 setup.py install
sudo pip3 install packaging
chmod +x jupyter.sh
./jupyter.sh

