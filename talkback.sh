#!/bin/bash

FILEPATH=$(ls talkback/optional/apkbin/app/Talkback/com.*.apk)
FILENAME=Talkback.apk
INDIR=talkback
NAME=gapps-talkback
VER=arm-arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE for kitkat, lollipop, marshmallow, and nougat" >> build.log
echo "Google Talkback add-on for 4.4.4+ (arm/arm64)" >> build.log
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
