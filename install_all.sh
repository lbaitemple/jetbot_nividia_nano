#sudo apt update && sudo apt upgrade -y
sudo apt-get install libzmq3-dev  python3-smbus curl cmake -y
#sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x
sudo apt install python3-pip python3-pil -y

sudo usermod -aG i2c $USER
sudo usermod -aG video jetbot


bash ./install_torch.sh
bash ./jetbot_stats.sh
bash ./jupyter.sh
#bash ./install_ros.sh
#bahs ./install_d435.sh
