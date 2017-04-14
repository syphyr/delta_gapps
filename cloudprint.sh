#!/bin/bash

FILEPATH=$(find cloudprint/optional/apkbin/app/CloudPrint2 -name com.*.apk | sort)
FILENAME=CloudPrint2.apk
INDIR=cloudprint
NAME=gapps-cloudprint
VER=arm-arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE for kitkat, lollipop, marshmallow, and nougat" >> build.log
echo "Google CloudPrint add-on for 4.4.4+ (arm/arm64)" >> build.log
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
