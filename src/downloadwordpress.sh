#!/bin/bash

tmpfolder=tmp-$(date +"%Y%m%d-%Hh%Mm%Ss")

## Ensure there are the right utility installed in the system
downloadwordpress_uget() {
	if which wget > /dev/null 2>&1; then
		wget $1
	elif which curl > /dev/null 2>&1; then
		curl -O $1
	else
		echo Neither wget or curl is installed in the system. I can\'t continue.
		exit
	fi
}

clean_no_path_given () {
	rm latest.tar.gz
	mv wordpress/* $tmpfolder
	mv wordpress/.* $tmpfolder
	rmdir wordpress
}

## Main function 
downloadwordpress () {
	mkdir $tmpfolder
	downloadwordpress_uget https://wordpress.org/latest.tar.gz
	echo Unpacking...
	tar xzf latest.tar.gz
	if [ ! -z $1 ]; then
		mv wordpress $1
		mv $1 ../
		cd ../
		rm -r $tmpfolder
	else
		clean_no_path_given
		echo Finished.
		echo If you wish, you can provides an addition argument to be a named folder with WordPress program files.
	fi
}

## detect if being sourced and
## export if so else execute
## main function with args
if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f downloadwordpress
else
  downloadwordpress "${@}"
  exit $?
fi
