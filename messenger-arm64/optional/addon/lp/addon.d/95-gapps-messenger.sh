#!/sbin/sh
# 
# /system/addon.d/95-gapps-messenger.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/GoogleMessenger/GoogleMessenger.apk
priv-app/GoogleMessenger/lib/arm64/libframesequence.so
priv-app/GoogleMessenger/lib/arm64/libgiftranscode.so
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
    rm -rf /system/app/messaging
    rm -rf /system/priv-app/Mms
    chmod 755 /system/priv-app/GoogleMessenger
    chmod 755 /system/priv-app/GoogleMessenger/lib
    chmod 755 /system/priv-app/GoogleMessenger/lib/arm64
  ;;
esac
