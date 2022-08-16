#!/bin/bash

echo -e "Preparing features, feature model, and presence conditions"
echo ""

./tcmc_prepare.sh 

echo -e "Run TypeChef on busybox"

./tcmc_runTypeChef.sh
