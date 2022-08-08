#!/bin/bash

./tcmc_cleanCustomBusybox.sh

./tcmc_analyzeCustomBusybox.sh | tee KJT_outputResult.log
 
