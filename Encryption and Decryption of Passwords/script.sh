#!/bin/sh
echo "CHOOSE PRIMARY DIRECTORY"
read DIRECTORYNAME
mkdir $DIRECTORYNAME

while read input; do
	DATABASENAME=$(echo $input | cut -d "," -f1)
	USER=$(echo $input | cut -d "," -f2)
	PASSWORD=$(echo $input | cut -d "," -f3)
	echo $PASSWORD | openssl enc -aes-128-cbc -a -salt -pass pass:asdffdsa > "$DIRECTORYNAME/$DATABASENAME.$USER.password"	
done < inputfile

cd $DIRECTORYNAME
FILES=$(ls)

for file in $FILES; do
	echo "$(cat $file | openssl enc -aes-128-cbc -a -d -salt -pass pass:asdffdsa)" 
done
