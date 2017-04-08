#!/sbin/sh
# 
# /system/addon.d/87-gapps-hangouts.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/Hangouts/Hangouts.apk
priv-app/Hangouts/lib/arm/libcrashreporterer.so
priv-app/Hangouts/lib/arm/libcronet.so
priv-app/Hangouts/lib/arm/libframesequence.so
priv-app/Hangouts/lib/arm/libvideochat_jni.so
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
    chmod 755 /system/priv-app/Hangouts
    chmod 755 /system/priv-app/Hangouts/lib
    chmod 755 /system/priv-app/Hangouts/lib/arm
  ;;
esac
