#!/bin/bash

check() {

local INPUT_NAME=$1

shift

local LIST=("$@")


for NAME in $LIST; do
	if [ "$NAME" = "$INPUT_NAME" ]; then
		
return 1
	fi

done

}



### MAIN SCRIPT ###

USERNAME=$1

GROUPNAME=$2

IFS=$'\n'

USERNAME_LIST=("$(cut -d ":" -f 1 /etc/passwd)")

GROUPNAME_LIST=("$(cut -d ":" -f 1 /etc/group)")

unset IFS

check $USERNAME "${USERNAME_LIST[@]}"



if [ $? -eq 1 ]; then 
	
	echo "ERROR: Username is already being used"
	
	exit 1

fi



check $GROUPNAME "${GROUPNAME_LIST[@]}"


if [ $? -eq 1 ]; then
	
	echo "ERROR: Groupname is already being used"
	
	exit 1

fi



sudo groupadd $GROUPNAME

sudo useradd -g $GROUPNAME -s /bin/bash -p "mypassword" $USERNAME



GROUPCHECK=$(id -gn $USERNAME)



if [ "$GROUPCHECK" = "$GROUPNAME" ]; 
   then
 
  sudo mkdir /$USERNAME
   
  sudo chown $USERNAME:$GROUPNAME /$USERNAME 
 
  sudo chmod 770 /$USERNAME
   
  sudo chmod +t /$USERNAME

fi

