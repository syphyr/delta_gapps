#!/bin/bash

INDIR="$1"
NAME="$2"
VERSION="$3"
DATE=$(date +%F | sed s/-//g)
DATE=$DATE-1

if ! [ -d "$INDIR" ]; then
  echo "Target is not a directory. Abort."
  exit
fi

if [ -e "$INDIR".zip ] || [ -e "$INDIR"-signed.zip ]; then
  echo "File already exists. Abort."
  exit
fi

if [ -e "$INDIR"/system/etc/g.prop ]; then
  NAME=$(grep ro.addon.type "$INDIR"/system/etc/g.prop | cut -d "=" -f 2)
  VERSION=$(grep ro.addon.minimumversion "$INDIR"/system/etc/g.prop | cut -d "=" -f 2)
  sed -i "s/.*ro.addon.version.*/ro.addon.version=$DATE/" "$INDIR"/system/etc/g.prop
  echo "g.prop updated."
fi

cd "$INDIR"

zip -r ../"$INDIR".zip *

cd ..  

echo "Signing ZIP..."

if [ ! -d out ]; then
  mkdir out
fi

if [ "$NAME" == "" ]; then
  java -jar sign/signapk.jar -w sign/testkey.x509.pem sign/testkey.pk8 "$INDIR".zip ./out/"$INDIR"-signed.zip
  cd out
  md5sum "$INDIR"-signed.zip > "$INDIR"-signed.zip.md5sum
  cd ..
else
  java -jar sign/signapk.jar -w sign/testkey.x509.pem sign/testkey.pk8 "$INDIR".zip ./out/"$NAME"-"$VERSION"-"$DATE"-signed.zip
  cd out
  md5sum "$NAME"-"$VERSION"-"$DATE"-signed.zip > "$NAME"-"$VERSION"-"$DATE"-signed.zip.md5sum
  cd ..
fi

rm "$INDIR".zip

if [ -e build.log ]; then
  cat build.log
fi
