#!/bin/bash

SCRIPT=$(basename ${BASH_SOURCE[0]})


if test "$#" -eq 0
then
    echo -e "\nUsage: $SCRIPT <FILE_WITH_IDS> <synnet>"
    exit
fi

pre_network=$(mktemp -t net_temp.XXXXXX)
del_field3=$(mktemp -t net_temp.XXXXXX)
del_field4=$(mktemp -t net_temp.XXXXXX)
del_both=$(mktemp -t net_temp.XXXXXX)

fgrep -w -f $1 $2 > $pre_network
awk '{print $3}' $pre_network | sort | uniq | fgrep -v -w -f $1 - > $del_field3
awk '{print $4}' $pre_network | sort | uniq | fgrep -v -w -f $1 - > $del_field4
cat $del_field3 $del_field4 | sort | uniq > $del_both
fgrep -v -w -f $del_both $pre_network
rm /tmp/net_temp.*
