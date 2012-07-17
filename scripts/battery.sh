#! /bin/bash
# ACPI battery time remaining script, if not on AC poewr

# Get battery line if it contains the discharge word
batt=`acpi -b | grep "Discharging"`

# If the line is not empty
if [[ $batt != "" ]];
then

	# cut out the time portion
	batt=`echo $batt | awk '{print $5}' | cut -c 1-5`

	# echo inside tags for viewing pleasure
	echo "[Time: "$batt"]"

fi
