#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/preferred-apps/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleLoginService/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
usr/srec/en-US/c_fst
usr/srec/en-US/clg
usr/srec/en-US/commands.abnf
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/contacts.abnf
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_acoustic_model
usr/srec/en-US/g2p_fst
usr/srec/en-US/grammar.config
usr/srec/en-US/hclg_shotword
usr/srec/en-US/hmmlist
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hotword.config
usr/srec/en-US/hotword_classifier
usr/srec/en-US/hotword_normalizer
usr/srec/en-US/hotword_prompt.txt
usr/srec/en-US/hotword_word_symbols
usr/srec/en-US/metadata
usr/srec/en-US/normalizer
usr/srec/en-US/norm_fst
usr/srec/en-US/offensive_word_normalizer
usr/srec/en-US/phonelist
usr/srec/en-US/phone_state_map
usr/srec/en-US/rescoring_lm
usr/srec/en-US/wordlist
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
    chmod 755 /system/etc/preferred-apps
    chmod 755 /system/etc/sysconfig
    chmod 755 /system/priv-app/ConfigUpdater
    chmod 755 /system/priv-app/GoogleBackupTransport
    chmod 755 /system/priv-app/GoogleFeedback
    chmod 755 /system/priv-app/GoogleLoginService
    chmod 755 /system/priv-app/GoogleOneTimeInitializer
    chmod 755 /system/priv-app/GooglePartnerSetup
    chmod 755 /system/priv-app/GoogleServicesFramework
    chmod 755 /system/priv-app/Phonesky
    chmod 755 /system/priv-app/PrebuiltGmsCore
    chmod 755 /system/priv-app/SetupWizard
    chmod 755 /system/usr/srec
    chmod 755 /system/usr/srec/en-US
  ;;
esac
