#! /bin/sh

LATEST=`curl -s http://commondatastorage.googleapis.com/chromium-browser-continuous/Android/LAST_CHANGE`

echo Latest Chromium Android at $LATEST

TMP_DL=`mktemp -t chrome-android.XXXX`
TMP_APK=`mktemp -t chrome-android.XXXX`
REMOTE_APK=http://commondatastorage.googleapis.com/chromium-browser-continuous/Android/$LATEST/chrome-android.zip
echo Downlaoding $REMOTE_APK to $TMP_DL
curl $REMOTE_APK -o $TMP_DL
echo Extracting ChromiumTestShell.apk to $TMP_APK
unzip -p $TMP_DL chrome-android/apks/ChromiumTestShell.apk >> $TMP_APK
adb install $TMP_APK
