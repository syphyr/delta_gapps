#!/sbin/sh

APKFILE="HindiIMEGoogle.apk"
APKPATH="/tmp/apkbin/app/HindiIMEGoogle"
SYSPATH="app"

if grep ro.build.version.release /system/build.prop | grep 4.4.; then
  echo kk
  cd "$APKPATH"
  unzip -o "$APKFILE" lib/* -d ./
  mkdir -p ./lib/arm64
  mv ./lib/arm64-v8a/* ./lib/arm64/
  rmdir ./lib/arm64-v8a
  /tmp/zip "$APKFILE" -d ./lib/arm64-v8a/*
  /tmp/zipalign -f 4 "$APKFILE" aligned.apk
  mv aligned.apk "$APKFILE"
  cp -a /tmp/addon/kk/* /system/
  cp -f "$APKPATH"/"$APKFILE" /system/"$SYSPATH"/
  cp -a "$APKPATH"/lib/arm64/* /system/lib64/
elif grep ro.build.version.release /system/build.prop | grep -qE '5.0.|5.1.'; then
  echo lp
  cd "$APKPATH"
  unzip -o "$APKFILE" lib/* -d ./
  mkdir -p ./lib/arm64
  mv ./lib/arm64-v8a/* ./lib/arm64/
  rmdir ./lib/arm64-v8a
  /tmp/zip "$APKFILE" -d ./lib/arm64-v8a/*
  /tmp/zipalign -f 4 "$APKFILE" aligned.apk
  mv aligned.apk "$APKFILE"
  cp -a /tmp/addon/lp/* /system/
  cp -a /tmp/apkbin/* /system/
else
 echo mm
 cp -a /tmp/addon/lp/* /system/
 cp -a /tmp/apkbin/* /system/
 sed -i '/HindiIMEGoogle\/lib/ d' /system/addon.d/94-gapps-hindiime.sh
fi
rm -rf /tmp/addon
rm -rf /tmp/apkbin
