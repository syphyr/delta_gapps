#!/sbin/sh

APKFILE="GoogleChrome.apk"
APKPATH="/tmp/apkbin/app/GoogleChrome"

if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
 echo lp
 cd "$APKPATH"
 /tmp/unzip -o "$APKFILE" lib/* -d ./
 mkdir -p ./lib/arm
 mv ./lib/armeabi-v7a/* ./lib/arm/
 rmdir ./lib/armeabi-v7a
 rm -f ./lib/arm/crazy.libchrome.align
 rm -f ./lib/arm/crazy.libchrome.so
 cp -a /tmp/apkbin/* /system/
else
 echo mm
 cp -a /tmp/apkbin/* /system/
 sed -i '/GoogleChrome\/lib/ d' /system/addon.d/78-gapps-chrome.sh
fi
rm -rf /tmp/apkbin
rm -f /tmp/busybox
rm -f /tmp/unzip
