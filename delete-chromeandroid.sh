#! /bin/sh

if [ $# -lt 1 ]
then
		echo "Uninstalling org.chromium.chrome.testshell, wiping data and cache directories" >&2
        adb uninstall org.chromium.chrome.testshell|| { echo "Uninstall failed"; exit 1; }
        exit
fi

while getopts "k" opt; do
	case $opt in
		k)
			echo "Uninstalling org.chromium.chrome.testshell, keeping data and cache directories" >&2
			adb shell pm uninstall -k org.chromium.chrome.testshell || { echo "Uninstall failed"; exit 1; }
			;;
		*)
			echo "Usage: $0 [-k]" >&2
			exit 1
			;;
	esac
done

