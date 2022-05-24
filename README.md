# jetbot_nividia_nano
AWS Jetbot Setup

### cp image to SD card using etcher
https://www.balena.io/etcher/

#### download image (JetPack 4.5)  from Nivida
https://developer.nvidia.com/embedded/jetpack

https://developer.nvidia.com/jetson-nano-2gb-sd-card-image

### setup ubuntu and wifi after you load in sd card
setup username as jetbot, system as jetbot, password as jetbot (or something else)
Find out the ip address
remote in using ssh jetbot@ipaddress

### Installl fan control github
```
cd ~
git clone -b ece3432 https://github.com/Pyrestone/jetson-fan-ctl
cd jetson-fan-ctl
sudo ./install.sh
```

### add swap
```
git clone https://github.com/JetsonHacksNano/resizeSwapMemory
cd resizeSwapMemory
 ./setSwapMemorySize.sh -g 4
 sudo reboot
```

### Reboot and setup the rest of system
```
sudo apt update && sudo apt upgrade -y
```
If you see dpkg: error processing package nvidia-l4t-bootloader (--configure):
```
sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/backup/
sudo mkdir /var/lib/dpkg/info/
sudo apt-get update
sudo apt-get -f install
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/backup/
sudo rm -rf /var/lib/dpkg/info
sudo mv /var/lib/dpkg/backup/ /var/lib/dpkg/info/
sudo apt autoremove -y
```
```
sudo apt-get install libzmq3-dev  python3-smbus curl cmake -y
sudo apt install python3-pip python3-pil -y
 
sudo usermod -aG i2c $USER
sudo usermod -a -G video jetbot


cd ~
git clone  -b ece3432 https://github.com/lbaitemple/jetbot_nvidia_nano/ jetbot
cd jetbot

bash ./pytorch.sh

bash ./jetbot_stats.sh

bash ./jupyter.sh

bash ./install_ros.sh
sudo pip3 install imageio
sudo apt install python3-colcon-common-extensions  python3-rospkg -y
```
### change the kernal for v 4.5.1
```
sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/backup/
sudo mkdir /var/lib/dpkg/info/
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove
```
### Install tensorRT
```
sudo python3 -m pip install numpy
sudo apt-get install python3-libnvinfer-dev

dpkg -l | grep TensorRT
```

### Install torch2trt
```
cd ~
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd ~/torch2trt
sudo python3 setup.py install
```

```
# for ros-melodic install:
sudo apt install python-rosdep
# for ros-noetic install: 
sudo apt install python3-rosdep

sudo rosdep init
rosdep update
```

### D435

https://github.com/IntelRealSense/librealsense/releases
```
cd ~
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.49.0.zip
unzip v2.49.0.zip
cd ~/librealsense-2.49.0
CUDACXX=/usr/local/cuda-10.2/bin/nvcc
sudo apt-get install -y  libssl-dev libglfw3 libglfw3-dev libxinerama-dev libxcursor-dev

mkdir build
cd build
export PATH=$PATH:/usr/local/cuda-10.2/bin/

cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DBUILD_WITH_CUDA:bool=true
##cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=false -DBUILD_GRAPHICAL_EXAMPLES=false -DBUILD_WITH_CUDA:bool=true
##cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release -DFORCE_RSUSB_BACKEND=false -DBUILD_WITH_CUDA=true && make -j$(($(nproc)-1)) && sudo make install

make -j4
sudo make install

echo "export PATH=$PATH:~/.local/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/pyrealsense2" >> ~/.bashrc

cd ~/librealsense-2.49.0
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```
### install opencv
```
sudo pip3 install opencv-python 
```
#### Install jupyter lab
```
cd ~/
git clone https://github.com/lbaitemple/jetbot_nvidia_nano jetbot
cd ~/jetbot
sudo python3 setup.py install
sudo pip3 install packaging ipywidgets
chmod +x jupyter.sh
./jupyter.sh 
```

### add .bashrc
```
echo "export CUDA_HOME=/usr/local/cuda">> ~/.bashrc
echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64">> ~/.bashrc
echo "export PATH=$PATH:${CUDA_HOME}/bin">> ~/.bashrc

source ~/.bashrc
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
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip testresources setuptools==49.6.0
sudo pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow

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

