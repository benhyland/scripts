#!/bin/sh

if [ -z "$1" ]; then
	echo "bonds: $(ls -m /proc/net/bonding/)"
	exit 0
fi

bond=$1

links=$(<"/proc/net/bonding/$bond" awk '/Slave Interface/ { print $3 }')

statkeys="rx_packets rx_bytes tx_packets tx_bytes"
declare -A stats

for s in $statkeys; do
	for l in $links; do
		stats["${l}_${s}"]=$(cat /sys/class/net/$l/statistics/$s)
	done
done

sleep 10

for s in $statkeys; do
	for l in $links; do
		val=${stats["${l}_${s}"]}
		echo "$l $s: $( echo "$(cat /sys/class/net/$l/statistics/$s) - $val" | bc)"
	done
done
