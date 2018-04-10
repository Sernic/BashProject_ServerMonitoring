#!/bin/bash

# Tempo di sleep in secondi
pause=30

while true
do
	# Setto la data attuale come nome del file
	filename="report_$(date +"%Y%m%d_%H%M%S").csv"

	# Scrivo nel file i processi in esecuzione con i parametri richiesti
	while read -r line
	do
    	user=$(echo $line | cut  -d ' ' -f1)
		pid=$(echo $line | cut -d ' ' -f2)
		start=$(echo $line | cut -d ' ' -f3)
		time=$(echo $line | cut -d ' ' -f4)
		command=$(echo $line | cut -d ' ' -f5)
		# Controllo il formato della data e in caso formatto in maniera corretta
		if [ $(echo $start | wc -c) = "4" ]; then
			start=$(echo $line | cut -d ' ' -f3,4)
			time=$(echo $line | cut -d ' ' -f5)
			command=$(echo $line | cut -d ' ' -f6)
		fi

		echo "$user;$pid;$command;$start;$time"
	done <<< "$(ps --no-headers -eo user:32,pid,start,time,command | tr -s ' ')" > $filename

	sleep $pause
done