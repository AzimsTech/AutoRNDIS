#!/bin/sh
function network() {
	# Timeout period (in seconds)
	local timeout=30

	# Target URL
	local target=www.google.com

	# Retrieve the response status code
	local ret_code=$(curl -I -s --connect-timeout ${timeout} ${target} -w %{http_code} | tail -n1)

	if [ "x$ret_code" = "x200" ]; then
		# Network available
		return 1
	else
		# Network unavailable
		return 0
	fi

	return 0
}

id=$(adb devices | grep device$)
if [ -z "$id" ]; then
	d=$(date '+%F %T')
	echo "[$d]device not found"
	echo "[$d]device not found" >>/tmp/net_check.log
else
	d=$(date '+%F %T')
	network
	if [ $? -eq 0 ]; then
		echo "[$d] Host network unreachable"
		adb shell reboot
	fi
fi
