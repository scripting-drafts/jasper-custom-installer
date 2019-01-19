#!/bin/bash
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install -y vim git-core python-dev python-pip bison libasound2-dev libportaudio-dev python-pyaudio espeak subversion autoconf libtool automake gfortran g++
cd ~
wget http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz
wget http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz
wget http://distfiles.macports.org/openfst/openfst-1.3.4.tar.gz 
wget https://github.com/mitlm/mitlm/releases/download/v0.4.2/mitlm-0.4.1.tar.gz
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/m2m-aligner/m2m-aligner-1.2.tar.gz
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/phonetisaurus/is2013-conversion.tgz
wget https://www.dropbox.com/s/kfht75czdwucni1/g014b2b.tgz
svn co https://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk/
git clone https://github.com/jasperproject/jasper-client.git jasper
 
tar xf sphinxbase-0.8.tar.gz
tar xf pocketsphinx-0.8.tar.gz
tar xf m2m-aligner-1.2.tar.gz
tar xf openfst-1.3.4.tar.gz
tar xf is2013-conversion.tgz
tar xf mitlm-0.4.1.tar.gz
tar xf g014b2b.tgz

echo --- Configuring and building packages....
sudo apt-get install sphinx-common -y
cd ~/sphinxbase-0.8/
./configure --enable-fixed && make && sudo make install
cd ~/pocketsphinx-0.8/
./configure && make && sudo make install
cd ~/cmuclmtk/
sudo ./autogen.sh && sudo make && sudo make install
echo --- ... openfst ... ---
cd ~/openfst-1.3.4/
sudo ./configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt
sudo make install
echo --- ... m2m-aligner ... ---
cd ~/m2m-aligner-1.2/
sudo make
cd ~/mitlm-0.4.2/
sudo ./configure && sudo make install
echo --- ... phonetisaurus ... ---
cd ~/is2013-conversion/phonetisaurus/src/
make
echo --- ... g014b2b ... ---
cd ~/g014b2b/
./compile-fst.sh
echo --- ... Installing the files we just built ... ---
mv ~/g014b2b ~/phonetisaurus
sudo cp ~/m2m-aligner-1.2/m2m-aligner /usr/local/bin/m2m-aligner
sudo cp ~/is2013-conversion/bin/phonetisaurus-g2p /usr/local/bin/phonetisaurus-g2p
sudo apt-get install python-pocketsphinx -y
sudo chmod +x install_jasper_python.sh
echo --- ... Finished!! Rebooting ... ---
echo --- ... --- ... --- ... --- ... --- ... --- ... --- ... --- ... --- ... ----- After reboot, please run "install_jaspter_python.sh"
sudo reboot
echo --- ... You will not see this! ---
echo --- ... a ... ---
