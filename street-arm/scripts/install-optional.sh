#!/sbin/sh

APKFILE="GoogleStreet.apk"
APKPATH="/tmp/apkbin/app/GoogleStreet"

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
 sed -i '/GoogleStreet\/lib/ d' /system/addon.d/94-gapps-street.sh
fi
rm -rf /tmp/apkbin
rm -f /tmp/busybox
rm -f /tmp/unzip
rm -f /tmp/zip
rm -f /tmp/zipalign
