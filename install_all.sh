sudo apt update && sudo apt upgrade -y
sudo apt-get install libzmq3-dev  python3-smbus curl cmake -y
sudo apt install python3-pip python3-pil -y
sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x


sudo usermod -aG i2c $USER

cd ~
git clone  -b ece3432-ros2 https://github.com/lbaitemple/jetbot_nvidia_nano/ jetbot
cd jetbot

bash ./pytorch.sh

bash ./jetbot_stats.sh

bash ./jupyter.sh

bash ./installros.sh
