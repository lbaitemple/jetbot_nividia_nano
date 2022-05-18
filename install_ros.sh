  
#!/bin/sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl  -y
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update
sudo apt install sudo apt install ros-melodic-desktop -y
sudo apt-get install python3 python3-dev python3-pip python3-yaml -y
sudo pip3 install catkin_pkg empy rospkg
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
echo "export ROS_PYTHON_VERSION=3" >> ~/.bashrc
source ~/.bashrc
