#!/sbin/sh
# 
# /system/addon.d/94-gapps-translate.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleTranslate.apk
lib/libclientvision.so
lib/libimageutils.so
lib/libtranslate.so
lib/libzxing.so
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
