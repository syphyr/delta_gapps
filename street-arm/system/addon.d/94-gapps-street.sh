#!/sbin/sh
# 
# /system/addon.d/94-gapps-street.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleStreet/GoogleStreet.apk
app/GoogleStreet/lib/arm/libcrashreporterer.so
app/GoogleStreet/lib/arm/libfacenet.so
app/GoogleStreet/lib/arm/libinput_client.so
app/GoogleStreet/lib/arm/liblightcycle.so
app/GoogleStreet/lib/arm/libphotosphere_utils.so
app/GoogleStreet/lib/arm/librocket.so
app/GoogleStreet/lib/arm/libstreetview_vr.so
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
    chmod 755 /system/app/GoogleStreet
    chmod 755 /system/app/GoogleStreet/lib
    chmod 755 /system/app/GoogleStreet/lib/arm
  ;;
esac
