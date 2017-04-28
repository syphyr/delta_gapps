#!/sbin/sh
# 
# /system/addon.d/71-gapps-faceunlock.sh
#

. /tmp/backuptool.functions




list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
lib/libfacelock_jni.so
lib/libfilterpack_facedetect.so
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/landmark_group_meta_data.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-3-tree7-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-r0-ri30.4a-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rn30-ri30.5-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rp30-ri30.5-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-r.8.1.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-y-r.8.1.bin
vendor/pittpatt/models/recognition/face.face.y0-y0-71-N-tree_7-wmd.bin
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
    mkdir -p /system/app/FaceLock/lib/arm
    chmod 755 /system/app/FaceLock
    chmod 755 /system/app/FaceLock/lib
    chmod 755 /system/app/FaceLock/lib/arm
    chmod -R 755 /system/vendor/pittpatt
    chmod 644 /system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/*
    chmod 644 /system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/*
    chmod 644 /system/vendor/pittpatt/models/recognition/*
    ln -s /system/lib/libfacelock_jni.so /system/app/FaceLock/lib/arm/libfacelock_jni.so
    chown 0:2000 /system/vendor/pittpatt
    chown 0:2000 /system/vendor/pittpatt/models
    chown 0:2000 /system/vendor/pittpatt/models/detection
    chown 0:2000 /system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8
    chown 0:2000 /system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1
    chown 0:2000 /system/vendor/pittpatt/models/recognition
  ;;
esac
