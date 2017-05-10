#!/sbin/sh
# 
# /system/addon.d/94-gapps-hindiime.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/HindiIMEGoogle.apk
lib/libassamese_data_bundle.so
lib/libbengali_data_bundle.so
lib/liben_data_bundle.so
lib/libgnustl_shared.so
lib/libgujarati_data_bundle.so
lib/libhindi_data_bundle.so
lib/libhmm_hwr_hi.so
lib/libhwrword.so
lib/libkannada_data_bundle.so
lib/libmalayalam_data_bundle.so
lib/libmarathi_data_bundle.so
lib/liboriya_data_bundle.so
lib/libpunjabi_data_bundle.so
lib/libtamil_data_bundle.so
lib/libtelugu_data_bundle.so
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
    # Stub
  ;;
esac
