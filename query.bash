#!/bin/bash

# Controllo che sia presente almeno un report
if [ $(ls | grep -c report) = "0" ];
then
	echo "Nessun report presente"
else
	file=$(ls -t report*.csv | head -1)
	echo "Ultimo report: $file"
	# Stampo a video quanti processi per ciascun utente ci sono nel report più recente
	while read -r line
	do
		nomeFile=$(echo $line | cut -d " " -f2)
		nprocessi=$(echo $line | cut -d " " -f1)
		echo $nomeFile:$nprocessi 
	done <<< "$(cut -d ';' -f1 $file | sort -d | uniq -c)"


# Secondo punto
	echo -e "\n"
	read -p "Inserisci utente: " input
	user=$(echo $input | cut -d ' ' -f1);
	echo -e "\n"
	
	# Controllo che non sia stato inserito un valore non valido
	if [ -n "$user" ];
	then
		# Cerco quanti processi per l'utente ci sono in ciascun report
		while read i
		do
			nprocessi=$(cut -d ';' -f1  $i | grep -wc $user)
			echo report: $i processi $nprocessi
		done <<< "$(ls report*.csv)"
	else
		echo "Utente inserito non valido"
	fi
fi