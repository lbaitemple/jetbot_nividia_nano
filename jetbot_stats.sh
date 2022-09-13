#!/bin/bash
# Animesh Bala Ani (ANI717)

# exit immediately if a command exits with a non-zero status.
set -e

# record script start time
date

# install dependency
sudo apt-get update
sudo apt-get install -y python3-pip python3-setuptools python3-pil
sudo apt-get install libzmq3-dev  python3-smbus curl cmake -y
cd ~/jetbot
sudo python3 setup.py install
sudo pip3 install packaging ipywidgets
sudo -H pip3 install --upgrade pip
#sudo -H pip3 install Adafruit_SSD1306
sudo python3 -m pip install Adafruit_SSD1306
sudo python3 -m pip install opencv-python

# create jetbot_stats service
python3 ./jetbot/utils/create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo cp ./jetbot/apps/stats.py /etc/systemd/system/jetbot_stats.py
sudo systemctl enable jetbot_stats
sudo systemctl start jetbot_stats

# record script end time
date
