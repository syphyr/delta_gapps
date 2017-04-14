#!/bin/bash

FILEPATH1=$(find pixellauncher-wallpaper/system/app/WallpaperPickerGooglePrebuilt -name com.*.apk | sort)
FILENAME1=WallpaperPickerGooglePrebuilt.apk
FILEPATH2=$(find pixellauncher-wallpaper/system/priv-app/NexusLauncherPrebuilt -name com.*.apk | sort)
FILENAME2=NexusLauncherPrebuilt.apk
INDIR=pixellauncher-wallpaper
NAME=gapps-pixellauncher
VER=arm-arm64-lmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE for lollipop, marshmallow, and nougat" >> build.log
echo "Google Pixel Launcher add-on for 5.0.2+ (arm/arm64) (includes Gooogle Wallpapers)" >> build.log
echo "" >> build.log

if [ ! "$FILEPATH1" == "" ]; then
  DIR1=$(dirname "${FILEPATH1}")
  FILE1=${FILEPATH1##*/}
  NOEXT1=${FILE1%\.*}
  cd "$DIR1"
  if [ ! "$FILE1" == "" ]; then
    rm "$FILENAME1"
    mv "$FILE1" "$FILENAME1"
    VERSION1=$(echo "$FILE1" | cut -d "_" -f 2)
    APIVER1=$(echo "$FILE1" | cut -d "_" -f 3)
    cd "$BASEDIR"
    echo "Updating Google Wallpapers" >> build.log
    echo "Version: $VERSION1" >> build.log
    echo "API: $APIVER1" >> build.log
    echo "" >> build.log
  fi
fi

if [ ! "$FILEPATH2" == "" ]; then
  DIR2=$(dirname "${FILEPATH2}")
  FILE2=${FILEPATH2##*/}
  NOEXT2=${FILE2%\.*}
  cd "$BASEDIR"
  cd "$DIR2"
  if [ ! "$FILE2" == "" ]; then
    rm "$FILENAME2"
    mv "$FILE2" "$FILENAME2"
    VERSION2=$(echo "$FILE2" | cut -d "_" -f 2)
    APIVER2=$(echo "$FILE2" | cut -d "_" -f 3)
    cd "$BASEDIR"
    echo "Updating Google Pixel Launcher" >> build.log
    echo "Version: $VERSION2" >> build.log
    echo "API: $APIVER2" >> build.log
    echo "" >> build.log
  fi
fi

./makezipsign.sh "$INDIR" "$NAME" "$VER"
