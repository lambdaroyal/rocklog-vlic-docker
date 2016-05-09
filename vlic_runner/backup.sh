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
echo "Remove existing archive"
rm -f $archive $archive.gpg
echo "Create archive $archive from $source"
tar czf $archive $source
echo $gpgpasswd|gpg --batch --passphrase-fd 0 -c $archive
ftp-upload -h $ftpserver -u $ftpuser --password $ftppass -d $ftpdir $archive.gpg
rm -f $archive $archive.gpg
