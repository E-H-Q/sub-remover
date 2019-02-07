#!/bin/bash

change() {
	read -p "Dir: ~/" dir
	cd "$dir"
	files="$(ls | egrep '\.avi$|\.mp4$|\.mkv$' | wc -l)"
	if [ $files == 0 ]
	then
		echo contains no video files!
		cd ~
		change
	else
		echo $files "file(s) found"
		main
	fi
}

main() {
	echo "-- MAIN --"
	echo "Target files: "
	ls -1 | egrep '\.avi$|\.mp4$|\.mkv$'
	echo
	read -p "Modify these files? (Y/N): " -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		for file in *.{avi,mp4,mkv}
		do
			ffmpeg -i "$file" -vcodec copy -acodec copy -sn "(no subs)$file"
		done
	elif [[ $REPLY =~ ^[Nn]$ ]]
	then
		echo 
		change
	fi
}

echo
echo "Current Directory: " `pwd`
echo

read -p "Change dir? (Y/N): " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo 
	change
elif [[ $REPLY =~ ^[Nn]$ ]]
then
	echo
	main
else
	echo
	echo "Unknown input. Exiting..."
	echo
fi
