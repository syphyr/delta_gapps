#!/sbin/sh
# 
# /system/addon.d/75-gapps-drive.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleDrive/GoogleDrive.apk
app/GoogleDrive/lib/arm/libbitmap_parcel.so
app/GoogleDrive/lib/arm/libdocscanner_image.so
app/GoogleDrive/lib/arm/libfoxit.so
app/GoogleDrive/lib/arm/librawpixeldata_native.so
app/GoogleDrive/lib/arm/librectifier.so
app/GoogleDrive/lib/arm/libwebp_android.so
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
    chmod 755 /system/app/GoogleDrive
    chmod 755 /system/app/GoogleDrive/lib
    chmod 755 /system/app/GoogleDrive/lib/arm
  ;;
esac
