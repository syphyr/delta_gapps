#!/sbin/sh

APKFILE="GooglePhotos.apk"
APKPATH="/tmp/apkbin/app/GooglePhotos"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ "$LCD" == 400 ] || [ "$LCD" == 420 ] || [ "$LCD" == 480 ]; then
  echo "LCD 480 detected."
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
    cp -a /tmp/apkbin/* /system/
  else
    echo mm
    cp -a /tmp/apkbin/* /system/
    sed -i '/GooglePhotos\/lib/ d' /system/addon.d/94-gapps-photos.sh
  fi
fi
rm -f "$APKPATH"/"$APKFILE"
