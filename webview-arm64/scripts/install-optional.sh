#!/sbin/sh

APKFILE="GoogleWebview.apk"
APKPATH="/tmp/apkbin/app/GoogleWebview"

if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
 echo lp
 cd "$APKPATH"
 /tmp/unzip -o "$APKFILE" lib/* -d ./
 mkdir -p ./lib/arm
 mkdir -p ./lib/arm64
 mv ./lib/armeabi-v7a/* ./lib/arm/
 mv ./lib/arm64-v8a/* ./lib/arm64/
 rmdir ./lib/armeabi-v7a
 rmdir ./lib/arm64-v8a
 /tmp/zip "$APKFILE" -d ./lib/armeabi-v7a/*
 /tmp/zip "$APKFILE" -d ./lib/arm64-v8a/*
 /tmp/zipalign -f 4 "$APKFILE" aligned.apk
 mv aligned.apk "$APKFILE"
 cp -a /tmp/apkbin/* /system/
else
 echo mm
 cp -a /tmp/apkbin/* /system/
 sed -i '/GoogleWebview\/lib/ d' /system/addon.d/94-gapps-webview.sh
fi
rm -rf /tmp/apkbin
rm -f /tmp/busybox
rm -f /tmp/unzip
rm -f /tmp/zip
rm -f /tmp/zipalign
