#!/sbin/sh

APKFILE="PrebuiltGmsCore.apk"
APKPATH="/tmp/gms/priv-app/PrebuiltGmsCore"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ ! "$LCD" == 240 ] && [ ! "$LCD" == 320 ] && [ ! "$LCD" == 480 ]; then
  echo "Installing default."
  cp -a /tmp/gms/* /system/
fi
rm -f "$APKPATH"/"$APKFILE"
