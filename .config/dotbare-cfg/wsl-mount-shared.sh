#!/bin/sh
retries=3
delay=5
count=0
while [ $count -lt $retries ]; do
    mount -t drvfs "\\\\Venus\\shared" /mnt/shared && exit 0
    count=$((count + 1))
    sleep $delay
done
echo "$(date) - Failed to mount \\\\Venus\\shared after $retries attempts" 1>&2
exit 1
