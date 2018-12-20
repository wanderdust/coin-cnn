#!/bin/zsh
for i in {1..211}
do
	# Go to the directory we want to be in
	cd ~/Desktop/stuff/coin_cnn/data/train/$i
	# Remove all file extensions from the ones that have it, then add them to all
	for f in *.jpg; do mv "$f" "${f%.jpg}"; done
	for f in *; do mv "$f" "$f.jpg"; done
	echo "finished!"
done
