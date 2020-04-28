#!/bin/bash

set -eux

sudo apt -y install fakeroot libncurses5-dev libssl-dev ccache
sudo apt -y install dfu-util u-boot-tools device-tree-compiler libssl1.0-dev mtools
sudo apt -y install bc cpio zip unzip rsync file wget

## Setup Xilinx Vivado 2018.2
#if [ "${LD_LIBRARY_PATH: -1}" = ":" ]; then
#export LD_LIBRARY_PATH="${LD_LIBRARY_PATH: : -1}"
#fi
cd /home/gnuradio/Downloads/
tar -xpf Xilinx_Vivado_SDK_2018.2_0614_1954.tar.gz
cd Xilinx_Vivado_SDK_2018.2_0614_1954
sudo ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config ~/Downloads/install_config.txt

## Build the PlutoSDR firmware
cd /home/gnuradio/
git clone --recursive https://github.com/analogdevicesinc/plutosdr-fw.git
cd plutosdr-fw
export CROSS_COMPILE=arm-linux-gnueabihf-
export PATH=$PATH:/opt/Xilinx/SDK/2018.2/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin
export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2018.2/settings64.sh
make

### CLEAN UP OUR STUFF
cd
rm -r Downloads/*
