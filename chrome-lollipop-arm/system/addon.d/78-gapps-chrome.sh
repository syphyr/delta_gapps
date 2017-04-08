#!/sbin/sh
# 
# /system/addon.d/78-gapps-chrome.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleChrome/GoogleChrome.apk
app/GoogleChrome/lib/arm/libchrome.1847.114.so
app/GoogleChrome/lib/arm/libchrome.1916.122.so
app/GoogleChrome/lib/arm/libchrome.1916.138.so
app/GoogleChrome/lib/arm/libchrome.1916.141.so
app/GoogleChrome/lib/arm/libchrome.1985.122.so
app/GoogleChrome/lib/arm/libchrome.1985.128.so
app/GoogleChrome/lib/arm/libchrome.1985.131.so
app/GoogleChrome/lib/arm/libchrome.1985.135.so
app/GoogleChrome/lib/arm/libchrome.2062.117.so
app/GoogleChrome/lib/arm/libchrome.2125.102.so
app/GoogleChrome/lib/arm/libchrome.2125.114.so
app/GoogleChrome/lib/arm/libchrome.2171.37.so
app/GoogleChrome/lib/arm/libchrome.2171.59.so
app/GoogleChrome/lib/arm/libchromeview.so
app/GoogleChrome/lib/arm/libchromium_android_linker.so
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
    rm -rf /system/app/Gello
    chmod 755 /system/app/GoogleChrome
    chmod 755 /system/app/GoogleChrome/lib
    chmod 755 /system/app/GoogleChrome/lib/arm
  ;;
esac
