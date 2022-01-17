#!/bin/bash

bash -c "echo '# the next 3 lines are for GPS PPS signals' >> /boot/config.txt"
bash -c "echo 'dtoverlay=pps-gpio,gpiopin=18' >> /boot/config.txt"
bash -c "echo 'enable_uart=1' >> /boot/config.txt"
bash -c "echo 'init_uart_baud=9600' >> /boot/config.txt"

bash -c "echo 'pps-gpio' >> /etc/modules"

sed -i "s%GPSD_OPTIONS=\"\"%GPSD_OPTIONS=\"-n\"%" /etc/default/gpsd
sed -i "s%DEVICES=\"\"%DEVICES=\"/dev/ttyS0/dev/pps0\"%" /etc/default/gpsd

echo "refclock SHM 0 refid NMEA offset 0.200" >> /etc/chrony/chrony.conf
echo "refclock PPS /dev/pps0 refid PPS lock NMEA" >> /etc/chrony/chrony.conf

#to test PPS do
# lsmod | grep pps
#  or
# sudo ppstest /dev/pps0