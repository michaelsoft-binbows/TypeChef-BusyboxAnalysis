Overview
--------

This project contains evaluation-related material for busybox. It contains the scripting to run the TypeChef parser and type system on Busybox.

It does not include Busybox itself, nor header files, nor the KBuildMiner project.


Preparation
-----------
Get sbt (tested with version 0.12.2) and run it in this directory. Sbt will automatically get the last release of TypeChef (You might still want to build a recent development release of TypeChef from the git repo).

Run `sbt mkrun` to create a `run.sbt` file, which sets the required build paths.

If you want to check other versions than 1.18.5 you need to download and build KBuildMiner (see README in that directory).

Check the paths to your header files in the `redhat.properties` file. Currently, the configuration files point to a `systems` directory for header files. That directory is not part of this repository. If you want to use the exact same headers that we are using, download them here http://www.cs.cmu.edu/~ckaestne/tmp/includes-redhat.tar.bz2


Installation \& Execution
-------------------------

⚠ **Disclaimer** Original installation instructions are either out-to-date or incomplete. If you precisly follow the installation steps in this section, exection of TypeChef with Busybox should work. I am not sure whether all steps are necessary nor are complete.

*Installation*

1. Clone all git repositories in one shared folder:
   - [TypeChef](https://github.com/ckaestne/TypeChef)
   - [TypeChef-BusyboxAnalysis](https://github.com/ckaestne/TypeChef-BusyboxAnalysis)
   - [KBuildMiner](https://github.com/ckaestne/KBuildMiner)
   - [kconfigreader](https://github.com/ckaestne/kconfigreader)
2. Download [header files](http://www.cs.cmu.edu/~ckaestne/tmp/includes-redhat.tar.bz2) and extract the contents to `TypeChef-BusyboxAnalysis/systems/redhat/`. The folder structure should look like `TypeChef-BusyboxAnalysis/systems/redhat/usr/...`.
3. Download [Busybox 1.18.5] and extract to `TypeChef-BusyboxAnalysis/`. The folder structure should look like `TypeChef-BusyboxAnalysis/busybox-1.18.5/...`.
4. Modify in `TypeChef-BusyboxAnalysis/jccp.conf` in line `12`: `system=redhat`

*Compilation*

```
set -x
cd TypeChef/
sbt mkrun
```

*Execution*

```
cd TypeChef-BusyboxAnalysis/
./cleanBusybox.sh
./analyzeBusybox.sh | tee output.log
```

Running on 1.18.5
-----------------

If you want to run just the 1.18.5 version of busybox, download that version and extract it to a busybox-1.18.5 directory. Subsequently run `prepareBusybox.sh` to create the required .pc files.
Now you can execute TypeChef with `./analyzeBusybox.sh`


Running other versions
----------------------

Checkout the desired version of busybox from the git repo into the directory gitbusybox. Typically you would clone the busybox repo there

	git clone git://busybox.net/busybox.git gitbusybox

Run `prepareGit.sh` to extract the feature model and create .pc files. 
You can run TypeChef with `analyzeBusyboxGit.sh`



Good luck. In case of problems contact someone of us.
