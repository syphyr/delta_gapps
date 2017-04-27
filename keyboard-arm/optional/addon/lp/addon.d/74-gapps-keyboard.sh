#!/sbin/sh
# 
# /system/addon.d/74-gapps-keyboard.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/LatinIMEGoogle/LatinIMEGoogle.apk
app/LatinIMEGoogle/lib/arm/libjni_delight5decoder.so
app/LatinIMEGoogle/lib/arm/libtensorflow_jni.so
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
    rm -rf /system/app/LatinIME
    rm -f /system/lib/libjni_latinime.so
    chmod 755 /system/app/LatinIMEGoogle
    chmod 755 /system/app/LatinIMEGoogle/lib
    chmod 755 /system/app/LatinIMEGoogle/lib/arm
  ;;
esac
