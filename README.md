# LASSO

 The **Localize, Attribute SatelliteS in Orbit ** project aims to track the position of satellites using Time Difference of Arrival (TDOA). Three static base-stations sample radio signals through the use of an Software Defined Radio (SDR) peripheral and report the time of arrival. Finally a centralized server process that information to determine where overhead the satellite is. 

 This repository contains all base-station code and is designed to be run on a Raspberry Pi 4 with the HackRF One SDR. 

## Prerequisites

Install the required software dependencies for this project with the commands below:

> sudo apt update
> sudo apt install -y gnuradio hackrf gr-osmosdr at pps-tools gpsd gpsd-clients python-gps chrony

## Setup
 The lasso-node repository can be setup using the "lasso-node/bin/lasso-setup" utility. To view the commmands available to this utility use the --help flag. All options will need to be run to complete the setup process.
 