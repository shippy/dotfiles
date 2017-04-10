#!/bin/bash

# During n minutes, check every m seconds that UNPLUGGED has not been unset
# FIXME: This will not work, because the unplug script cannot set a global.
# Workarounds: unplug touches a file (that plug will initially remove?)
check_duration=600
check_freq=10
while [ $check_duration -gt 0 ]
do
	sleep $check_freq
	if [ $UNPLUGGED ]; then
		echo "Aborting cloud-sync" >> /Users/Simon/cloud-sync.log
		exit 1
	fi
	check_duration=$((check_duration-check_freq))
done
echo "Starting cloud-sync" >> /Users/Simon/cloud-sync.log

# TODO: Use AppleScript instead?
root_path=/Applications
suffix=.app
suffix_grep='.[a]pp'
declare -a apps=('Amazon Drive' 'Google Drive' 'Dropbox' 'Box Sync')

for app in "${apps[@]}"
do
	# -g keeps the applications backgrounded; running check ensures no double calls
	process="$app$suffix_grep"
	running=$(ps aux | grep "$process" | wc -l)
	if [ $running -eq 0 ]; then
		open -g "$root_path/$app$suffix"
	fi
done
