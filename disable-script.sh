#!/bin/bash

ALTERNATIVE_PATH="/usr/local/cpanel/base/frontend/jupiter"
FEATURE_FILE="dynamicui.conf"

FEATURE_ARRAY=$(cat $ALTERNATIVE_PATH/$FEATURE_FILE | grep -E '"key": "' | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')


# List disabled features 
function disabled_features_list() {
    find //usr/local/cpanel/base/frontend/jupiter/dynamicui -type f -name 'dynamicui_hide*' | grep -E '*hide_*' | cut -d / -f10 | cut -d _ -f3-4 | cut -d . -f 1




}

# Print out the usage 
function usage () {

    echo '------------- Command Usage -------------'
    echo "Usage example: "
    echo "Provide as argument the feature to disable"
    echo "./enable-script.sh terminal "
    echo
    echo "##############################################################"
    echo
    echo " To display available features use --list argument"
    echo "Example ./enable-script.sh --list"
    echo "[--help] | [ -h] | [-H ]to display this menu"
    echo
    echo " To list disabled features use --list-disabled or -d" 

}

# Display the available features that can be disabled/enabled
function display_features () {
    find $ALTERNATIVE_PATH -type f -name "dynamicui.conf" -exec readlink -f {} \;
    echo "cPanel Feature file found!"
    echo "Displaying feature list"
    echo 
    FEATURE_ARRAY=$(cat $ALTERNATIVE_PATH/$FEATURE_FILE | grep -E '"key": "' | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')

    for i in ${FEATURE_ARRAY[@]}
    do
        echo $i
    done

}


# Check options

case "${1}" in
    --list|-l)
        display_features
        exit 0
        ;;
    --help|-h|-H)
        usage
        exit 0
        ;;
    --list-disabled|-d)
        echo "---------Disabled features----------"
        echo
        disabled_features_list
        exit 0
        ;;
    -*)
        usage
        exit 1
        ;;        

esac


# Vars
MENU="${1}"


if ! [[ "${FEATURE_ARRAY}[@]" =~ "${1}" ]]
then
    echo "${1} Does not exist"
    echo "Provide valid option"
    exit 1
fi

    
# Check if arg[1]/${1} is empty and exit with status 1 if it is
if [[ -z "${MENU}" ]]
then
    echo "Input cant be empty"
    echo
    usage
    echo
    exit 1
fi

FILENAME="dynamicui_hide_${MENU}.conf"
PATH_TO_FILE="/usr/local/cpanel/base/frontend/jupiter/dynamicui"

# Check if the provided feature is in the available features list





if [[ -f "${1}.enabled" ]]
then
    echo "Menu enabled"
    sleep 0.5
    echo "Renaming file to disable Menu $MENU"
    sleep 0.5
    mv -f "${1}.enabled" "${PATH_TO_FILE}/${FILENAME}"
    sleep 0.5
    echo "File Renamed to: ${PATH_TO_FILE}/${FILENAME} "
    echo "Exitting program ${0} !"
    sleep 0.5
    exit 0
fi


if ! [[ -f "${PATH_TO_FILE}/${FILENAME}" ]]
then
    echo "Disabling Menu  $MENU"
    sleep 0.5
    echo -e "[{\"file\":\"${1}\",\"skipobj\":1}]" > /usr/local/cpanel/base/frontend/jupiter/dynamicui/dynamicui_hide_$MENU.conf
    sleep 0.5
    echo "${MENU} Disabled successfully!"
    if [[ -f "$PATH_TO_FILE/${1}.enabled" ]];then
        echo "Enable File exists"
        echo "Renaming file from ${1}.enabled to ${FILENAME}"
        sleep 0.5
        mv -f "$PATH_TO_FILE/${1}.enabled" "${PATH_TO_FILE}/${FILENAME}"
        exit 0
    fi

else
    echo "Checking if file exists"
    sleep 0.5
    echo "File Aready exists/Menu is already disabled"
    echo "Exitting program.. ${0}!"
    sleep 0.5
    exit 0
fi

