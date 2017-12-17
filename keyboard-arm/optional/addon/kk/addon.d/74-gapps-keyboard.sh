#!/sbin/sh
# 
# /system/addon.d/74-gapps-keyboard.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/LatinIMEGoogle.apk
lib/libhwrword.so
lib/libjni_delight5decoder.so
lib/libmozc.so
lib/libtensorflow_jni.so
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
    rm -f /system/app/LatinIME.apk
    rm -f /system/lib/libjni_latinime.so
  ;;
esac
