#!/sbin/sh

APKFILE="PrebuiltGmsCore.apk"
APKPATH="/tmp/gms/priv-app/PrebuiltGmsCore"

echo "Installing default."
cp -a /tmp/gms/* /system/
rm -rf /tmp/gms
