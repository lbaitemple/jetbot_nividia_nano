sudo apt install python3 python3-setuptools python3-dev python3-venv -y
pip3 install numpy
sudo apt-get install build-essential cmake pkg-config -y
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev  -y
wget http://ports.ubuntu.com/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_arm64.deb
sudo dpkg -i libpng12-0_1.2.54-1ubuntu1.1_arm64.deb
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y
sudo apt-get install libxvidcore-dev libx264-dev -y
sudo apt-get install libgtk2.0-dev -y
sudo apt-get install libatlas-base-dev gfortran -y
cd ~
mkdir src
cd src
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.7.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.7.zip
unzip opencv_contrib.zip
cd opencv-3.4.7
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.7/modules \
    -D WITH_CUDA=OFF \
    ..
make -j4
sudo make install
