#!/bin/bash
# Christian Meichsner
# Daily Backup rotation

# This script consumes the subsequently listed parameters
# $1 directory to compress

while getopts :s:g:f:d:u:p: OPTION ; do
  case "$OPTION" in
    s)   
         source=$OPTARG
         echo "Using $OPTARG as source for archiving"
         ;;
    g)   gpgpasswd=$OPTARG;;
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
rm -f $archive $archive.gpg
echo "Create archive $archive from $source"
cp -rf $source backup/$source
tar czf $archive backup/$source
echo $gpgpasswd|gpg --batch --passphrase-fd 0 -c $archive
lftp -e "set ftp:ssl-protect-data true; set ssl:verify-certificate false;set ftp:ssl-force true; put -O $ftpdir $archive.gpg; bye" -u $ftpuser,$ftppass $ftpserver
rm -f $archive $archive.gpg
