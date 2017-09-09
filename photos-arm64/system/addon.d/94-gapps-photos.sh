#!/sbin/sh
# 
# /system/addon.d/94-gapps-photos.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GooglePhotos/GooglePhotos.apk
app/GooglePhotos/lib/arm64/libcrashreporterer.so
app/GooglePhotos/lib/arm64/libcronet.61.0.3163.27.so
app/GooglePhotos/lib/arm64/libfilterframework_jni.so
app/GooglePhotos/lib/arm64/libflacJNI.so
app/GooglePhotos/lib/arm64/libframesequence.so
app/GooglePhotos/lib/arm64/libmoviemaker-jni.so
app/GooglePhotos/lib/arm64/libnative.so
app/GooglePhotos/lib/arm64/libpanorenderer.so
app/GooglePhotos/lib/arm64/libpano_video_renderer.so
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
    rm -rf /system/app/Gallery2
    rm -rf /system/priv-app/Gallery2
    chmod 755 /system/app/GooglePhotos
    chmod 755 /system/app/GooglePhotos/lib
    chmod 755 /system/app/GooglePhotos/lib/arm64
  ;;
esac
