#!/bin/sh
ENCCMD="openssl cms -encrypt -outform DER"
PREV=""
CERTSON=false
while test "$#" -gt 0
do
	if [ $CERTSON = true ]
	then
	    ENCCMD="$ENCCMD -recip "$1" \
	        -keyopt rsa_padding_mode:oaep"
	elif [ "$PREV" = "-alg" ]
	then
	    ENCCMD="$ENCCMD -$1"
	elif [ "$PREV" = "-in" ]
	then
	    ENCCMD="$ENCCMD -in $1"
	fi
	if [ "$1" = "-recips" ]
	then
#	    ENCCMD="$ENCCMD -recip"
	    CERTSON=true
	fi
	PREV="$1"
	shift
done
exec $ENCCMD
