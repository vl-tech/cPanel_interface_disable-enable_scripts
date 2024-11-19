# cPanel Enable/Disable scripts for features in cPanel frontend panel

## The script is built for the sole purpose of practicing file manipulation.

## Using the WHM interface or whmapi is recommended.

- The script will manually rename files and add content to them ,in order to disable a feature in cPanel interface

- Location where the script will make changes is `/usr/local/cpanel/base/frontend/jupiter/dynamicui`
- It will create a file named `dynamicui_hide_<Feature>.conf` with the below content to disable a cPanel feature

```bash
[{"file":"terminal","skipobj":1}]

```

## Example

- Lets disable the terminal menu first
- Requirements: Enabled SSH access and Terminal feature for the cPanel account.
- However removing the embedded terminal can prevent users deleting cPanel files by acciddent

```bash
/root/scripts/disable-script.sh --list

```

- Will list available features to disable

```bash
/root/scripts/disable-script.sh terminal
```

- Output example 

```bash
Menu enabled
Renaming file to disable Menu terminal
File Renamed to: /usr/local/cpanel/base/frontend/jupiter/dynamicui/dynamicui_hide_terminal.conf
Exitting program /root/scripts/disable-script.sh !

```

```bash
/root/scripts/disable-script.sh application_manager
Disabling Menu  application_manager
application_manager Disabled successfully!

```

### The same way it can be enabled

```bash
/root/scripts/enable-script.sh terminal
File dynamicui_hide_terminal.conf found
Path to the file /usr/local/cpanel/base/frontend/jupiter/dynamicui/dynamicui_hide_terminal.conf

Renaming file to enable Menu: terminal
File  Renamed to : terminal.enabled
Menu Enabled Successfully
Exitting Program /root/scripts/enable-script.sh!

```

```bash
/root/scripts/enable-script.sh application_manager
File dynamicui_hide_application_manager.conf found
Path to the file /usr/local/cpanel/base/frontend/jupiter/dynamicui/dynamicui_hide_application_manager.conf

Renaming file to enable Menu: application_manager
File  Renamed to : application_manager.enabled
Menu Enabled Successfully
Exitting Program /root/scripts/enable-script.sh!


```