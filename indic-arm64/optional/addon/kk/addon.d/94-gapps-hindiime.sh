#!/sbin/sh
# 
# /system/addon.d/94-gapps-hindiime.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/HindiIMEGoogle.apk
lib64/libassamese_data_bundle.so
lib64/libbengali_data_bundle.so
lib64/liben_data_bundle.so
lib64/libgnustl_shared.so
lib64/libgujarati_data_bundle.so
lib64/libhindi_data_bundle.so
lib64/libhmm_hwr_hi.so
lib64/libhwrword.so
lib64/libkannada_data_bundle.so
lib64/libmalayalam_data_bundle.so
lib64/libmarathi_data_bundle.so
lib64/liboriya_data_bundle.so
lib64/libpunjabi_data_bundle.so
lib64/libtamil_data_bundle.so
lib64/libtelugu_data_bundle.so
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
