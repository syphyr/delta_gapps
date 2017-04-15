#!/bin/bash

FILEPATH=$(find news-weather/optional/apkbin/app/GenieWidget2 -name com.*.apk | sort)
FILENAME=GenieWidget2.apk
INDIR=news-weather
NAME=gapps-news
VER=arm-arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for kitkat, lollipop, marshmallow, and nougat" | tout
echo "Google News & Weather add-on for 4.4.4+ (arm/arm64)" | tout
echo "" | tout

if [ ! "$FILEPATH" == "" ]; then
  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$DIR"

  if [ ! "$FILE" == "" ]; then
    rm "$FILENAME"
    mv "$FILE" "$FILENAME"

    VERSION=$(echo "$FILE" | cut -d "_" -f 2)
    APIVER=$(echo "$FILE" | cut -d "_" -f 3)

    cd "$BASEDIR"

    echo "Version: $VERSION" | tout
    echo "API: $APIVER" | tout
    echo "" | tout
  fi
fi

./makezipsign.sh "$INDIR" "$NAME" "$VER"
