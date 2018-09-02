#!/sbin/sh

good_ffc_device() {
  if [ -f /sdcard/.forcefacelock ]; then
    return 0
  elif [ -f /sdcard/.removefacelock ]; then
    return 1
  elif cat /proc/cpuinfo | grep -qE 'Victory|herring|sun4i'; then
    return 1
  elif [ -e /system/etc/permissions/android.hardware.camera.front.xml ]; then
    return 0
  else
    return 1
  fi
}

if [ -f /sdcard/.addconfigupdater ]; then
  echo "Installing ConfigUpdater application."
  cp -a /tmp/config/* /system/
else
  sed -i '/ConfigUpdater/ d' /system/addon.d/70-gapps.sh
fi
rm -rf /tmp/config

if [ -e /system/etc/permissions/android.hardware.telephony.gsm.xml ] || [ -e /system/etc/permissions/android.hardware.telephony.cdma.xml ]; then
  echo "Installing dialer framework."
  cp -a /tmp/dialer/* /system/
else
  sed -i '/dialer/ d' /system/addon.d/70-gapps.sh
fi
rm -rf /tmp/dialer

