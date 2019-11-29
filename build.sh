#!/bin/bash
# build a pharo-production image

if [ -z "$IMAGE" ]; then
  IMAGE=pharo-production
fi
if [ -z "$MC_NAME" ]; then 
  MC_NAME=NeoConsole
fi
if [ -z "$MC_REPOSITORY" ]; then 
  MC_REPOSITORY=git@github.com:svenvc/$MC_NAME.git
fi
if [ -z "$MC_BASELINE" ]; then 
  MC_BASELINE=BaselineOf$MC_NAME
fi
if [ -z "$MC_GROUPS" ]; then 
  MC_GROUPS=default
fi

rm -rf build.image build.changes PharoDebug.log pharo-local/*
./pharo Pharo.image save build
./pharo build.image eval --save "Iceberg remoteTypeSelector: #httpsUrl.\
EpMonitor current disable."

mkdir pharo-local/iceberg
cd pharo-local/iceberg
# when using a private ssh deploy key for accessing an ssh repo
# GIT_SSH_COMMAND="ssh -i ~/.ssh/your_private_deploy_key" git clone $MC_REPOSITORY
git clone $MC_REPOSITORY
cd ../..
echo ./pharo build.image metacello install gitlocal:///$PWD/pharo-local/iceberg/$MC_NAME $MC_BASELINE --groups=$MC_GROUPS
./pharo build.image metacello install gitlocal:///$PWD/pharo-local/iceberg/$MC_NAME $MC_BASELINE --groups=$MC_GROUPS

echo; echo optimizing artifact $IMAGE.image
rm -rf $IMAGE.image $IMAGE.changes
./pharo build.image save $IMAGE
./pharo $IMAGE.image clean --production
./pharo $IMAGE.image eval --save "HelpBrowser allInstances do: #close.\
TestCase allSubclassesDo: [ :e | e removeFromSystem].\
#ZnZincServerAdaptor asClassIfPresent: [ :cl | cl default stop ].\
Smalltalk garbageCollect humanReadableSIByteSize."

echo $IMAGE.image ready
