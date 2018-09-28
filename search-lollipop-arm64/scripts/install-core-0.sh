#!/sbin/sh

APKFILE="Velvet.apk"
APKPATH="/tmp/apkbin/priv-app/Velvet"
SYSPATH="priv-app"

echo "Installing default."
if grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
  echo lp
  cd "$APKPATH"
  /tmp/unzip -o "$APKFILE" lib/* -d ./
  mkdir -p ./lib/arm64
  mv ./lib/arm64-v8a/* ./lib/arm64/
  rmdir ./lib/arm64-v8a
  rm -rf ./lib/armeabi-v7a
  /tmp/zip "$APKFILE" -d ./lib/arm64-v8a/*
  /tmp/zip "$APKFILE" -d ./lib/armeabi-v7a/*
  /tmp/zipalign -f 4 "$APKFILE" aligned.apk
  mv aligned.apk "$APKFILE"
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/* /system/
else
  echo mm
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/* /system/
  sed -i '/Velvet\/lib/ d' /system/addon.d/90-gapps-search.sh
fi

rm -rf /tmp/apkbin
rm -rf /tmp/addon
rm -f /tmp/busybox
rm -f /tmp/unzip
rm -f /tmp/zip
rm -f /tmp/zipalign
