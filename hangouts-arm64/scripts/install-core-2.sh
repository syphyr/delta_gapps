#!/sbin/sh

APKFILE="Hangouts.apk"
APKPATH="/tmp/apkbin/app/Hangouts"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ "$LCD" == 213 ] || [ "$LCD" == 240 ]; then
  echo "LCD 213,240 detected."
  if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
    echo lp
    cd "$APKPATH"
    /tmp/unzip -o "$APKFILE" lib/* -d ./
    mkdir -p ./lib/arm64
    mv ./lib/arm64-v8a/* ./lib/arm64/
    rmdir ./lib/arm64-v8a
    /tmp/zip "$APKFILE" -d ./lib/arm64-v8a/*
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
