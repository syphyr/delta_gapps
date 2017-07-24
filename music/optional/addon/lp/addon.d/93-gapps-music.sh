#!/sbin/sh
# 
# /system/addon.d/93-gapps-music.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleMusic/GoogleMusic.apk
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
    rm -rf /system/app/Eleven
    rm -rf /system/app/Phonograph
    chmod 755 /system/app/GoogleMusic
  ;;
esac
