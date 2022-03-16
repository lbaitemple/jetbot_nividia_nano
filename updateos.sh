sudo apt update && sudo apt upgrade -y
sudo usermod -aG i2c $USER
sudo apt-get update
sudo apt install python3-pip python3-pil curl -y
sudo pip3 install --upgrade numpy 

# install tensorflow
sudo apt-get update
sudo apt install python3-dev python3-pip python3-venv -y

sudo pip uninstall tensorflow
sudo pip3 uninstall tensorflow
# install the dependencies (if not already onboard)
sudo apt-get install gfortran -y
sudo apt-get install libhdf5-dev libc-ares-dev libeigen3-dev -y
sudo apt-get install libatlas-base-dev libopenblas-dev libblas-dev -y
sudo apt-get install liblapack-dev -y
sudo -H pip3 install pybind11
sudo -H pip3 install Cython==0.29.21
# install h5py with Cython version 0.29.21 (± 6 min @1950 MHz)
sudo -H pip3 install h5py==2.10.0
# upgrade setuptools 40.8.0 -> 50.3.2
sudo -H pip3 install --upgrade setuptools

pip3 install gdown
sudo cp ~/.local/bin/gdown /usr/local/bin/gdown
gdown https://drive.google.com/uc?id=1fR9lsi_bsI_npPFB-wZyvgjbO0V9FbMf
sudo -H pip3 install tensorflow-2.2.0-cp37-cp37m-linux_aarch64.whl

#sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran -y
#sudo apt-get install python3-pip -y
#sudo pip3 install -U pip testresources setuptools==49.6.0 
#sudo pip3 install -U numpy==1.19.4 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
#sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow
# install torch

sudo apt install libopenblas-dev libblas-dev m4 cmake cython python3-dev python3-yaml python3-setuptools -y
mkdir pytorch_install && cd pytorch_install
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
pip3 install typing_extensions

export NO_CUDA=1
export NO_DISTRIBUTED=1
export NO_MKLDNN=1 
export NO_NNPACK=1
export NO_QNNPACK=1

python3 setup.py build
python3 setup.py sdist bdist_wheel
sudo -E python3 setup.py install


#install torchvision
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev -y
git clone https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
cd torchvision
git checkout tags/v0.8.1
export BUILD_VERSION=0.8.1
sudo -H python3 setup.py install


cd $HOME
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd torch2trt
sudo python3 setup.py install



cd ~
sudo python3 -m pip install git+https://github.com/ipython/traitlets@4.x

# install jupter lab
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y  python3-pip nodejs libffi-dev 
sudo pip3 install setuptools
sudo apt install libffi-dev -y
sudo pip3 install cffi

sudo pip3 install jupyter jupyterlab
sudo jupyter labextension install @jupyter-widgets/jupyterlab-manager
sudo jupyter labextension install @jupyterlab/statusbar
jupyter lab --generate-config
python3 -c "from jupyter_server.auth.security import set_password; set_password('jetbot', '$HOME/.jupyter/jupyter_server_config.json')"
#sudo chown -R pi:pi /home/pi/.local/share/

# Install bokeh
#sudo pip3 install bokeh
#sudo jupyter labextension install @bokeh/jupyter_bokeh
echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_lab_config.py
echo "c.NotebookApp.password_required = True" >> $HOME/.jupyter/jupyter_lab_config.py
echo "c.NotebookApp.allow_credentials = False" >> $HOME/.jupyter/jupyter_lab_config.py


cd
sudo apt install python3-smbus
git clone https://github.com/lbaitemple/jetbot
cd jetbot
sudo apt-get install cmake -y
sudo python3 setup.py install

cd jetbot/utils
python3 create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo systemctl enable jetbot_stats
sudo systemctl start jetbot_stats
python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter
sudo systemctl start jetbot_jupyter

sudo dd if=/dev/zero of=/swap1 bs=1M count=4096
sudo mkswap /swap1
sudo swapon /swap1
sudo bash -c "echo '/swap1 swap swap' >> /etc/fstab"

cp -r ~/jetbot/notebooks ~/Notebooks

export REGION=us-east-1
sudo apt update --fix-missing
sudo apt install openjdk-11-jdk -y
cd ~
sudo bash -c 'wget https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.4/greengrass-linux-$(arch)-1.9.4.tar.gz'
sudo bash -c 'gunzip -c greengrass-linux-$(arch)-1.9.4.tar.gz | sudo tar -xvf - --directory /'

#wget https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.4/greengrass-linux-aarch64-1.9.4.tar.gz
#gunzip -c https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/1.9.4/greengrass-linux-aarch64-1.9.4.tar.gz | sudo tar -xvf - --directory /


sudo wget -O /greengrass/certs/root.ca.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem
# add ggc_user
sudo adduser --system ggc_user
sudo addgroup --system ggc_user
sudo addgroup --system ggc_group
sudo chown -R ggc_user /home/ggc_user
sudo chgrp -R ggc_user /home/ggc_user

echo "alias green='sudo chmod 0666 /dev/i2c-1 && sudo /greengrass/ggc/core/greengrassd  '">> ~/.bashrc
