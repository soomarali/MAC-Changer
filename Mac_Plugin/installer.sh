#!/bin/sh

# ==============================================
# SCRIPT : DOWNLOAD AND INSTALL MAC Changer plugin #
# =====================================================================================================================
# Command: wget https://raw.githubusercontent.com/soomarali/MAC-Changer/main/Mac_Plugin/installer.sh -qO - | /bin/sh #
# =====================================================================================================================

########################################################################################################################
# Plugin	... Enter Manually
########################################################################################################################

PACKAGE_DIR='MAC-Changer/main/Mac_Plugin'

#MY_IPK="enigma2-plugin-extensions-MAC-plugin_v1.0_all.ipk"
#MY_IPK2="enigma2-plugin-extensions-MAC-plugin_v1.0_py3.ipk"
#MY_DEB="enigma2-plugin-extensions-MAC-plugin_v1.0_all.deb"
#MY_DEB2="enigma2-plugin-extensions-MAC-plugin_v1.0_p3.deb"

########################################################################################################################
# Auto ... Do not change
########################################################################################################################
# Get Python version
python_version=$(python -c 'import sys; print(sys.version_info.major)')
echo "Detected Python version: $python_version"
sleep 2
if [ "$python_version" -lt 3 ]; then
    echo "Python version: $python_version"
    sleep 2
    MY_IPK="enigma2-plugin-extensions-MAC-plugin_v1.0_all.ipk"
    MY_DEB="enigma2-plugin-extensions-MAC-plugin_v1.0_all.deb"
else
    echo "Python version: $python_version"
    sleep 2
    MY_IPK="enigma2-plugin-extensions-plugin_v1.0_py3.ipk"
    MY_DEB="enigma2-plugin-extensions-plugin_v1.0_p3.deb"
fi

# Display selected files
echo "Selected files: $MY_IPK, $MY_DEB"

sleep 4
# Decide : which package ?
MY_MAIN_URL="https://raw.githubusercontent.com/soomarali/"
if which dpkg > /dev/null 2>&1; then
        MY_FILE=$MY_DEB
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_DEB
else
	MY_FILE=$MY_IPK
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR'/'$MY_IPK
fi
MY_TMP_FILE="/tmp/"$MY_FILE


echo ''
echo '************************************************************'
echo '**                         STARTED                        **'
echo '************************************************************'
echo "**                 Uploaded by : ASGHAR ALI                **"
echo "**                 Devolped For: DREAMWORLD                **"
echo "**                 SUPPORT     : 03357300604               **"
echo "************************************************************"
echo ''
sleep 4
# Remove previous file (if any)
rm -f $MY_TMP_FILE > /dev/null 2>&1

# Download package file
MY_SEP='============================================================='
echo $MY_SEP
echo 'Downloading '$MY_FILE' ...'
echo $MY_SEP
echo ''
wget -T 2 $MY_URL -P "/tmp/"

# Check download
if [ -f $MY_TMP_FILE ]; then
	# Install
	echo ''
	echo $MY_SEP
	echo 'Installation started'
	echo $MY_SEP
	echo ''
	if which dpkg > /dev/null 2>&1; then
		dpkg -i --force-overwrite $MY_TMP_FILE
		apt install -f -y
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
	echo '**************************************************'
	echo '**                   FINISHED                   **'
	echo '**	Uploaded BY : ASGHAR ALI	      **'
 	echo '**	Devolped For: DREAMWORLD 	      **'
  	echo '**	SUPPORT     : 03357300604	      **'  
 	echo '**************************************************'
	echo ''
	exit 0
else
	echo ''
	echo "Download failed !"
	exit 1
fi

# ------------------------------------------------------------------------------------------------------------
