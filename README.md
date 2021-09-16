# jetbot_nividia_nano
AWS Jetbot Setup

#### download image (JetPack 4.5)  from Nivida
https://developer.nvidia.com/jetson-nano-2gb-sd-card-image

https://developer.nvidia.com/jetson-nano-sd-card-image-45-0

https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/jeston_nano/jetson-nano-jp46-sd-card-image.zip [tensorrt 8 has some problems, not recommend to install it now]

### cp image to SD card using etcher
https://www.balena.io/etcher/


### setup ubuntu and wifi after you load in sd card
setup username as jetbot, system as jetbot, password as jetbot (or something else)
Find out the ip address
remote in using ssh jetbot@ipaddress

##
```
sudo apt update && sudo apt upgrade -y
sudo usermod -aG i2c $USER
sudo apt-get update
sudo apt install python3-pip python3-pil -y

```

### torch

```
wget https://nvidia.box.com/shared/static/cs3xn3td6sfgtene6jdvsxlr366m2dhq.whl -O torch-1.7.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev -y
sudo pip3 install Cython cython
sudo pip3 install numpy torch-1.7.0-cp36-cp36m-linux_aarch64.whl
```
### torchvision
```
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev -y
git clone https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
git checkout tags/v0.8.1
export BUILD_VERSION=0.8.1
sudo python3 setup.py install --user
```

### install opencv
```
sudo pip3 install opencv-python 
```
#### Install jupyter lab
```
cd ~/
sudo apt install python3-smbus curl cmake -y
git clone https://github.com/lbaitemple/jetbot_nvidia_nano
mv jetbot_nvidia_nano jetbot
cd ~/jetbot
sudo python3 setup.py install
chmod +x jupyter.sh
./jupyter.sh 
```

##### If not successfully run, please use the following commands
```
cd ~/jetbot/jetbot/utils
python3 create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo systemctl enable jetbot_stats
sudo systemctl start jetbot_stats
python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter
sudo systemctl start jetbot_jupyter
```

### Installl fan control github
```
git clone https://github.com/Pyrestone/jetson-fan-ctl
cd jetson-fan-ctl
sudo ./install.sh
```

### Install GPIO (https://github.com/NVIDIA/jetson-gpio)


### add .bashrc
```
echo "export CUDA_HOME=/usr/local/cuda">> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64">> ~/.bashrc
echo "export PATH=$PATH:$CUDA_HOME/bin">> ~/.bashrc
```
### Install Lidar
```
git clone https://github.com/YDLIDAR/YDLidar-SDK
cd YDLidar-SDK
sudo apt install swig -y
sudo python3 setup.py install
cd startup
sudo ./initenv.sh

```
### tensorflow (https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-nano/71770)
```
sudo apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip -y
sudo pip3 install -U pip testresources setuptools==49.6.0 
sudo pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
#sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow
#sudo pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu==1.13.1+nv19.3
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 'tensorflow<2'
#sudo pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v$JP_VERSION tensorflow
```

### Install ROS
```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
sudo apt install ros-melodic-desktop-full -y
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

```
# for ros-melodic install:
sudo apt install python-rosdep
# for ros-noetic install: 
sudo apt install python3-rosdep

sudo rosdep init
rosdep update
```
#### Install traitlets (master, to support the unlink() method)
```
sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x
```

### Edimax Wifi Adapter (wih intenret connected first)
```
wget https://www.edimax.com/edimax/mw/cufiles/files/download/Driver_Utility/EW-7811Un_V2_Linux_Driver_1.0.0.3.zip
unzip EW-7811Un_V2_Linux_Driver_1.0.0.3.zip 
cd EW-7811Un_V2_Linux_Driver_1.0.0.3/
tar xvf rtl8188EUS_linux_v5.3.9_28540.20180627.tar.gz 
cd rtl8188EUS_linux_v5.3.9_28540.20180627/

# The next line is important
export ARCH=arm64
make
sudo make install
sudo reboot now
```

## install VNC
https://jinyaozhu.github.io/linux/2019/05/16/vnc.html

### update cmake (https://cmake.org/download/)
```
sudo apt remove cmake
sudo wget https://github.com/Kitware/CMake/releases/download/v3.21.2/cmake-3.21.2-linux-aarch64.sh -O /opt/cmake-3.21.2-linux-aarch64.sh
sudo chmod +x /opt/cmake-3.21.2-linux-aarch64.sh
cd /opt
sudo bash ./cmake-3.21.2-linux-aarch64.sh
sudo ln -s /opt/cmake-3.21.2-linux-aarch64/bin/* /usr/local/bin
cmake --verson
```


### Running docker (https://blog.tensorflow.org/2021/01/leveraging-tensorflow-tensorrt-integration.html)
https://developer.nvidia.com/blog/speeding-up-deep-learning-inference-using-tensorrt-updated/
```
sudo usermod -aG docker jetbot
newgrp docker
docker pull tensorflow/tensorflow:latest-gpu
```

