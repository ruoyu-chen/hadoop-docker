#!/bin/bash

if [ -z "$1" ] ; then
    echo "usage : $0 : <hosts files>"
    exit 1
fi

files="$*"
remote_dir="hadoop-dns"

for host in  $(cat $* |  grep -v '#')
do
    echo
    echo "==== $host ==== "
    rsync -avz --delete -e ssh  a.jar run.sh $files "${host}:${remote_dir}"
    ssh $host "cd ${remote_dir} ;  sh run.sh $files"
done
