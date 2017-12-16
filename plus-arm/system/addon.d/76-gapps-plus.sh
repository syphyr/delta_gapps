#!/sbin/sh
# 
# /system/addon.d/76-gapps-plus.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GooglePlus/GooglePlus.apk
app/GooglePlus/lib/arm/libcrashreporterer.so
app/GooglePlus/lib/arm/libcronet.64.0.3275.3.so
app/GooglePlus/lib/arm/libframesequence.so
app/GooglePlus/lib/arm/libraisr-jni.so
app/GooglePlus/lib/arm/libwebp_android.so
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
    chmod 755 /system/app/GooglePlus
    chmod 755 /system/app/GooglePlus/lib
    chmod 755 /system/app/GooglePlus/lib/arm
  ;;
esac
