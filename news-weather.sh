#!/bin/bash

FILEPATH=$(ls news-weather/optional/apkbin/app/GenieWidget2/com.*.apk)
FILENAME=GenieWidget2.apk
INDIR=news-weather
NAME=gapps-news
VER=arm-arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE" >> build.log
echo "Google News & Weather add-on for 4.4.4+ (arm/arm64)" >> build.log

DIR=$(dirname "${FILEPATH}")
FILE=${FILEPATH##*/}
NOEXT=${FILE%\.*}

cd "$DIR"

if ! [ $FILE == "" ]; then
  rm "$FILENAME"
  mv "$FILE" "$FILENAME"
fi

VERSION=$(echo "$FILE" | cut -d "_" -f 2)
APIVER=$(echo "$FILE" | cut -d "_" -f 3)

cd "$BASEDIR"

echo "Version: $VERSION" >> build.log
echo "API: $APIVER" >> build.log
echo "" >> build.log

./makezipsign.sh "$INDIR" "$NAME" "$VER"
