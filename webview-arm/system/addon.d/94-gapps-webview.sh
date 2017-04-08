#!/sbin/sh
# 
# /system/addon.d/94-gapps-webview.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleWebview/GoogleWebview.apk
app/GoogleWebview/lib/arm/libwebviewchromium.so
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
    rm -rf /system/app/webview
    rm -f /system/lib/libwebviewchromium.so
    chmod 755 /system/app/GoogleWebview
    chmod 755 /system/app/GoogleWebview/lib
    chmod 755 /system/app/GoogleWebview/lib/arm
  ;;
esac
