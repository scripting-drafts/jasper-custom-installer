#!/bin/bash
cd ~
sudo pip install --upgrade setuptools
sudo pip install -r jasper/client/requirements.txt
chmod +x jasper/jasper.py

cd ~/jasper/client
python populate.py

echo --- ... ---\> Finished! You can now run Jasper with "~/jasper/jasper.py" :-\)
