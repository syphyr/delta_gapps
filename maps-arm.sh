#!/bin/bash

APKLIST=$(find maps-arm/optional/apkbin -name com.*.apk | sort)
FILENAME="GoogleMaps.apk"
INDIR=maps-arm
NAME=gapps-maps
VER=arm-lmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE" >> build.log
echo "Google Maps add-on for 5.0.2+ (arm)" >> build.log

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

mkdir ./lib/arm
mkdir ./lib.old/arm

if [ -d lib.old/armeabi-v7a ] ; then
  cp -a ./lib.old/armeabi-v7a/* ./lib.old/arm/
  rm -rf  ./lib.old/armeabi-v7a
else
  cp -a ./lib.old/armeabi/* ./lib.old/arm/
  rm -rf ./lib.old/armeabi
fi

if [ -d lib/armeabi-v7a ] ; then
  cp -a ./lib/armeabi-v7a/* ./lib/arm/
  #echo "Deleting lib directory inside apk file"
  zip "$FILE" -d ./lib/armeabi-v7a/*
  #echo "Inserting decompressed libraries inside apk file"
  zip -r -D -Z store -b ./ "$FILE" ./lib/armeabi-v7a/
  rm -rf  ./lib/armeabi-v7a
else
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
./makezipsign.sh "$INDIR" "$NAME" "$VER"
