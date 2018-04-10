#!/bin/bash


# Dimensione massima di tutti i file report presenti in KB
maxsize=12

# Ciclo finche lo spazio occupato dai report è minore di maxsize o non sono più presenti report
while [ $(ls | grep -c report) != "0" ] && [ $(du -c report*.csv | tail -n1 | cut -f1) -ge $maxsize ]; do
	file=$(ls -tr report*.csv | head -1)
	rm $file
	echo "$file eliminato"
done

echo -e "\nSpazio utilizzato sotto la soglia predefinita"