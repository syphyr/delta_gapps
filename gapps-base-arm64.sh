#!/bin/bash

APKLIST=$(find gapps-base-arm64/optional/gms -name com.*.apk | sort)
FILENAME=PrebuiltGmsCore.apk
APKPATH=$(find gapps-base-arm64/system/priv-app/Phonesky -name com.*.apk | sort)
APKNAME=Phonesky.apk
INDIR=gapps-base-arm64

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for nougat" | tout
echo "Nougat Base Gapps package for 7.1.2 (arm64)" | tout
echo "" | tout

if [ ! "$APKPATH" == "" ]; then
  DIR=$(dirname "${APKPATH}")
  FILE=${APKPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$DIR"

  if [ ! "$FILE" == "" ]; then
    rm "$APKNAME"
    mv "$FILE" "$APKNAME"

    VERSION=${FILE%_min*}
    VERSION=${VERSION#*_}
    APIVER=$(echo ${FILE#*_min} | cut -d "_" -f 1)

    cd "$BASEDIR"
    echo "Updating Google Play Store" | tout
    echo "Version: $VERSION" | tout
    echo "Minimum API: $APIVER" | tout
    echo "" | tout
  fi
fi

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
      mkdir ./lib/arm64
      cp -a ./lib/arm64-v8a/* ./lib/arm64/
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/arm64-v8a/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/arm64-v8a/
      rm -rf  ./lib/arm64-v8a
    fi

    if [ -d lib.old/arm64-v8a ] ; then
      mkdir ./lib.old/arm64
      cp -a ./lib.old/arm64-v8a/* ./lib.old/arm64/
      rm -rf  ./lib.old/arm64-v8a
    fi

    if [ -d lib/armeabi-v7a ] ; then
      mkdir ./lib/arm
      cp -a ./lib/armeabi-v7a/* ./lib/arm/
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/armeabi-v7a/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/armeabi-v7a/
      rm -rf  ./lib/armeabi-v7a
    fi

    if [ -d lib.old/armeabi-v7a ] ; then
      mkdir ./lib.old/arm
      cp -a ./lib.old/armeabi-v7a/* ./lib.old/arm/
      rm -rf  ./lib.old/armeabi-v7a
    fi

    echo "Aligning apk and libraries for 32bit systems"
    zipalign -f -p 4 "$FILE" "$NOEXT"-aligned.apk
    rm "$FILE"
    mv "$NOEXT"-aligned.apk "$FILENAME"

    echo "Libraries aligned."
  fi

  echo "Version: $VERSION" | tout
  echo "Minimum API: $APIVER" | tout

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
./makezipsign.sh "$INDIR"
