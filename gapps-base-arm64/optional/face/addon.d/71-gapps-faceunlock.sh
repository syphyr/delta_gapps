#!/sbin/sh
# 
# /system/addon.d/71-gapps-faceunlock.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
lib64/libfacenet.so
lib/libfilterpack_facedetect.so
lib64/libfilterpack_facedetect.so
vendor/lib/libfrsdk.so
vendor/lib64/libfrsdk.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    mkdir -p /system/app/FaceLock/lib/arm64
    chmod 755 /system/app/FaceLock
    chmod 755 /system/app/FaceLock/lib
    chmod 755 /system/app/FaceLock/lib/arm64
    ln -s /system/lib64/libfacenet.so /system/app/FaceLock/lib/arm64/libfacenet.so
  ;;
esac
