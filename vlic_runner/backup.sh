#!/bin/bash
# Christian Meichsner
# Daily Backup rotation

# This script consumes the subsequently listed parameters
# $1 directory to compress

while getopts :s:f:d:u:p: OPTION ; do
  case "$OPTION" in
    s)   
         source=$OPTARG
         echo "Using $OPTARG as source for archiving"
         ;;
    d)
         ftpdir=$OPTARG
         echo "Using $OPTARG as ftp upload dir"
         ;;
    f)   
         ftpserver=$OPTARG
         echo "Using $OPTARG as ftp server"
         ;;
    u)   
         ftpuser=$OPTARG
         echo "Using $OPTARG as ftp user"
         ;;
    p)   ftppass=$OPTARG;;
    *)   echo "Unknown parameter"
         exit 1
         ;;
  esac
done

day=`LC_ALL=C date +%A`
archive=$day.tar

# create compressed archive
mkdir -p backup
rm -rf backup/*
echo "Remove existing archive"
rm -f $archive
echo "Create archive $archive from $source"
cp -rf $source backup/$source
tar czf $archive backup/$source
lftp -e "set ftp:ssl-protect-data true; set ssl:verify-certificate false;set ftp:ssl-force true; put -O $ftpdir $archive; bye" -u $ftpuser,$ftppass $ftpserver
rm -f $archive
