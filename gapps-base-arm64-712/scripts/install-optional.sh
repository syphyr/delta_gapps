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

if good_ffc_device; then
  echo "Installing FaceLock."
  cp -a /tmp/face/* /system/
  mkdir -p /system/app/FaceLock/lib/arm64
  ln -s /system/lib64/libfacenet.so /system/app/FaceLock/lib/arm64/libfacenet.so
else
  rm -f /system/addon.d/71-gapps-faceunlock.sh
  rm -f /system/lib64/libfacenet.so
  rm -f /system/lib/libfilterpack_facedetect.so
  rm -f /system/lib64/libfilterpack_facedetect.so
  rm -f /system/vendor/lib/libfrsdk.so
  rm -f /system/vendor/lib64/libfrsdk.so
fi
rm -rf /tmp/face

TYPE=$(grep ro.build.characteristics /system/build.prop | grep tablet);

if [ -f /sdcard/.removesetupwizard ]; then
  sed -i '/Provision/ d' /system/addon.d/70-gapps.sh
  sed -i '/SetupWizard/ d' /system/addon.d/70-gapps.sh
elif [ -f /sdcard/.addsetupwizard ]; then
  sed -i '/Provision/ d' /system/addon.d/70-gapps.sh
  mkdir /system/priv-app/SetupWizard
  if [ ! "$TYPE" == "" ]; then
    echo "Tablet detected."
    cp -f /tmp/setup/priv-app/SetupWizard/SetupWizard.apk /system/priv-app/SetupWizard/
  else
    echo "Phone detected."
    cp -f /tmp/setup/priv-app/SetupWizard/SetupWizard.apk /system/priv-app/SetupWizard/
  fi
else
  rm -rf /system/app/Provision
  mkdir /system/priv-app/SetupWizard
  if [ ! "$TYPE" == "" ]; then
    echo "Tablet detected."
    cp -f /tmp/setup/priv-app/SetupWizard/SetupWizard.apk /system/priv-app/SetupWizard/
  else
    echo "Phone detected."
    cp -f /tmp/setup/priv-app/SetupWizard/SetupWizard.apk /system/priv-app/SetupWizard/
  fi
fi
rm -rf /tmp/setup
