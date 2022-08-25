#!/bin/bash

echo "Choose Java version 17 (or try others, except 8)"
sudo update-alternatives --config java

./tcmc_cleanCustomBusybox.sh

./tcmc_analyzeCustomBusybox.sh
 
