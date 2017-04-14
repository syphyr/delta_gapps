#!/bin/bash

APKLIST=$(find gapps-base-arm/optional/gms -name com.*.apk | sort)
FILENAME=PrebuiltGmsCore.apk
APKPATH=$(find gapps-base-arm/system/priv-app/Phonesky -name com.*.apk | sort)
APKNAME=Phonesky.apk
INDIR=gapps-base-arm

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE for nougat" >> build.log
echo "Nougat Base Gapps package for 7.1.2 (arm)" >> build.log
echo "" >> build.log

if [ ! "$APKPATH" == "" ]; then
  DIR=$(dirname "${APKPATH}")
  FILE=${APKPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$DIR"

  if [ ! "$FILE" == "" ]; then
    rm "$APKNAME"
    mv "$FILE" "$APKNAME"

    VERSION=$(echo "$FILE" | cut -d "_" -f 2)
    APIVER=$(echo "$FILE" | cut -d "_" -f 3)

    cd "$BASEDIR"
    echo "Updating Google Play Store" >> build.log
    echo "Version: $VERSION" >> build.log
    echo "API: $APIVER" >> build.log
    echo "" >> build.log
  fi
fi

for FILEPATH in $APKLIST ; do

  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  VERSION=$(echo "$FILE" | cut -d "_" -f 2)
  APIVER=$(echo "$FILE" | cut -d "_" -f 3)

  cd "$BASEDIR"
  cd "$DIR"

  echo "Extracting libraries from apk"
  if [ -e "$FILENAME" ]; then
    unzip -o "$FILENAME" lib/* -d ./
    mv lib lib.old
  fi
  unzip -o "$FILE" lib/* -d ./

  if [ ! -d lib/armeabi-v7a ] && [ ! -d lib/armeabi ] ; then
    echo "Libraries are not for arm"
  else

    if [ -d lib.old/armeabi-v7a ] ; then
      mkdir ./lib.old/arm
      cp -a ./lib.old/armeabi-v7a/* ./lib.old/arm/
      rm -rf  ./lib.old/armeabi-v7a
    else
      mkdir ./lib.old/arm
      cp -a ./lib.old/armeabi/* ./lib.old/arm/
      rm -rf ./lib.old/armeabi
    fi

    if [ -d lib/armeabi-v7a ] ; then
      mkdir ./lib/arm
      cp -a ./lib/armeabi-v7a/* ./lib/arm/
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/armeabi-v7a/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/armeabi-v7a/
      rm -rf  ./lib/armeabi-v7a
    else
      mkdir ./lib/arm
      cp -a ./lib/armeabi/* ./lib/arm/
      #echo "Deleting lib directory inside apk file"
      zip "$FILE" -d ./lib/armeabi/*
      #echo "Inserting decompressed libraries inside apk file"
      zip -r -D -Z store -b ./ "$FILE" ./lib/armeabi/
      rm -rf ./lib/armeabi
    fi

    echo "Aligning apk and libraries for 32bit systems"
    zipalign -f -p 4 "$FILE" "$NOEXT"-aligned.apk
    rm "$FILE"
    mv "$NOEXT"-aligned.apk "$FILENAME"

    echo "Libraries aligned."

  fi

  echo "Version: $VERSION" >> "$BASEDIR"/build.log
  echo "API: $APIVER" >> "$BASEDIR"/build.log

  if [ -d lib ] && [ -d lib.old ]; then
    diff -rq lib.old lib | grep Only >> "$BASEDIR"/build.log
  fi

  echo "" >> "$BASEDIR"/build.log
  echo "Removing extracted files."

  if [ -d lib ]; then
    rm -rf lib
  fi

  if [ -d lib.old ]; then
    rm -rf lib.old
  fi

done

cd "$BASEDIR"
./makezipsign.sh "$INDIR"
