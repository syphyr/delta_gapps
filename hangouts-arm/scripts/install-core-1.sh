#!/sbin/sh

APKFILE="Hangouts.apk"
APKPATH="/tmp/apkbin/app/Hangouts"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ "$LCD" == 160 ]; then
  echo "LCD 160 detected."
  if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
    echo lp
    cd "$APKPATH"
    /tmp/unzip -o "$APKFILE" lib/* -d ./
    mkdir -p ./lib/arm
    mv ./lib/armeabi-v7a/* ./lib/arm/
    rmdir ./lib/armeabi-v7a
    /tmp/zip "$APKFILE" -d ./lib/armeabi-v7a/*
    /tmp/zipalign -f 4 "$APKFILE" aligned.apk
    mv aligned.apk "$APKFILE"
    cp -a /tmp/addon/lp/* /system/
    cp -a /tmp/apkbin/app/* /system/priv-app/
  else
    echo mm
    cp -a /tmp/addon/mm/* /system/
    cp -a /tmp/apkbin/* /system/
  fi
fi
rm -f "$APKPATH"/"$APKFILE"
