#!/bin/bash

./KJT_cleanCustomBusybox.sh

./KJT_analyzeCustomBusybox.sh | tee KJT_outputResult.log
 
