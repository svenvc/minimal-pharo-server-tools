#!/bin/bash
# deploy pharo-http-server

SERVICE=pharo-http-server
SERVICE_DIR=$HOME/$SERVICE
PHARO_DIR=$HOME/pharo
SCRIPTS_DIR=minimal-pharo-server-tools
IMAGE=pharo-production

mkdir $SERVICE_DIR && cd $SERVICE_DIR
cp $SCRIPTS_DIR/pharo-ctl.sh .
cp $SCRIPTS_DIR/run/$SERVICE/*.sh .
cp $SCRIPTS_DIR/run/$SERVICE/*.st .
m4 -D_USER_=$USER run/pharo-http-server/$SERVICE.service > $SERVICE.service

cp $PHARO_DIR/$IMAGE.* .
cp -R $PHARO_DIR/pharo-vm .
cp $PHARO_DIR/pharo .
cp $PHARO_DIR/Pharo*.sources .

sudo cp $SERVICE.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE
