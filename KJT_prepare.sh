#this script extracts the 
#* presence condition for files
#* the feature model
#* the header file

codebasePath="$(pwd)/custom_busybox/"

sbt mkrun

#create a directory custom_busybox and download busybox sources there

#you'll need KBuildMiner
#http://code.google.com/p/variability/source/browse/KBuildMiner/
#and Maven (mvn) to generate the list of presence conditions per files
cd custom_busybox
make allnoconfig
make gen_build_files
make include/config/MARKER
make applets/applets.o
#eliminate long list that's extremely expensive to parse
> include/applets.h
cd ..

# read the feature model and create corresponding files
./run.sh de.fosd.typechef.busybox.KConfigReader custom_busybox/ custom_busybox/featureModel custom_busybox/header.h custom_busybox/features

#use the standard blacklist
#ln -s linkerblacklist custom_busybox/linkerblacklist

#copy an old file pc in case KBuildMiner is not installed
#cp KBuildMiner/pc.txt custom_busybox/pc.txt

# the following tries to extract presence conditions from the build system
# you need to install KBuildMiner to get the latest conditions (see KBuildMiner directory)
cd KBuildMiner

java -Xmx2G -Xms128m -Xss50m -cp kbuildminer.jar gsd.buildanalysis.linux.KBuildMinerMain \
  --codebase $codebasePath \
  --topFolders applets,archival,console-tools,coreutils,debianutils,e2fsprogs,editors,findutils,init,klibc-utils,libbb,libpwdgrp,loginutils,mailutils,miscutils,modutils,networking,printutils,procps,runit,scripts,selinux,shell,sysklogd,util-linux \
  --pcOutput outputJedelhauser.pc

cp outputJedelhauser.pc ../custom_busybox/pc.txt

cd ..
grep -v libunarchive custom_busybox/pc.txt | grep -v Unknown > custom_busybox/pc_clean.txt

# extract a list of all relevant files
./run.sh de.fosd.typechef.busybox.CleanFileList --openFeatureList custom_busybox/features --featureModel custom_busybox/featureModel.dimacs custom_busybox/pc_clean.txt > custom_busybox/pc_processed.txt 2> custom_busybox/deadFiles
cat custom_busybox/pc_processed.txt | sed s/\\:.*// | grep -v libunarchive | grep -v "/tc$"  > custom_busybox/filelist

# generate .pc files from the presence condition list
./run.sh de.fosd.typechef.busybox.GeneratePCFiles --workingDir custom_busybox/ custom_busybox/pc_processed.txt 

# translate the feature model into a .dimacs file for faster processing
./run.sh de.fosd.typechef.busybox.CreateDimacs --cnf custom_busybox/featureModel custom_busybox/featureModel.dimacs
