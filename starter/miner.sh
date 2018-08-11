#/bin/bash                                                                                                                                                                                                                                                   

export LD_LIBRARY_PATH=/hive/custom/ZEnemy:$LD_LIBRARY_PATH. 
export PATH=/hive/custom/ZEnemy:$PATH 
cd /
cd /hive/custom/ZEnemy
rigName="alfa"
./z-enemy -a hex -o stratum+tcp://eu.bsod.pw:2320 -u XU96Bpv16GxfCDRZLU9VWwcXQ83XRHaydN.$rigName -p c=XDNA 