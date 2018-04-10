#!/bin/bash

while true
do
	echo -e "\nMonitoraggio server. Comandi disponibili:\n	1) Inizia monitoraggio\n	2) Ferma monitoraggio\n	3) Stampa info utilizzo\n	4) Chiudi\n	5) checkSpace"
	read -p "Inserisci numero comando[1-5]: " input
	echo -e "\n"
	case $input in
		1)	# Prima controllo che il processo non sia già in esecuzione
			if [ "$(ps -ef | grep recorder.bash | grep -v grep)" ]; then
			    echo "Monitoraggio server già in esecuzione"
			else
				# Eseguo in background lo script recorder.bash
			    bash recorder.bash &
			    echo "Monitoraggio server avviato"
			fi
			;;
		2) 	# Prima controllo che il processo sia già in esecuzione
			if [ "$(ps -ef | grep recorder.bash | grep -v grep)" ]; then
				pid=$(ps -ef | grep recorder.bash | grep -v grep | tr -s ' ' | cut -d ' ' -f2)
				# SIGPIPE lo uso per non stampare a video il messaggio di terminazione del processo
			    kill -SIGPIPE $pid
			    echo "Monitoraggio server fermato"
			else
				echo "Nessun monitoraggio server in esecuzione"
			fi
			;;
		3) bash query.bash;;
		4) exit 0;;
		5) bash checkSpace.bash;;
		*) echo -e "Comando inserito non corretto!\n";;
	esac
done