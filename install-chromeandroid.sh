#! /bin/sh

set -u

LATEST=`curl -s http://commondatastorage.googleapis.com/chromium-browser-continuous/Android/LAST_CHANGE`

echo "Latest Chromium/Content Shell for Android is $LATEST\n"

TMP_DL=`mktemp -t chrome-android.XXXX`           || { echo "FATAL: Could not create temp file"; exit 1; }
TMP_CHROME_APK=`mktemp -t chrome-android.XXXX`   || { echo "FATAL: Could not create temp file"; exit 1; }
TMP_CONTENT_APK=`mktemp -t chrome-android.XXXX`  || { echo "FATAL: Could not create temp file"; exit 1; }
REMOTE_APK=http://commondatastorage.googleapis.com/chromium-browser-continuous/Android/$LATEST/chrome-android.zip

echo "Downlaoding \n\t$REMOTE_APK \n\tto $TMP_DL\n"
curl $REMOTE_APK -o $TMP_DL  || { echo "FATAL: downloading $TMP_APK failed"; exit 1; }

echo "Extracting ChromeShell.apk \n\t to $TMP_CHROME_APK...\n"
unzip -p $TMP_DL chrome-android/apks/ChromeShell.apk >> $TMP_CHROME_APK || { echo "FATAL: extracting $TMP_APK failed"; exit 1; }

echo "Extracting ChromiumTestShell.apk \n\t to $TMP_CONTENT_APK...\n"
unzip -p $TMP_DL chrome-android/apks/ContentShell.apk >> $TMP_CONTENT_APK || { echo "FATAL: extracting $TMP_APK failed"; exit 1; }

##
# Install flags
# '-l' means forward-lock the app
# '-r' means reinstall the app, keeping its data
# '-s' means install on SD card instead of internal storage
##

while getopts "rsl" opt; do
	case $opt in
		l)
			echo "- with forward-lock" >&2
			;;
		r)
			echo "- reinstalling, keeping data" >&2
			;;
		s)
			echo "- on SD card \n" >&2
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

echo "Installing ContentShell..."
adb install $@ $TMP_CONTENT_APK || { echo "FATAL: adb install failed"; exit 1; }

echo "Installing ChromeShell..."
adb install $@ $TMP_CHROME_APK  || { echo "FATAL: adb install failed"; exit 1; }
