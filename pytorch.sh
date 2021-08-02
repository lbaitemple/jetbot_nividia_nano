sudo apt-get install -y gcc python3-dev v4l-utils python3-opencv python3-pip python3-setuptools libffi-dev libssl-dev
wget https://mathinf.com/pytorch/arm64/torch-1.6.0a0+b31f58d-cp37-cp37m-linux_aarch64.whl
wget https://mathinf.com/pytorch/arm64/torchvision-0.7.0a0+78ed10c-cp37-cp37m-linux_aarch64.whl
sudo apt-get install -y python3-numpy python3-wheel python3-setuptools python3-future python3-yaml python3-six python3-requests python3-pip python3-pillow
pip3 install torch*.whl torchvision*.whl
