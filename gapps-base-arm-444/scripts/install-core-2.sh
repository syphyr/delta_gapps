#!/sbin/sh

APKFILE="PrebuiltGmsCore.apk"
APKPATH="/tmp/gms/priv-app"
SYSPATH="priv-app"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ "$LCD" == 160 ]; then
  echo "LCD 160 detected."
  cd "$APKPATH"
  /tmp/unzip -o "$APKFILE" lib/* -d ./
  mkdir -p ./lib/arm
  mv ./lib/armeabi-v7a/* ./lib/arm/
  rmdir ./lib/armeabi-v7a
  /tmp/zip "$APKFILE" -d ./lib/armeabi-v7a/*
  /tmp/zipalign -f 4 "$APKFILE" aligned.apk
  mv aligned.apk "$APKFILE"
  cp -f "$APKPATH"/"$APKFILE" /system/"$SYSPATH"/
  cp -a "$APKPATH"/lib/arm/* /system/lib/
fi
rm -f "$APKPATH"/"$APKFILE"
