#!/bin/bash

echo -e "Preparing features, feature model, and presence conditions"

# Choose Java 8 (type 1)
sudo update-alternatives --config java
./KJT_prepare.sh 

echo -e "Run TypeChef on busybox"

# Choose Java 17 (type 0)
sudo update-alternatives --config java
./KJT_runTypeChef.sh
