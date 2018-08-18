#!/usr/bin/env bash


API_PORT=4068

API_TIMEOUT=8

<<COMMENT
aergo (AeriumX: AEX)
bitcore (Bitcore: BTX)
x16r (X16R: Raven, )
x16s (X16S: Pigeon)
x17 (X17: Verge)
c11 (C11: CHC)
phi (PHI1612: Folm, Seraph)
phi2 (PHI2: LUXCoin)
renesis (RESS: Renesis)
tribus (Tribus: Denarius)
poly (Poly: Polytimos)
skunk (Skunk: Skunk)
sonoa (Sonoa: SONO)
hex (Hex: HEX)
hsr (HSR: HSR)
timetravel (Machinecoin: MAC)
xevan (Xevan: Transend)
COMMENT


#
# algo
#

algo_avail=("aergo" "bitcore" "x16r" "x16s" "x17" "c11" "phi" "phi2" "renesis" "tribus" "poly" "skunk" "sonoa" "hex" "hsr" "timetravel" "xevan")
templ=( 10 10 10 10 10 )

#######################
# Functions
#######################


get_cards_info(){

	temp='"00",'
	fan='"00",'

	for (( i=0; i < ${GPU_COUNT_NVIDIA}; i++ )); do
		hs[$i]=0
	done
	
	local gpu_total=$GPU_COUNT_NVIDIA

	for (( i=0; i < gpu_total; i++ )); do
	
	index=$((i+1))

	substr=$(echo $miner_stat2 | awk -F '|' '{print $'$index'}')


	local gpu_id=$(echo $substr | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
	local hashrate=$(echo $substr | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')
	local temper=$(echo $substr | awk -F 'TEMP=' '{print $2 }' | awk -F ';|=' '{print $1}')
	local faner=$(echo $substr  | awk -F 'FAN=' '{print $2 }' | awk -F ';|=' '{print $1}')

	temp=$temp' "'$temper'" ,'
	fan=$fan' "'$faner'" ,'
	hs[$gpu_id]=$hashrate
	templ[$gpu_id]='"'$temper'"'
	
	done


	length=${#temp}
	temp=${temp:0:$((length-1))}
	length=${#fan}
	fan=${fan:0:$((length-1))}
	
	


	temp='[ '$temp' ]'
	fan='[ '$fan' ]'
	
}

get_nvidia_cards_temp(){
	
	echo $(jq -c "[.temp$nvidia_indexes_array]" <<< $gpu_stats)
	
}

get_nvidia_cards_fan(){
	echo $(jq -c "[.fan$nvidia_indexes_array]" <<< $gpu_stats)
}

get_miner_uptime(){
local uptime=(`echo "$miner_stat" | awk -F 'UPTIME' '{print $2 }' | awk -F ';|=' '{print $2}'`)
	[[ $uptime == "null" ]] && uptime=0
	echo $uptime
}

get_miner_algo(){
	
	local algo=(`echo "$miner_stat" | awk -F 'ALGO' '{print $2 }' | awk -F ';|=' '{print $2}'`)
	echo $algo
}

get_miner_shares_ac(){
	local acc=(`echo "$miner_stat" | awk -F 'ACC' '{print $2 }'  | awk -F ';|=' '{print $2}'`)
	[[ $acc == "null" ]] && acc=0
	echo $acc
}

get_miner_shares_rj(){
	local rej=(`echo "$miner_stat" | awk -F 'REJ' '{print $2 }'  | awk -F ';|=' '{print $2}'`)
	[[ $rej == "null" ]] && rej=0
	echo $rej
}

get_total_hashes(){
local total=`echo "$miner_stat" | awk -F 'KHS' '{print $2 }' | awk -F ';|=' '{print $2}'`

	[[ $total == "null" ]] && total=0
	echo $total
}




#######################
# MAIN script body
#######################


. /hive/custom/$CUSTOM_MINER/h-manifest.conf
miner_stat=`echo 'summary' | nc -w $API_TIMEOUT localhost $API_PORT`
miner_stat2=`echo 'threads' | nc -w $API_TIMEOUT localhost $API_PORT`


if [[ $? -ne 0 ]]; then
	echo -e "${YELLOW}Failed to read miner stats from localhost:${API_PORT}${NOCOLOR}"
	stats=""
	khs=0
	return 1
fi


[[ -z $GPU_COUNT_NVIDIA ]] &&
	GPU_COUNT_NVIDIA=`gpu-detect NVIDIA`
	get_cards_info						# hashes array, temp, fan
	hs_units='khs'						# hashes utits



uptime=$(get_miner_uptime)			# miner uptime
echo -e "${RED}Uptime:${NOCOLOR}" $uptime

algo=$(get_miner_algo)
echo "Miner Algo:" $algo

ac=$(get_miner_shares_ac)
echo "Acceptes Shares:" $ac

rj=$(get_miner_shares_rj)
echo -e "${RED}Rejected Shares:${NOCOLOR}" $rj




#	# make JSON
	stats=$(jq -nc \
				--argjson hs "`echo ${hs[@]} | tr " " "\n" | jq -cs '.'`" \
				--arg hs_units "$hs_units" \
				--argjson temp "$temp" \
				--argjson fan "$fan" \
				--arg uptime "$uptime" \
				--arg ac $ac --arg rj "$rj" \
				--arg algo "$algo" \
				'{$hs, $hs_units, $temp, $fan, $uptime, ar: [$ac, $rj], $algo}')

echo "Stats:" $stats

	khs=$(get_total_hashes)

# debug output
<<NODEBUG
echo Temp:   ${temp[@]}
echo fan:    $fan
echo stats:  $stats
echo khs:    $khs
echo uptime: $uptime
echo hs:       ${hs[@]}
echo hs_units: $hs_units
echo temp:     $temp
echo fan:      $fan
echo uptime    $uptime
echo "ac/rj":  $ac $rj
echo algo:     $algo
NODEBUG