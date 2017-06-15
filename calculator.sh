#!/bin/bash

FILEPATH=$(find calculator/system/app/GoogleCalculator -name com.*.apk | sort)
FILENAME=GoogleCalculator.apk
INDIR=calculator
NAME=gapps-calculator
VER=arm-arm64-lmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for lollipop, marshmallow, and nougat" | tout
echo "Google Calculator add-on for 5.0.2+ (arm/arm64) (replaces stock calculator)" | tout
echo "" | tout

if [ ! "$FILEPATH" == "" ]; then
  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$DIR"

  if [ ! "$FILE" == "" ]; then
    rm "$FILENAME"
    mv "$FILE" "$FILENAME"

    VERSION=${FILE%_min*}
    VERSION=${VERSION#*_}
    APIVER=$(echo ${FILE#*_min} | cut -d "_" -f 1)

    cd "$BASEDIR"

    echo "Version: $VERSION" | tout
    echo "minAPI/DPI: $APIVER" | tout
    echo "" | tout
  fi
fi

./makezipsign.sh "$INDIR" "$NAME" "$VER"
