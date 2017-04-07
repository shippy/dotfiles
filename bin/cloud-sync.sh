#!/bin/bash
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
