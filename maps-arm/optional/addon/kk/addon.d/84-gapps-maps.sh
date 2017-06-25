#!/sbin/sh
# 
# /system/addon.d/84-gapps-maps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleMaps.apk
lib/libcronet.60.0.3108.3.so
lib/libgmm-jni.so
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
    # Stub
  ;;
esac
