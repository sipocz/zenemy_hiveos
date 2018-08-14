#!/usr/bin/env bash

API_PORT=4068
API_TIMEOUT=5 # need more test on it.
# please update the list of algos
algo_avail=("lyra2z" "tribus" "phi" "phi2" "c11" "x17" "x16r" "x16s" "renesis" "hex")

#######################
# Functions
#######################


get_cards_hashes(){
	# hs is global
	#echo $miner_stat2
	for (( i=0; i < ${GPU_COUNT_NVIDIA}; i++ )); do
		hs[$i]=0
	done
	
	local gpu_total=$GPU_COUNT_NVIDIA
	#echo "GPU total:" $gpu_total
for (( i=0; i < gpu_total; i++ )); do
	
index=$((i+1))
	
case $index in
1)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $1}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $1}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

2)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $2}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $2}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

3)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $3}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $3}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

4)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $4}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $4}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

5)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $5}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $5}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

6)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $6}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $6}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')


;;

7)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $7}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $7}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

8)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $8}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $8}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

9)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $9}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $9}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

10)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $10}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $10}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

11)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $11}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $11}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

12)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $12}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $12}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

13)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $13}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $13}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

14)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $14}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $14}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

15)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $15}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $15}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

16)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $16}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $16}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

17)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $17}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $17}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

18)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $18}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $18}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

19)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $19}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $19}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

20)
local gpu_id=$(echo $miner_stat2 | awk -F '|' '{print $20}' | awk -F 'GPU=' '{print $2 }' | awk -F ';|=' '{print $1}' )
local hashrate=$(echo $miner_stat2 | awk -F '|' '{print $20}'  | awk -F 'KHS=' '{print $2 }' | awk -F ';|=' '{print $1}')

;;

*)

echo "caser" $index



esac
#echo "i:" $i "GPUID: " $gpu_id
	
hs[$gpu_id]=$hashrate
done
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
#. /hive-config/wallet.conf
. /hive/custom/$CUSTOM_MINER/h-manifest.conf
miner_stat=`echo 'summary' | nc -w $API_TIMEOUT localhost $API_PORT`
# debug # echo $miner_stat
miner_stat2=`echo 'threads' | nc -w $API_TIMEOUT localhost $API_PORT`
# debug # echo $miner_stat2


if [[ $? -ne 0 ]]; then
	echo -e "${YELLOW}Failed to read miner stats from localhost:${API_PORT}${NOCOLOR}"
	stats=""
	khs=0
	return 1
fi

#miner_stat=`cat stat.json`

[[ -z $GPU_COUNT_NVIDIA ]] &&
	GPU_COUNT_NVIDIA=`gpu-detect NVIDIA`
	get_cards_hashes					# hashes array
	hs_units='khs'						# hashes utits
	temp=$(get_nvidia_cards_temp)		# cards temp
	fan=$(get_nvidia_cards_fan)		# cards fan
echo "Fans:" $fan
echo "Temperatures: " $temp

uptime=$(get_miner_uptime)			# miner uptime
echo -e "${RED}Uptime:${NOCOLOR}" $uptime

algo=$(get_miner_algo)   
echo "Miner Algo:" $algo

ac=$(get_miner_shares_ac)
echo "Acceptes Shares:" $ac

rj=$(get_miner_shares_rj)
echo -e "${RED}Rejected Shares:${NOCOLOR}" $rj



## make JSON
	stats=$(jq -nc \
				--argjson hs "`echo ${hs[@]} | tr " " "\n" | jq -cs '.'`" \
				--arg hs_units "$hs_units" \
				--argjson temp "$temp" \
				--argjson fan "$fan" \
				--arg uptime "$uptime" \
				--arg ac $ac --arg rj "$rj" \
				--arg algo "$algo" \
				'{$hs, $hs_units, $temp, $fan, $uptime, ar: [$ac, $rj], $algo}')

# total hashrate in khs

khs=$(get_total_hashes)

# debug output
echo temp:   $temp
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
