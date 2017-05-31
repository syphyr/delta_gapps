#!/sbin/sh
# 
# /system/addon.d/83-gapps-camera.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleCamera/GoogleCamera.apk
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
    rm -rf /system/app/Camera2
    rm -rf /system/app/OpenCamera
    rm -rf /system/app/Snap
    rm -rf /system/priv-app/Snap
    chmod 755 /system/app/GoogleCamera
    chmod 755 /system/app/GoogleCamera/lib
    chmod 755 /system/app/GoogleCamera/lib/arm
  ;;
esac
