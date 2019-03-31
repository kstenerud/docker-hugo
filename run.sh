#!/bin/sh

WATCH="${HUGO_WATCH:=false}"
SLEEP="${HUGO_REFRESH_TIME:=-1}"
HUGO_DESTINATION="${HUGO_DESTINATION:=/output}"
echo "HUGO_WATCH:" $WATCH
echo "HUGO_REFRESH_TIME:" $HUGO_REFRESH_TIME
echo "ARGS" $@

HUGO=/usr/local/sbin/hugo
echo "Hugo path: $HUGO"

while [ true ]
do
    if [[ $HUGO_WATCH != 'false' ]]; then
	    echo "Watching..."
        $HUGO server --watch=true --source="/src" --destination="$HUGO_DESTINATION" --bind="0.0.0.0" --port=80 --appendPort=false "$@" || exit 1
    else
	    echo "Building one time..."
        $HUGO --source="/src" --destination="$HUGO_DESTINATION" "$@" || exit 1
    fi

    if [[ $HUGO_REFRESH_TIME == -1 ]]; then
        exit 0
    fi
    echo "Sleeping for $HUGO_REFRESH_TIME seconds..."
    sleep $SLEEP
done
