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

if good_ffc_device; then
  echo "Installing FaceLock."
  cp -a /tmp/face/* /system/
else
  rm -f /system/addon.d/71-gapps-faceunlock.sh
  rm -f /system/app/FaceLock.apk
  rm -f /system/lib/libfacelock_jni.so
  rm -f /system/lib/libfilterpack_facedetect.so
  rm -rf /system/vendor/pittpatt
fi
rm -rf /tmp/face

TYPE=$(grep ro.build.characteristics /system/build.prop | grep tablet);

if [ -f /sdcard/.removesetupwizard ]; then
  sed -i '/Provision/ d' /system/addon.d/70-gapps.sh
else
  rm -f /system/app/Provision.apk
  if [ ! "$TYPE" == "" ]; then
    echo "Tablet detected."
    cp -f /tmp/setup/tablet/priv-app/SetupWizard.apk /system/priv-app/
  else
    echo "Phone detected."
    cp -f /tmp/setup/phone/priv-app/SetupWizard.apk /system/priv-app/
  fi
fi
rm -rf /tmp/setup
