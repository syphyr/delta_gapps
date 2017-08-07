#!/bin/bash

APKLIST=$(find contacts/optional/apkbin -name com.*.apk | sort)
FILENAME=GoogleContacts.apk
INDIR=contacts
NAME=gapps-contacts
VER=arm-arm64-lmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for lollipop, marshmallow, and nougat" | tout
echo "Google Contacts add-on for 5.0.2+ (arm/arm64) (replaces stock contacts)" | tout
echo "" | tout

for FILEPATH in $APKLIST ; do
  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$BASEDIR"
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
done

./makezipsign.sh "$INDIR" "$NAME" "$VER"
