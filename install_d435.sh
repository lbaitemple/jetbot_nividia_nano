cd ~
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.49.0.zip
unzip v2.49.0.zip
cd ~/librealsense-2.49.0
CUDACXX=/usr/local/cuda-10.2/bin/nvcc

sudo apt-get install -y  libssl-dev libglfw3 libglfw3-dev libxinerama-dev libxcursor-dev


mkdir build
cd build
export PATH=$PATH:/usr/local/cuda-10.2/bin/

cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true
make -j4
sudo make install

echo "export PATH=$PATH:~/.local/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/pyrealsense2" >> ~/.bashrc

cd ~/librealsense-2.49.0
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

