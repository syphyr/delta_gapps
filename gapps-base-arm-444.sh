#!/bin/bash

APKLIST=$(find gapps-base-arm-444/optional/gms -name com.*.apk | sort)
FILENAME=PrebuiltGmsCore.apk
APKPATH=$(find gapps-base-arm-444/system/priv-app -name com.*.apk | sort)
APKNAME=Phonesky.apk
INDIR=gapps-base-arm-444

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for kitkat" | tout
echo "Kitkat Base Gapps package for 4.4.4 (arm)" | tout
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
    echo "minAPI/DPI: $APIVER" | tout
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
      rm -rf  ./lib/armeabi-v7a
    else
      mkdir ./lib/arm
      cp -a ./lib/armeabi/* ./lib/arm/
      rm -rf ./lib/armeabi
    fi
    
    rm "$FILENAME"
    mv "$FILE" "$FILENAME"
  fi

  echo "Updating Google Play Services" | tout
  echo "Version: $VERSION" | tout
  echo "minAPI/DPI: $APIVER" | tout

  if [ -d lib ] && [ -d lib.old ]; then
    diff -rq lib.old lib | grep Only | tout
  fi

  echo "" | tout
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
