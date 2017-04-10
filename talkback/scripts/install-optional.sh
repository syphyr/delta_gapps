#!/sbin/sh

APKFILE="Talkback.apk"
APKPATH="/tmp/apkbin/app/Talkback"
SYSPATH="priv-app"

if grep ro.build.version.release /system/build.prop | grep 4.4.; then
  echo kk
  cp -a /tmp/addon/kk/* /system/
  cp -f "$APKPATH"/"$APKFILE" /system/"$SYSPATH"/
elif grep ro.build.version.release /system/build.prop | grep 5.0.; then
  echo lp
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/app/* /system/"$SYSPATH"/
elif grep ro.build.version.release /system/build.prop | grep 5.1.; then
  echo lp
  cp -a /tmp/addon/mm/* /system/
  cp -a /tmp/apkbin/* /system/
else
  echo mm
  cp -a /tmp/addon/mm/* /system/
  cp -a /tmp/apkbin/* /system/
fi
rm -rf /tmp/addon
rm -rf /tmp/apkbin
