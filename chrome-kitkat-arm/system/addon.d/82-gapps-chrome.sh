#!/sbin/sh
# 
# /system/addon.d/82-gapps-chrome.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleChrome.apk
lib/libchrome.1847.114.so
lib/libchrome.1916.122.so
lib/libchrome.1916.138.so
lib/libchrome.1916.141.so
lib/libchrome.1985.122.so
lib/libchrome.1985.128.so
lib/libchrome.1985.131.so
lib/libchrome.1985.135.so
lib/libchrome.2062.117.so
lib/libchrome.2125.102.so
lib/libchrome.2125.114.so
lib/libchrome.2171.37.so
lib/libchrome.2171.59.so
lib/libchrome.so
lib/libchromeview.so
lib/libchromium_android_linker.so
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
    rm -f /system/app/Browser.apk
    rm -f /system/app/Jelly.apk
  ;;
esac
