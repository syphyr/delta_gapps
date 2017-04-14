#!/bin/bash

FILEPATH=$(ls chrome-nougat-arm/system/app/GoogleChrome/com.*.apk)
FILENAME=GoogleChrome.apk
INDIR=chrome-nougat-arm
NAME=gapps-chrome
VER=arm-n

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE for nougat" >> build.log
echo "Google Chrome add-on for 7.0.0+ (arm) (replaces stock web browser) *includes Google Webview*" >> build.log
echo "" >> build.log

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
    echo "Version: $VERSION" >> build.log
    echo "API: $APIVER" >> build.log
    echo "" >> build.log
  fi
fi

./makezipsign.sh "$INDIR" "$NAME" "$VER"
