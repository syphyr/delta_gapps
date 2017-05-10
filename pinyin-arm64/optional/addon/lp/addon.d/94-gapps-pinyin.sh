#!/sbin/sh
# 
# /system/addon.d/94-gapps-pinyin.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GooglePinyinIME/GooglePinyinIME.apk
app/GooglePinyinIME/lib/arm64/liben_data_bundle.so
app/GooglePinyinIME/lib/arm64/libgnustl_shared.so
app/GooglePinyinIME/lib/arm64/libhmm_gesture_hwr_zh.so
app/GooglePinyinIME/lib/arm64/libhwrword.so
app/GooglePinyinIME/lib/arm64/libpinyin_data_bundle.so
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
    chmod 755 /system/app/GooglePinyinIME
    chmod 755 /system/app/GooglePinyinIME/lib
    chmod 755 /system/app/GooglePinyinIME/lib/arm64
  ;;
esac
