#!/bin/bash

APKLIST=$(find japanese-arm64/optional/apkbin -name com.*.apk | sort)
FILENAME=JapaneseIMEGoogle.apk
INDIR=japanese-arm64
NAME=gapps-japanese
VER=arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for kitkat, lollipop, marshmallow, and nougat" | tout
echo "Google Japanese IME add-on for 4.4.4+ (arm64)" | tout
echo "" | tout

for FILEPATH in $APKLIST ; do

  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  VERSION=${FILE%_min*}
  VERSION=${VERSION#*_}
  APIVER=$(echo ${FILE#*_min} | cut -d "_" -f 1)

  cd "$BASEDIR"
  cd "$DIR"

  echo "Extracting libraries from apk"
  if [ -e "$FILENAME" ]; then
    unzip -o "$FILENAME" lib/* -d ./
    mv lib lib.old
  fi
  unzip -o "$FILE" lib/* -d ./

  if [ ! -d lib/arm64-v8a ] ; then
    echo "Libraries are not for arm64"
  else
    if [ -d lib/arm64-v8a ] ; then
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/arm64-v8a/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/arm64-v8a/
      mkdir ./lib/arm64
      mv ./lib/arm64-v8a/* ./lib/arm64/
      rmdir ./lib/arm64-v8a
    fi

    if [ -d lib.old/arm64-v8a ] ; then
      mkdir ./lib.old/arm64
      mv ./lib.old/arm64-v8a/* ./lib.old/arm64/
      rmdir ./lib.old/arm64-v8a
    fi

    if [ -d lib/armeabi-v7a ] ; then
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/armeabi-v7a/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/armeabi-v7a/
      mkdir ./lib/arm
      mv ./lib/armeabi-v7a/* ./lib/arm/
      rmdir ./lib/armeabi-v7a
    fi

    if [ -d lib.old/armeabi-v7a ] ; then
      mkdir ./lib.old/arm
      mv ./lib.old/armeabi-v7a/* ./lib.old/arm/
      rmdir ./lib.old/armeabi-v7a
    fi

    echo "Aligning apk and libraries for 32bit systems"
    zipalign -f -p 4 "$FILE" "$NOEXT"-aligned.apk
    rm "$FILE"
    mv "$NOEXT"-aligned.apk "$FILENAME"

    echo "Libraries aligned."
  fi

  echo "Version: $VERSION" | tout
  echo "minAPI/DPI: $APIVER" | tout

  if [ -d lib ] && [ -d lib.old ]; then
    diff -rq lib.old lib | grep Only | tout
  fi

  echo "Removing extracted files."
  echo "" | tout

  if [ -d lib ]; then
    rm -rf lib
  fi

  if [ -d lib.old ]; then
    rm -rf lib.old
  fi
done

cd "$BASEDIR"
./makezipsign.sh "$INDIR" "$NAME" "$VER"
