#!/bin/bash

echo -e "Preparing features, feature model, and presence conditions"
echo ""

./tcmc_prepare.sh |& tee tcmc_output_prepare1.log
./tcmc_prepare.sh |& tee tcmc_output_prepare2.log

echo -e "Run TypeChef on busybox"

./tcmc_runTypeChef.sh |& tee tcmc_output_typechef.log
