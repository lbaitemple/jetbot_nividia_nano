# jetbot_nividia_nano
AWS Jetbot Setup

#### download image (JetPack 4.5)  from Nivida
https://developer.nvidia.com/jetson-nano-2gb-sd-card-image

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
pip3 install Cython
pip3 install numpy torch-1.7.0-cp36-cp36m-linux_aarch64.whl
```
### torchvision
```
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev -y
git clone https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
git checkout tags/v0.8.1
export BUILD_VERSION=0.8.1
python3 setup.py install --user
```

#### Install traitlets (master, to support the unlink() method)
```
sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x
```
#### Install jupyter lab
