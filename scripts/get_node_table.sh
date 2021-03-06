#!/bin/bash

if test "$#" -eq 0
then
    echo -e "\nUsage: $0 <COMPLETE_TABLE> <SYNNET>"
    exit
fi

list_file=$(mktemp -t nodetable.XXXXXX)
node_table=$1
synnet_file=$2

cat <(echo sp) <(cat <(awk '{print $3}' $synnet_file) <(awk '{print $4}' $synnet_file) | sort | uniq)  > $list_file
fgrep -w -f $list_file $node_table
