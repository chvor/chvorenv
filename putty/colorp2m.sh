#!/bin/sh

# Converts the colors from an exported Putty session registry tree
# to mintty colors

if [ $# -lt 1 ]; then
	echo "Usage: colorp2m.sh puttexported.reg" 1>&2
	exit 1
else
	F="$1"
fi

mime=`file --mime-type -b -- "$F"`
charset=`file --mime-encoding -b -- "$F"`

if [ "x$mime" != "xtext/plain" ]; then
	echo "WARNING: mime type $mime looks suspicious" 1>&2
fi

if [ "x$charset" != "utf-8" ]; then
	CVT="iconv -f $charset -t utf-8"
else
	CVT="cat"
fi

eval $( cat "$F" | $CVT | grep -e '^"Colour[0-9]\+"="[0-9]\+,[0-9]\+,[0-9]\+"$' | tr -d '"' )
echo "ForegroundColour=$Colour0"
echo "BackgroundColour=$Colour2"
echo "CursorColour=$Colour5"

n=6
for c in Black Red Green Yellow Blue Magenta Cyan White; do
	eval normal=\$Colour$n
	n=$(( $n + 1 ))
	eval bold=\$Colour$n
	n=$(( $n + 1 ))
	echo "$c=$normal"
	echo "Bold$c=$bold"
done
