#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
etc/default-permissions/default-permissions.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/preferred-apps/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google_vr_build.xml
etc/sysconfig/google.xml
etc/sysconfig/marlin_common.xml
etc/sysconfig/whitelist_com.android.omadm.service.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GmsCoreSetupPrebuilt/GmsCoreSetupPrebuilt.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleLoginService/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
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
    rm -rf /system/app/BrowserProviderProxy
    rm -rf /system/app/PartnerBookmarksProvider
    rm -rf /system/app/Provision
    chmod 755 /system/app/GoogleContactsSyncAdapter
    chmod 755 /system/app/GoogleExtShared
    chmod 755 /system/etc/default-permissions
    chmod 755 /system/etc/preferred-apps
    chmod 755 /system/etc/sysconfig
    chmod 755 /system/priv-app/ConfigUpdater
    chmod 755 /system/priv-app/GmsCoreSetupPrebuilt
    chmod 755 /system/priv-app/GoogleBackupTransport
    chmod 755 /system/priv-app/GoogleExtServices
    chmod 755 /system/priv-app/GoogleFeedback
    chmod 755 /system/priv-app/GoogleLoginService
    chmod 755 /system/priv-app/GoogleOneTimeInitializer
    chmod 755 /system/priv-app/GooglePartnerSetup
    chmod 755 /system/priv-app/GoogleServicesFramework
    chmod 755 /system/priv-app/Phonesky
    chmod 755 /system/priv-app/PrebuiltGmsCore
    chmod 755 /system/priv-app/SetupWizard
  ;;
esac
