#!/sbin/sh
# 
# /system/addon.d/86-gapps-tts.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleTTS/GoogleTTS.apk
app/GoogleTTS/lib/arm/libtts_android_neon.so
app/GoogleTTS/lib/arm/libtts_android.so
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
    rm -rf /system/app/PicoTts
    chmod 755 /system/app/GoogleTTS
    chmod 755 /system/app/GoogleTTS/lib
    chmod 755 /system/app/GoogleTTS/lib/arm
  ;;
esac
