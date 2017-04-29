#!/sbin/sh
# 
# /system/addon.d/79-gapps-earth.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleEarth/GoogleEarth.apk
app/GoogleEarth/lib/arm64/libearthmobile.so
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
    chmod 755 /system/app/GoogleEarth
    chmod 755 /system/app/GoogleEarth/lib
    chmod 755 /system/app/GoogleEarth/lib/arm64
  ;;
esac
