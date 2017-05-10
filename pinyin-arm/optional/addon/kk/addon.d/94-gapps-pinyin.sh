#!/sbin/sh
# 
# /system/addon.d/94-gapps-pinyin.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GooglePinyinIME.apk
lib/liben_data_bundle.so
lib/libgnustl_shared.so
lib/libhmm_gesture_hwr_zh.so
lib/libhwrword.so
lib/libpinyin_data_bundle.so
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
