#!/bin/bash
# Christian Meichsner
# Daily Backup rotation

# This script consumes the subsequently listed parameters
# $1 directory to compress

while getopts ':sgfup:' OPTION ; do
  case "$OPTION" in
    s)   echo "Using source $OPTARG to archive"
         source=$OPTARG;;
    g)   gpgpasswd=$OPTARG;;
    f)   echo "Using ftp server $OPTARG"
         ftpserver=$OPTARG;;
    u)   echo "Using ftp user $OPTARG"
         ftpuser=$OPTARG;;
    p
    *)   echo "Unknown parameter"
  esac
done

day=`LC_ALL=C date +%A`
archive=$day.tar

# create compressed archive
echo "Create archive $archive from $1"
tar czf $archive $1
