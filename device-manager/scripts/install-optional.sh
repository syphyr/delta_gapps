#!/sbin/sh

APKFILE="DeviceManager.apk"
APKPATH="/tmp/apkbin/app/DeviceManager"
SYSPATH="app"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if grep ro.build.version.release /system/build.prop | grep 4.4.; then
  echo kk
  cp -a /tmp/addon/kk/* /system/
  cp -f "$APKPATH"/"$APKFILE" /system/"$SYSPATH"/
elif grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
  echo lp
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/* /system/
else
  echo mm
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/* /system/
fi
rm -rf /tmp/addon
rm -rf /tmp/apkbin
