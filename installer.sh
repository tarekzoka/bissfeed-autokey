#!/bin/sh

# 
# SCRIPT : DOWNLOAD AND INSTALL bissfeed-autokey #
# 
# Command: wget https://raw.githubusercontent.com/tarekzoka/bissfeed-autokey/main/installer.sh -O - | /bin/sh #
# 
# Plugin	... bissfeed-autokey
PACKAGE_DIR='bissfeed-autokey/main'
MY_IPK="enigma2-plugin-extensions-bissfeed-autokey-OE2_all"
MY_DEB="enigma2-plugin-extensions-bissfeed-autokey-OE2_all"
# Auto ... Do not change

# Decide : which package ?
MY_MAIN_URL="https://raw.githubusercontent.com/tarekzoka/"
if which dpkg > /dev/null 2>&1; then
	MY_FILE=$MY_DEB
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_DEB
else
	MY_FILE=$MY_IPK
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_IPK
fi
MY_TMP_FILE="/tmp/"$MY_FILE

echo ''
echo 'welcome to bissfeed-autokey'
echo '**  STARTED  **'                     
echo "**  Uploaded by: tarezoka  **"                 
echo "WELCOME TO bissfeed-autokey"
echo ''

# Remove previous file (if any)
rm -f $MY_TMP_FILE > /dev/null 2>&1

# Download package file
echo 'Downloading '$MY_FILE' ...'
echo $MY_SEP
echo ''
wget -T 2 $MY_URL -P "/tmp/"

# Check download
if [ -f $MY_TMP_FILE ]; then
	# Install
	echo ''
	echo 'Installation started'
	echo $MY_SEP
	echo ''
	if which dpkg > /dev/null 2>&1; then
		apt-get install --reinstall $MY_TMP_FILE -y
	else
		opkg install --force-reinstall $MY_TMP_FILE
	fi
	MY_RESULT=$?

	# Result
	echo ''
	echo ''
	if [ $MY_RESULT -eq 0 ]; then
		echo "   >>>>   SUCCESSFULLY INSTALLED   <<<<"
		echo ''
		echo "   >>>>         RESTARING         <<<<"
		if which systemctl > /dev/null 2>&1; then
			sleep 2; systemctl restart enigma2
		else
			init 4; sleep 4; init 3;
		fi
	else
		echo "   >>>>   INSTALLATION FAILED !   <<<<"
	fi;
	echo ''
	echo '****************************************'
	echo '**                   FINISHED                   **'
	echo '****************************************'
	echo ''
	exit 0
else
	echo ''
	echo "Download failed !"
	exit 1
fi

# --------------------------------------------------------------------------------------