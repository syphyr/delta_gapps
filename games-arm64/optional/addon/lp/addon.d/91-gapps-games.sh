#!/sbin/sh
# 
# /system/addon.d/91-gapps-games.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/PlayGames/PlayGames.apk
app/PlayGames/lib/arm64/libgames_rtmp_jni.so
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
    chmod 755 /system/app/PlayGames
    chmod 755 /system/app/PlayGames/lib
    chmod 755 /system/app/PlayGames/lib/arm64
  ;;
esac
