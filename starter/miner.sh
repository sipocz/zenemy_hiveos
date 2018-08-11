#/bin/bash
rm -r -f /hive/custom/ZEnemy
mkdir /hive/custom/ZEnemy
tar -xzvf z-enemy-1.15a-cuda91.tar.gz /hive/custom/ZEnemy/ 
cp /hive/ccminer223-cuda90/cuda-9.0/libcudart.so.9.1  /hive/custom/ZEnemy
export LD_LIBRARY_PATH=/hive/custom/ZEnemy:$LD_LIBRARY_PATH. 
export PATH=/hive/custom/ZEnemy:$PATH 
cd /
cd /hive/custom/ZEnemy
rigName="alfa"
./z-enemy -a hex -o stratum+tcp://eu.bsod.pw:2320 -u XU96Bpv16GxfCDRZLU9VWwcXQ83XRHaydN.$rigName -p c=XDNA 
