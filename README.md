# jetbot_nividia_nano
AWS Jetbot Setup

#### download image (JetPack 4.5)  from Nivida
https://developer.nvidia.com/jetson-nano-2gb-sd-card-image

https://developer.nvidia.com/jetson-nano-sd-card-image-45-0

https://developer.nvidia.com/embedded/jetpack-archive

https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/jeston_nano/jetson-nano-jp46-sd-card-image.zip [tensorrt 8 has some problems, not recommend to install it now]

### cp image to SD card using etcher
https://www.balena.io/etcher/


### setup ubuntu and wifi after you load in sd card
setup username as jetbot, system as jetbot, password as jetbot (or something else)
Find out the ip address
remote in using ssh jetbot@ipaddress

### Installl fan control github (make the fan running)
```
git clone https://github.com/Pyrestone/jetson-fan-ctl
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
##
```
sudo apt update && sudo apt upgrade -y
sudo usermod -aG i2c $USER
sudo apt-get update
sudo apt install python3-pip python3-pil python3-matplotlib -y
```

### torch (https://qengineering.eu/install-pytorch-on-jetson-nano.html if you want to upgrade to 1.9)
https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-9-0-now-available/72048

```
wget https://nvidia.box.com/shared/static/h1z9sw4bb1ybi0rm3tu8qdj8hs05ljbm.whl -O torch-1.9.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev -y
sudo pip3 install Cython cython
sudo pip3 install numpy torch-1.9.0-cp36-cp36m-linux_aarch64.whl
```
### torchvision
```
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev -y
git clone https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
git checkout tags/v0.10.0
export BUILD_VERSION=0.10.0
sudo python3 setup.py install
```

### install torch2trt
```
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd torch2trt
sudo python3 setup.py install
```
#### Install Realsense
```
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.49.0.zip

```
#### Install jupyter lab
```
cd ~/
sudo apt install python3-smbus curl cmake  -y
git clone -b tensorrt_torch https://github.com/lbaitemple/jetbot_nvidia_nano jetbot
cd ~/jetbot
sudo python3 setup.py install
sudo pip3 install packaging
chmod +x jupyter.sh
./jupyter.sh 
```

#### jupter lab ros
```
sudo pip3 install jupyter_packaging
git clone https://github.com/RoboStack/jupyter-ros.git
cd jupyter-ros
sudo pip3 install -e .
sudo pip3 install numpy==1.19.4
jupyter nbextension install --py --symlink --sys-prefix jupyros
jupyter nbextension enable --py --sys-prefix jupyros
```
In the notebook, you will need to include
```
import sys
sys.path.append('/opt/ros/melodic/lib/python2.7/dist-packages/')
```
### add webrviz (https://github.com/osrf/rvizweb)

```
mkdir -p ~/ws/src
cd ~/ws/src
git clone https://github.com/osrf/rvizweb/

curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -

cd ~/ws
rosdep install --from-paths src --ignore-src -r -y

cd ~/ws
catkin_make install 

source ~/ws/install/setup.bash
roslaunch rvizweb rvizweb.launch
```
http://localhost:8001/rvizweb/www/index.html

### Deep camera [Astra]
```
mkdir tmp
cd tmp
wget https://dl.orbbec3d.com/dist/astra/v2.1.3/AstraSDK-v2.1.3-Linux-arm.zip
unzip AstraSDK-v2.1.3-Linux-arm.zip 
gunzip -c AstraSDK-v2.1.3-94bca0f52e-20210611T023312Z-Linux-aarch64.tar.gz  | tar -xvf -
cd AstraSDK-v2.1.3-94bca0f52e-20210611T023312Z-Linux-aarch64/install 
chmod +x ./install.sh
sudo ./install.sh
 echo "export ASTRA_SDK_INCLUDE=/home/jetbot/tmp/AstraSDK-v2.1.3-94bca0f52e-20210611T023312Z-Linux-aarch64/install/include
> export ASTRA_SDK_LIB=/home/jetbot/tmp/AstraSDK-v2.1.3-94bca0f52e-20210611T023312Z-Linux-aarch64/install/lib" >> ~/.bashrc
```
### install openNI [Astra - using deep required]
```
cd ~/tmp
wget https://dl.orbbec3d.com/dist/openni2/OpenNI_2.3.0.66.zip
unzip OpenNI_2.3.0.66.zip
cd Linux/OpenNI-Linux-Arm64-2.3.0.66
chmod +x ./install.sh
sudo ./install.sh
source OpenNIDevEnvironment
cmake -DWITH_OPENNI2=ON ..
```


####

```
sudo apt install -y python3-skimage  python3-skimage-lib
sudo apt-get install python3-opencv -y
sudo apt install protobuf-c-compiler protobuf-compiler   libprotobuf-dev  -y
sudo pip3 install scikit-build opencv-python 
sudo pip3 install albumentations==0.4.5
sudo pip3 install torchvision --upgrade
sudo pip3 install onnx
```

```
sudo python3 -m pip install --upgrade pip
git clone https://github.com/skvark/opencv-python.git
cd opencv-python
sudo python3 setup.py install
```

### add .bashrc
```
echo "export CUDA_HOME=/usr/local/cuda">> ~/.bashrc
echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64">> ~/.bashrc
echo "export PATH=$PATH:${CUDA_HOME}/bin">> ~/.bashrc

source ~/.bashrc
```

```
sudo apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install -y python3-pip
sudo pip3 install -U pip testresources setuptools==49.6.0
sudo pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow

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



### Install GPIO (https://github.com/NVIDIA/jetson-gpio)

#### Add google coral (https://coral.ai/models/semantic-segmentation/)
1. install the driver
```
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install libedgetpu1-std -y
```
2. Install pycoral
```
sudo python3 -m pip install --extra-index-url https://google-coral.github.io/py-repo/ pycoral~=2.0
```
3. Convert tensorflow lite model to edgetpu lite model using webinterface (https://colab.research.google.com/github/google-coral/tutorials/blob/master/compile_for_edgetpu.ipynb)


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
sudo apt install python-catkin-pkg -y
sudo apt install python-rosdep -y
# for ros-noetic install: 
sudo apt install python3-catkin-pkg -y
sudo apt install python3-rosdep -y

sudo rosdep init
rosdep update
```

### Install (https://github.com/orbbec/ros_astra_camera)

Find serial number
```
rs-fw-update -l
```
Easier instruction available at (https://github.com/natashasaki/IntelRealSense_for_SLAM) to install ROS, or following the commands below
```
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
source devel/setup.bash
cd ~/catkin_ws/src
git clone https://github.com/orbbec/ros_astra_camera
roscd astra_camera
sudo apt install ros-melodic-libuvc-camera ros-melodic-web-video-server ros-melodic-openni2-launch  -y
./scripts/create_udev_rules
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin_make --pkg astra_camera

source devel/setup.bash
roslaunch astra_camera astrapro.launch
rosrun web_video_server web_video_server 
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

### Install Zed mini (need Jetpack 4.5)
```
wget https://download.stereolabs.com/zedsdk/3.5/jp45/jetsons -O ZED_SDK_Tegra_JP45_v3.5.5.run
chmod +x ZED_SDK_Tegra_JP45_v3.5.5.run
./ZED_SDK_Tegra_JP45_v3.5.5.run
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

### Realsensor

Download  https://github.com/IntelRealSense/librealsense/releases/ 
```
cd ~
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.49.0.zip
unzip v2.49.0.zip
cd ~/librealsense-2.49.0
CUDACXX=/usr/local/cuda-10.2/bin/nvcc
mkdir build
cd build
export PATH=$PATH:/usr/local/cuda-10.2/bin/
cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true
make -j4
sudo make install

echo "export PATH=$PATH:~/.local/bin
> export PYTHONPATH=$PYTHONPATH:/usr/local/lib
> export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/pyrealsense2" >> ~/.bashrc

cd ~/librealsense-2.49.0
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
realsense-viewer
```

### VNC
```
cd /usr/lib/systemd/user/graphical-session.target.wants
sudo ln -s ../vino-server.service ./.
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false

# Replace thepassword with your desired password
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino vnc-password $(echo -n 'thepassword'|base64)

sudo reboot
```
