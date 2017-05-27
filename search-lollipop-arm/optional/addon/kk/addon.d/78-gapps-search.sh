#!/sbin/sh
# 
# /system/addon.d/78-gapps-search.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/Velvet.apk
lib/libccl.so
lib/libcronet.59.0.3071.25.so
lib/libframesequence.so
lib/libgoogle_speech_jni.so
lib/libgoogle_speech_micro_jni.so
lib/libnativecrashreporter.so
lib/liboffline_actions_jni.so
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
    rm -f /system/app/QuickSearchBox.apk
  ;;
esac
