#!/sbin/sh
# 
# /system/addon.d/71-gapps-faceunlock.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
lib/libfacenet.so
lib/libfilterpack_facedetect.so
lib/libfrsdk.so
vendor/lib/libprotobuf-cpp-hack.so
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
    mkdir -p /system/app/FaceLock/lib/arm
    chmod 755 /system/app/FaceLock
    chmod 755 /system/app/FaceLock/lib
    chmod 755 /system/app/FaceLock/lib/arm
    ln -s /system/lib/libfacenet.so /system/app/FaceLock/lib/arm/libfacenet.so
  ;;
esac
