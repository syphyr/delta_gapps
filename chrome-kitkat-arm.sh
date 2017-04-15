#!/bin/bash

APKLIST=$(find chrome-kitkat-arm/system/app -name com.*.apk | sort)
FILENAME=GoogleChrome.apk
INDIR=chrome-kitkat-arm
NAME=gapps-chrome
VER=arm-k

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for kitkat" | tout
echo "Google Chrome add-on for 4.4.4 (arm) (replaces stock web browser)" | tout
echo "" | tout

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
  mv ./lib/armeabi-v7a/* ./lib/arm/
  rmdir ./lib/armeabi-v7a
  echo "Deleting lib directory inside apk file"
  zip "$FILE" -d lib/armeabi-v7a/*
  cp -a ./lib/arm/* ../lib/
else
  mkdir ./lib/arm
  mv ./lib/armeabi/* ./lib/arm/
  rmdir ./lib/armeabi
  echo "Deleting lib directory inside apk file"
  zip "$FILE" -d lib/armeabi/*
  cp -a ./lib/arm/* ../lib/
fi

echo "Aligning apk and libraries for 32bit systems"
zipalign -f -p 4 "$FILE" "$NOEXT"-aligned.apk
rm "$FILE"
mv "$NOEXT"-aligned.apk "$FILENAME"

echo "Libraries aligned."

fi

echo "Version: $VERSION" | tout
echo "API: $APIVER" | tout

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
./makezipsign.sh "$INDIR" "$NAME" "$VER"
