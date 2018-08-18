#!/usr/bin/env bash

#export LD_LIBRARY_PATH=/hive/xmr-stak/fireice-uk

cd `dirname $0`

[ -t 1 ] && . colors

#CUSTOM_MINER="ZEnemy116"

. /hive-config/rig.conf
. /hive-config/wallet.conf

#[[ -z $CUSTOM_MINER ]] && echo -e "${RED}No CUSTOM_MINER is set${NOCOLOR}" && exit 1
#. /hive/custom/$CUSTOM_MINER/h-manifest.conf

. h-manifest.conf

echo $CUSTOM_MINER
echo $CUSTOM_LOG_BASENAME
echo $CUSTOM_CONFIG_FILENAME
echo $WORKER_NAME
# miner custom CUSTOM_MINER="ZEnemy" 
#CUSTOM_INSTALL_URL=""
#CUSTOM_ALGO="ethash"
#CUSTOM_TEMPLATE="XU96Bpv16GxfCDRZLU9VWwcXQ83XRHaydN.%WORKER_NAME%"
#CUSTOM_URL="stratum+tcp://eu.bsod.pw:2320"
#CUSTOM_PASS="c=XDNA"
#CUSTOM_USER_CONFIG=''


[[ -z $CUSTOM_LOG_BASENAME ]] && echo -e "${RED}No CUSTOM_LOG_BASENAME is set${NOCOLOR}" && exit 1
[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && exit 1
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}Custom config ${YELLOW}$CUSTOM_CONFIG_FILENAME${RED} is not found${NOCOLOR}" && exit 1
CUSTOM_LOG_BASEDIR=`dirname "$CUSTOM_LOG_BASENAME"`
[[ ! -d $CUSTOM_LOG_BASEDIR ]] && mkdir -p $CUSTOM_LOG_BASEDIR
#[[ -d $CUSTOM_LOG_BASEDIR ]] && [[ ! -f $CUSTOM_LOG_BASEDIR/$CUSTOM_NAME ]] && cp -f /hive/custom/$CUSTOM_NAME/xmrig-nvidia $CUSTOM_LOG_BASEDIR/$CUSTOM_NAME

#cd $CUSTOM_LOG_BASEDIR
pwd

export LD_LIBRARY_PATH=/hive/custom/ZEnemy:$LD_LIBRARY_PATH
export PATH=/hive/custom/ZEnemy:$PATH.
#./z-enemy -o $CUSTOM_TEMPLATE -a hex -o $CUSTOM_URL -u $CUSTOM_TEMPLATE -p $CUSTOM_PASS

./z-enemy $(< /hive/custom/$CUSTOM_NAME/$CUSTOM_NAME.conf) 
# -l $CUSTOM_LOG_BASENAME.log --api-port=60055$@

