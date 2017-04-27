#!/sbin/sh
# 
# /system/addon.d/77-gapps-youtube.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/Youtube/Youtube.apk
app/Youtube/lib/arm/libambisonic_audio_renderer.so
app/Youtube/lib/arm/libcronet.59.0.3056.4.so
app/Youtube/lib/arm/libdrishti_jni_native.so
app/Youtube/lib/arm/libfilterframework_jni.so
app/Youtube/lib/arm/libframesequence.so
app/Youtube/lib/arm/libgvr.so
app/Youtube/lib/arm/libluajit.so
app/Youtube/lib/arm/libmoxie.so
app/Youtube/lib/arm/libvpxJNI.so
app/Youtube/lib/arm/libvpx.so
app/Youtube/lib/arm/libwebp_android.so
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
    chmod 755 /system/app/Youtube
    chmod 755 /system/app/Youtube/lib
    chmod 755 /system/app/Youtube/lib/arm
  ;;
esac
