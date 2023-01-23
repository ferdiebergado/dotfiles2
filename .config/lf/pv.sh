#!/bin/sh

get_filename() {
	local filename="$(basename "$1")"
	filename="${filename%.*}"

	echo "$filename"
}

get_image_width() {
	local minsize=128

	local width=$(identify -format '%wx%h\n' "$1" | head -n1 | tr -d '\n' | cut -dx -f1)

	local size=

	[[ $width -gt $minsize ]] && size="-s "$(($2 - 4))x$3""

	echo $size
	
}

resize_image() {

	local minsize=128

	local res=$(identify -format '%wx%h\n' "$1" | head -n1 | tr -d '\n')

	local width=$(echo $res | cut -dx -f1)
	local height=$(echo $res | cut -dx -f2)

	local p=$(bc <<< "scale=2; x=$2*7; y=$width; q=x/y; percent=q*100; percent" | cut -d. -f1)
	[[ $p -gt 99 ]] && p=99

	local size=

	[[ $width -gt $minsize ]] && size="-w $p% -h $p%"


	# echo "$(date +"%Y%m%d_%H%M%S"):,$2,$3,$width,$height,$p%,$size" >>/tmp/tmp.log
	echo "$size"
}

preview_image() {
	# local pidir=/tmp/pv.pid
	#
	# kill $(<$pidir)
	# chafa "$1" -f sixel $res | sed 's/#/\n#/g'
	# local size=$(resize_image "$1" "$2" "$3")
	#
	local size=$(get_image_width "$1" "$2" "$3")

	chafa "$1" -f sixel $size | sed 's/#/\n#/g'

	# img2sixel "$1" $size 3>$pidir | sed 's/#/\n#/g'
}

preview_font() {
	TEMPD=$(mktemp -d)
	FILENAME=$(basename "$1")
	PNG="$TEMPD/${FILENAME##*/}.png"

	fontimage "$1" -o $PNG

	# local size=$(resize_image "$PNG" "$2" "$3")

	local size=$(get_image_width "$PNG" "$2" "$3")

	chafa "$PNG" -f sixel $size | sed 's/#/\n#/g'
	# img2sixel "$PNG" $size | sed 's/#/\n#/g'
}

preview_pdf() {
	pdftoppm "$1" -singlefile -png | chafa -f sixel -s "$(($2 - 2))x$3" | sed 's/#/\n#/g'

	# pdftoppm "$1" -png | img2sixel -h "$(($2 * 10))" -w "$(($3 * 14))" | sed 's/#/\n#/g'

	# local filename=$(get_filename "$1")
	#
	# # echo "FILENAME: $filename" >>/tmp/tmp.log
	#
	# local png=/tmp/"$filename".png
	#
	# pdftoppm "$1" -singlefile -png > $png
	#
	# # local size=$(resize_image "$png" "$2" "$3")
	#
	# local size=$(get_image_width "$png" "$2" "$3")
	#
	# chafa "$png" -f sixel $size | sed 's/#/\n#/g'

	# img2sixel "$png" $size | sed 's/#/\n#/g'	
}

preview_audio() {
	mediainfo "$1"
}

preview_text() {
		highlight -O ansi --force "$1" || true
	
}

case "$1" in
	*.7z | *.a | *.ace | *.alz | *.arc | *.arj | *.bz | *.bz2 | *.cab | *.cpio | *.deb | *.gz | *.jar | \
	*.lha | *.lrz | *.lz | *.lzh | *.lzma | *.lzo | *.rar | *.rpm | *.rz | *.t7z | *.tar | *.tbz | \
	*.tbz2 | *.tgz | *.tlz | *.txz | *.tZ | *.tzo | *.war | *.xz | *.Z | *.zip)
	als "$1" && exit 0
	;;

	# *.tar*)
	# 	tar tf "$1"
	# 	exit 0
	# 	;;
	# *.zip)
	# 	unzip -l "$1"
	# 	exit 0
	# 	;;
	# *.rar)
	# 	unrar l "$1"
	# 	exit 0
	# 	;;
	# *.7z)
	# 	7z l "$1"
	# 	exit 0
	# 	;;
	*.pdf)
		preview_pdf "$1" "$2" "$3" && exit 0
		;;
	*.png | *.jpg | *.svg )
		preview_image "$1" "$2" "$3" && exit 0
		;;
	*.gif)
		img2sixel "$1" | sed 's/#/\n#/g' && exit 0
		;;
	*.doc | *.docx)
		unzip -p "$1" | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g' && exit 0
		;;
	*.ttf)
		preview_font "$1" "$2" "$3"
		exit 0
		;;
	*.mp3|*.m4a|*.aac|*.flac)
		preview_audio "$1"
		exit 0
		;;
	*.md)
		mdcat "$1"
		exit 0
		;;
	*.json)
		preview_text "$1"
		exit 0
		;;
esac

case $(file --mime-type -Lb "$1") in
	image/*)
		preview_image "$1" "$2" "$3"
		;;
	font/*)
		preview_font "$1" "$2" "$3"
		;;
	audio/*)
		preview_audio "$1"
		;;
	text/*)
		preview_text "$1"
		;;
	*)
		file -bi "$1"
		;;
esac
