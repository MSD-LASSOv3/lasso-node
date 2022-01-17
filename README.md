# LASSO

 The **Localize, Attribute SatelliteS in Orbit** project aims to track the position of satellites using
 Time Difference of Arrival (TDOA). Three or more static base-stations sample the Ultra High Frequency radio spectrum
 with a Software Defined Radio (SDR) peripheral and report the time of arrival of incident signals.
 Finally a centralized server process that information to determine where the satellite is in relation to a fixed point.

 This repository contains all base-station code and is designed to be run on a Raspberry Pi 4 with the HackRF One SDR.

## Prerequisites

Install the required software dependencies for this project with the commands below:

 > sudo apt update  
 > sudo apt install -y gnuradio hackrf gr-osmosdr at pps-tools gpsd gpsd-clients python3-gps chrony

## Setup
 The lasso-node repository is setup using the lasso-setup utility. To view the
 commmands available to this utility use the --help flag as shown below.

 > cd bin  
 > lasso-setup --help

 All options will need to be run to complete the setup process.