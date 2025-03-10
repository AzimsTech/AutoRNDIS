# Introduction

This project is designed to solve the following problem:

When an OpenWrt router connects to the internet through Android phone USB network sharing (RNDIS), the phone sometimes unexpectedly turns off network sharing (for example, when the router loses power). When this situation occurs, the script uses scheduled tasks to detect and automatically turn on the phone's USB network sharing.

# Usage Instructions

1. Enable Developer Mode on your phone

2. Install ADB on your OpenWrt router

   Reference commands:

   ```shell
   opkg update
   opkg install adb
   ```

3. Connect your phone to the router using a USB cable. The phone will prompt whether to trust the connection; select trust.

4. Save the project script files `net_check.sh` and `wan_check.sh` to the router and make them executable

   ```shell
   wget -O /usr/bin/net_check.sh https://raw.githubusercontent.com/AzimsTech/AutoRNDIS/master/net_check.sh
   wget -O /usr/bin/wan_check.sh https://raw.githubusercontent.com/AzimsTech/AutoRNDIS/master/wan_check.sh
   chmod +x /usr/bin/net_check.sh /usr/bin/wan_check.sh
   ```

5. Add to OpenWrt scheduled tasks

   ```shell
   # If the phone hasn't enabled USB network sharing, turn it on
   */5 * * * *  /usr/bin/net_check.sh
   # If internet connection is lost for an extended period, restart the phone
   */50 * * * * /usr/bin/wan_check.sh
   ```
