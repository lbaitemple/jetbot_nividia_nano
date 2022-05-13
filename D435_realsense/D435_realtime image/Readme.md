### Realsense

#### Download  https://github.com/IntelRealSense/librealsense/releases/ 
```
cd ~
wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.49.0.zip
unzip v2.49.0.zip
cd ~/librealsense-2.49.0
CUDACXX=/usr/local/cuda-10.2/bin/nvcc
mkdir build
cd build
export PATH=$PATH:/usr/local/cuda-10.2/bin/
```
For python 3.6
```
cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.6 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true
```
For python 2.7
```
cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python2.7 -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true
```

```
make -j4
sudo make install

echo "export PATH=$PATH:~/.local/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/pyrealsense2" >> ~/.bashrc
```

python 2.7
```
echo "export PATH=$PATH:~/.local/bin
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/pyrealsense2" >> ~/.bashrc
```

```
cd ~/librealsense-2.49.0
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
realsense-viewer
```

When you are using the python wrapper in jupterlab, please include 
```
import sys
sys.path.append('/usr/local/lib/python3.6/pyrealsense2')
```
before you use
```
import pyrealsense2 as rs 
```
