#!/bin/bash

echo -e "Preparing features, feature model, and presence conditions"

echo "Choose Java version 8!"
sudo update-alternatives --config java
./KJT_prepare.sh 

echo -e "Run TypeChef on busybox"

echo "Choose Java version 17 (or try others, except 8)"
sudo update-alternatives --config java
./KJT_runTypeChef.sh
