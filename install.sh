#!/bin/bash
# install pharo

sudo apt install -y git unzip curl telnet m4

if [ -z "$PHARO_DIR" ]; then
  PHARO_DIR=$HOME/pharo
fi
mkdir $PHARO_DIR && cd $PHARO_DIR

if [ -z "$ARCH" ]; then
  ARCH=/64
fi
if [ -z "$VERSION" ]; then 
  VERSION=70
fi
curl get.pharo.org/$ARCH/$VERSION+vm | bash
rm pharo-ui
./pharo Pharo.image printVersion

# if necessary, install your private ssh deploy key

cp ~/minimal-pharo-server-tools/build.sh $PHARO_DIR
