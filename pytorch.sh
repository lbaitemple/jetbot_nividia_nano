#!/bin/bash
# Animesh Bala Ani (ANI717)

# exit immediately if a command exits with a non-zero status.
set -e

# record script start time
date

# install dependency
sudo apt-get update
sudo apt-get install -y python3-pip python3-setuptools libopenblas-base libopenmpi-dev
sudo -H pip3 install --upgrade pip testresources protobuf
sudo -H pip3 install numpy==1.19.4

pythonversion="$(python3 -V | awk  '$2 > 0 {print substr($2,1,3)}')"

if [ $pythonversion = "3.6" ]; then
  # install torch and torchvision
  wget https://nvidia.box.com/shared/static/h1z9sw4bb1ybi0rm3tu8qdj8hs05ljbm.whl -O torch-1.9.0-cp36-cp36m-linux_aarch64.whl
  sudo -H pip3 install torch-1.9.0-cp36-cp36m-linux_aarch64.whl torchvision
fi

if [ $pythonversion = "3.8" ]; then
wget  https://github.com/KumaTea/pytorch-aarch64/releases/download/v1.11.0/torch-1.11.0-cp38-cp38-linux_aarch64.whl
sudo -H pip3 install torch-1.11.0-cp38-cp38-linux_aarch64.whl torchvision
fi

# record script end time
date
