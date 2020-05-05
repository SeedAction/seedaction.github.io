#!/usr/bin/env bash
# Purpose: batch image resizer
# Source: https://guides.wp-bullet.com
# Author: Mike

# absolute path to image folder
#FOLDER="/home/agendarts/shared/roman/"

#resize png or jpg to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.jpg' -o -iname '*.png' -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;

#resize png to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.png' -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;

#resize jpg only to either height or width, keeps proportions using imagemagick
#find ${FOLDER} -iname '*.jpg' -exec convert \{} -verbose -resize 50%\> \{} \;

smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}


#MAX_WIDTH=500


#for X in *.jpg

#do 

#    CURRENT_WIDTH= identify -ping -format '%w' "$X"

#    if [ $CURRENT_WIDTH -gt $MAX_WIDTH ]
#    then 
#        echo "$X yes"
#    fi

#done




out_dir="/home/agendarts/events-resized/"

for f in *.jpg
do 
	w=`convert $f -format "%w" info:`
		if [ $w -gt 740 ]; 
			then smartresize $f 740 $out_dir ;
		fi
done



# alternative
#mogrify -path ${FOLDER} -resize ${WIDTH}x${HEIGHT}% *.png -verbose
