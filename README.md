# Install
Get the latest Chrome on Android Test Shell and install it on all running emulators and connected devices with

`./install-chromeandroid.sh [-slr]`

which accepts the following familiar command line flags:

- `-s` installs on SD card instead of internal storage
- `-l` forward-locks the app
- `-r` reinstalls the app, keeping its data

# Update Existing

`./update-chromeandroid.sh [-slr]`

Same as above and accepts the same flags, but first uninstalls — while preserving data and cache directories — the existing package from the device.

# Deleting
Just for the sake of completness, we include
`./delete-chromeandroid.sh`
which accepts the optional `-k` commandline flag to keep data and cache directories (which you probably never want to do unless you're updating, which is provided for above).

# Automation
These scripts should be suitable for inclusion in other automated workflows: each requirement is validated and the script will terminate immediately with exit code 1 if something bad happens (curl fails, unzip fails, uninstall while updating fails, etc).

Find a few [more details here](http://paul.kinlan.me/installing-chrome-for-android-on-an-emulator/)
