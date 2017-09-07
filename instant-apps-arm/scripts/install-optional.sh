#!/sbin/sh

APKFILE="InstantApps.apk"
APKPATH="/tmp/apkbin/app/InstantApps"
SYSPATH="app"

echo mm
cp -a /tmp/addon/mm/* /system/
cp -a /tmp/apkbin/* /system/

rm -rf /tmp/addon
rm -rf /tmp/apkbin
