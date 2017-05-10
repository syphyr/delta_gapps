#!/sbin/sh
# 
# /system/addon.d/94-gapps-hindiime.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/HindiIMEGoogle/HindiIMEGoogle.apk
app/HindiIMEGoogle/lib/arm/libassamese_data_bundle.so
app/HindiIMEGoogle/lib/arm/libbengali_data_bundle.so
app/HindiIMEGoogle/lib/arm/liben_data_bundle.so
app/HindiIMEGoogle/lib/arm/libgnustl_shared.so
app/HindiIMEGoogle/lib/arm/libgujarati_data_bundle.so
app/HindiIMEGoogle/lib/arm/libhindi_data_bundle.so
app/HindiIMEGoogle/lib/arm/libhmm_hwr_hi.so
app/HindiIMEGoogle/lib/arm/libhwrword.so
app/HindiIMEGoogle/lib/arm/libkannada_data_bundle.so
app/HindiIMEGoogle/lib/arm/libmalayalam_data_bundle.so
app/HindiIMEGoogle/lib/arm/libmarathi_data_bundle.so
app/HindiIMEGoogle/lib/arm/liboriya_data_bundle.so
app/HindiIMEGoogle/lib/arm/libpunjabi_data_bundle.so
app/HindiIMEGoogle/lib/arm/libtamil_data_bundle.so
app/HindiIMEGoogle/lib/arm/libtelugu_data_bundle.so
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
    chmod 755 /system/app/HindiIMEGoogle
    chmod 755 /system/app/HindiIMEGoogle/lib
    chmod 755 /system/app/HindiIMEGoogle/lib/arm
  ;;
esac
