#!/sbin/sh
# 
# /system/addon.d/94-gapps-keep.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleKeep/GoogleKeep.apk
app/GoogleKeep/lib/arm64/libsketchology_native.so
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
    chmod 755 /system/app/GoogleKeep
    chmod 755 /system/app/GoogleKeep/lib
    chmod 755 /system/app/GoogleKeep/lib/arm64
  ;;
esac
