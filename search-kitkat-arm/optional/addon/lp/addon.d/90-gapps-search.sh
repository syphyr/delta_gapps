#!/sbin/sh
# 
# /system/addon.d/90-gapps-search.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/Velvet/Velvet.apk
priv-app/Velvet/lib/arm/libcronet.59.0.3056.4.so
priv-app/Velvet/lib/arm/libframesequence.so
priv-app/Velvet/lib/arm/libgoogle_speech_jni.so
priv-app/Velvet/lib/arm/libgoogle_speech_micro_jni.so
priv-app/Velvet/lib/arm/libnativecrashreporter.so
priv-app/Velvet/lib/arm/liboffline_actions_jni.so
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
    rm -rf /system/app/QuickSearchBox
    chmod 755 /system/priv-app/Velvet
    chmod 755 /system/priv-app/Velvet/lib
    chmod 755 /system/priv-app/Velvet/lib/arm
  ;;
esac
