#!/sbin/sh
# 
# /system/addon.d/94-gapps-hindiime.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/HindiIMEGoogle/HindiIMEGoogle.apk
app/HindiIMEGoogle/lib/arm64/libassamese_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libbengali_data_bundle.so
app/HindiIMEGoogle/lib/arm64/liben_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libgnustl_shared.so
app/HindiIMEGoogle/lib/arm64/libgujarati_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libhindi_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libhmm_hwr_hi.so
app/HindiIMEGoogle/lib/arm64/libhwrword.so
app/HindiIMEGoogle/lib/arm64/libkannada_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libmalayalam_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libmarathi_data_bundle.so
app/HindiIMEGoogle/lib/arm64/liboriya_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libpunjabi_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libtamil_data_bundle.so
app/HindiIMEGoogle/lib/arm64/libtelugu_data_bundle.so
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
    chmod 755 /system/app/HindiIMEGoogle/lib/arm64
  ;;
esac
