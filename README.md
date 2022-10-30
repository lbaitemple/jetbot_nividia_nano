# jetbot_nividia_nano
AWS Jetbot Setup

### cp image to SD card using etcher
https://www.balena.io/etcher/

#### download image (JetPack 4.5.1)  from Nivida
https://developer.nvidia.com/jetson-nano-2gb-sd-card-image
https://developer.nvidia.com/embedded/l4t/r32_release_v5.1/r32_release_v5.1/jeston_nano_2gb/jetson-nano-2gb-jp451-sd-card-image.zip

### setup ubuntu and wifi after you load in sd card
setup username as jetbot, system as jetbot, password as jetbot (or something else)
Find out the ip address
remote in using ssh jetbot@ipaddress

### Installl fan control github
```
cd ~
git clone https://github.com/Pyrestone/jetson-fan-ctl
cd jetson-fan-ctl
sudo ./install.sh
```

### Reboot and setup the rest of system
```
sudo apt update && sudo apt upgrade -y
sudo apt-get install libzmq3-dev  python3-smbus curl cmake -y
sudo apt install python3-pip python3-pil -y
sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x


sudo usermod -aG i2c $USER
sudo usermod -a -G video jetbot

cd ~
git clone  -b ros2 https://github.com/lbaitemple/jetbot_nvidia_nano/ jetbot
cd jetbot

bash ./install_torch.sh

bash ./jetbot_stats.sh

bash ./jupyter.sh

bash ./installros.sh
```


#### Get ROS robot working
```
sudo gpasswd -a $USER input
sudo -H python3 -m pip install inputs

cp -r ~/jetbot/aws/robot_ws/ ~/
cd ~/robot_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install

cat bashrc >> ~/.bashrc
```
You can open two terminal windows in jupter lab. For one terminal, you can 
```
turnon
```
For the other terminal, you can run logitech controller using
```
gamepad  
```
or run with waveshare controller using
```
gamepad gamepad_type:=waveshare
```


```
# for ros-melodic install:
sudo apt install python-rosdep
# for ros-noetic install: 
sudo apt install python3-rosdep

sudo rosdep init
rosdep update
```

### install opencv
```
sudo pip3 install opencv-python 
```

### optional: tensorflow (https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-nano/71770)
```
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip testresources setuptools==49.6.0
sudo pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow

```


## optional: install VNC
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

https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html, or download the image at https://drive.google.com/u/0/uc?id=1rssyP1Pl07JYUfPt6r9sqLIvqHXb6ZRm&export=download
