#!/bin/sh

notify-send "Getting list of available Wi-Fi networks..."

# Get and format Wi-Fi list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Determine Wi-Fi state
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="睊  Disable Wi-Fi"
else
	toggle="直  Enable Wi-Fi"
fi

# Choose network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: ")
chosen_id=$(echo "${chosen_network:3}" | xargs)

# Exit if nothing selected
[ -z "$chosen_network" ] && exit

if [ "$chosen_network" = "直  Enable Wi-Fi" ]; then
	nmcli radio wifi on
	exit
elif [ "$chosen_network" = "睊  Disable Wi-Fi" ]; then
	nmcli radio wifi off
	exit
fi

success_message="You are now connected to \"$chosen_id\"."
saved_connections=$(nmcli -g NAME connection)

if echo "$saved_connections" | grep -Fxq "$chosen_id"; then
	# Already saved
	if nmcli connection up id "$chosen_id" | grep -q "successfully"; then
		notify-send "Connection Established" "$success_message"
	else
		notify-send "Connection Failed" "Could not connect to \"$chosen_id\"."
	fi
else
	# Not saved; prompt for password if secured
	if echo "$chosen_network" | grep -q ""; then
		wifi_password=$(rofi -dmenu -p "Password for $chosen_id: " -password)

		if [ -n "$wifi_password" ]; then
			if nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep -q "successfully"; then
				notify-send "Connection Established" "$success_message"
			else
				notify-send "Connection Failed" "Wrong password or other error for \"$chosen_id\"."
			fi
		else
			notify-send "Cancelled" "No password entered."
		fi
	else
		# Open network
		if nmcli device wifi connect "$chosen_id" | grep -q "successfully"; then
			notify-send "Connection Established" "$success_message"
		else
			notify-send "Connection Failed" "Could not connect to \"$chosen_id\"."
		fi
	fi
fi
