#!/sbin/sh
# 
# /system/addon.d/91-gapps-drive.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleDrive.apk
lib/libbitmap_parcel.so
lib/libdocscanner_image.so
lib/libfoxit.so
lib/librawpixeldata_native.so
lib/librectifier.so
lib/libwebp_android.so
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
