#!/sbin/sh

APKFILE="GoogleContacts.apk"
APKPATH="/tmp/apkbin/priv-app/GoogleContacts"

LCD=$(grep ro.sf.lcd_density /system/build.prop | cut -d "=" -f 2);

if [ "$LCD" == 560 ] || [ "$LCD" == 640 ]; then
  echo "LCD 560-640 detected."
  if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
    echo lp
    cp -a /tmp/apkbin/* /system/
  else
    echo mm
    cp -a /tmp/apkbin/* /system/
  fi
fi
rm -rf /tmp/apkbin
