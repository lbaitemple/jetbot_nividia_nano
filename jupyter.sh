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

cd ~/jetbot/jetbot/utils
python3 create_jupyter_service.py
sudo mv jetbot_jupyter.service /etc/systemd/system/jetbot_jupyter.service
sudo systemctl enable jetbot_jupyter
sudo systemctl start jetbot_jupyter

cd ~/jetbot/jetbot/utils
python3 create_stats_service.py
sudo mv jetbot_stats.service /etc/systemd/system/jetbot_stats.service
sudo systemctl enable jetbot_stats
sudo systemctl start jetbot_stats
