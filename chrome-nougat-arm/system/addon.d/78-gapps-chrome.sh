#!/sbin/sh
# 
# /system/addon.d/78-gapps-chrome.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleChrome/GoogleChrome.apk
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
    rm -rf /system/app/Browser
    rm -rf /system/app/Chromium
    rm -rf /system/app/Gello
    rm -rf /system/app/Jelly
    chmod 755 /system/app/GoogleChrome
  ;;
esac
