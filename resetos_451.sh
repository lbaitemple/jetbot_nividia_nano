### This code will update the OS for image Jetpack 451 or Jetpack 45
### it seems to have the dpkg: error "processing package nvidia-l4t-bootloader (--configure):"
### run this code will update the system for 451 and 45


sudo apt update && sudo apt upgrade -y
sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/backup/
sudo mkdir /var/lib/dpkg/info/
sudo apt-get update
sudo apt-get -f -y install
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/backup/
sudo rm -rf /var/lib/dpkg/info
sudo mv /var/lib/dpkg/backup/ /var/lib/dpkg/info/
sudo apt autoremove -y
