#!/bin/bash

#Get system date
DATE=`date '+%y%m%d'`

#Create a working directory where all .tar files of the container will be stored
mkdir -p Backup_$DATE
WDIR=Backup_$DATE

#Get names of all running containers
docker_names=`docker ps --format '{{.Names}}'`

for dn in $docker_names
do
 #Convert container names to lower case as repository name of an image cannot be in upper case
 Image_Backup=`echo $dn | tr '[:upper:]' '[:lower:]'`
 #Take backup of the running container & save in .tar format
 docker commit -p $dn $Image_Backup:$DATE
 docker save -o $WDIR/$Image_backup.tar $Image_Backup:$DATE
done
