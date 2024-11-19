#!/bin/bash
ALTERNATIVE_PATH="/usr/local/cpanel/base/frontend/jupiter"
FEATURE_FILE="dynamicui.conf"
FEATURE_ARRAY=$(cat $ALTERNATIVE_PATH/$FEATURE_FILE | grep -E '"key": "' | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g')
# Display Disabled features list

function disabled_features_list() {
    find //usr/local/cpanel/base/frontend/jupiter/dynamicui -type f -name 'dynamicui_hide*' | grep -E '*hide_*' | cut -d / -f10 | cut -d _ -f3-5 | cut -d . -f 1


}


# Usage function 
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
    echo "[ --list-disabled ] | [-d] - List all features"
}

# Display all features available
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
    --list)
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



# Variables
MENU="${1}"

# Check if arg[1] is empty and exit program if it is
if [[ -z "${MENU}" ]]
then
    echo "Input cant be empty"
    echo
    usage
    echo
    exit 1
fi

if ! [[ "${FEATURE_ARRAY}[@]" =~ "${1}" ]]
then
    echo "${1} Does not exist"
    echo "Provide valid option"
    exit 1
fi
FILENAME="dynamicui_hide_${MENU}.conf"
PATH_TO_FILE="/usr/local/cpanel/base/frontend/jupiter/dynamicui"


# Checking if  the filename already exists which means that menu is already enabled
# First if checks if the file dynamicui/dynamicui_hide_$MENU.conf does not exist and if it does not 
# It executes the commands after then statement.
# If statement is false and file exists it executes the commands in the else statement

if ! [[ -f $PATH_TO_FILE/$FILENAME ]] 
then
    
     echo "${MENU} is already enabled"
     sleep 1
     echo "Exitting program ${0}!"
     sleep 1
     exit 0
else
     echo "File ${FILENAME} found"
     echo "Path to the file $PATH_TO_FILE/$FILENAME"
     echo
     echo "Renaming file to enable Menu: $MENU"
     sleep 0.5
     mv -f "${PATH_TO_FILE}/${FILENAME}" "${PATH_TO_FILE}/${1}.enabled"
     echo "File  Renamed to : ${1}.enabled"
     echo "Menu Enabled Successfully"
     sleep 0.5
     echo "Exitting Program ${0}!"
     exit 0
fi
