#!/sbin/sh
# 
# /system/addon.d/80-gapps-tts.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleTTS.apk
lib/libtts_android_neon.so
lib/libtts_android.so
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
    rm -f /system/app/PicoTts.apk
  ;;
esac
