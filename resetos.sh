sudo apt update && sudo apt upgrade -y
sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/backup/
sudo mkdir /var/lib/dpkg/info/
sudo apt-get update
sudo apt-get -f -y install
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/backup/
sudo rm -rf /var/lib/dpkg/info
sudo mv /var/lib/dpkg/backup/ /var/lib/dpkg/info/
sudo apt autoremove -y
