#!/bin/bash

# ensure only one instance of script is running
if pidof -x $(basename $0) -o %PPID > /dev/null
then
    exit
fi

export $(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME xmonad)/environ | tr '\0' '\n')

    if [ -d /sys/class/power_supply/BAT* ]; then
        CHARGE=$(cat /sys/class/power_supply/BAT*/capacity)
        STATUS=$(cat /sys/class/power_supply/BAT*/status)
        #CHARGE=$(upower -i $(upower -e | grep '/battery') | grep -E percentage|xargs|cut -d' ' -f2|sed s/%//)
        #state=$(upower -i $(upower -e | grep '/battery') | grep  -E state)
        #STATUS=$(echo "${state}" | grep -wo "charging")
    fi

       if [ "$STATUS" = "Charging" ]; then
   if [ "$CHARGE" = "90" ]; then
       notify-send --urgency=CRITICAL "Disconnect Charger" "Level: ${CHARGE}%"
       paplay /usr/share/sounds/freedesktop/stereo/service-login.oga
   fi

else
        if [ "$STATUS" = "Discharging" ]; then
    if [ "$CHARGE" = "30" ]; then
            notify-send --urgency=CRITICAL "Connect Charger" "Level: ${CHARGE}%"
            paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
        fi

    else
            if [ "$STATUS" = "Discharging" ]; then
        if [ "$CHARGE" = "25" ]; then
                notify-send --urgency=CRITICAL "Shutting Down!" "Level: ${CHARGE}%"
                paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
                systemctl poweroff
        fi
             fi
    fi
fi
    sleep 60
done
