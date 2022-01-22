# LASSO

 The **Localize, Attribute SatelliteS in Orbit** project aims to track the position of satellites using
 Time Difference of Arrival (TDOA). Three or more static base-stations sample the Ultra High Frequency radio spectrum
 with a Software Defined Radio (SDR) peripheral and report the time of arrival of incident signals.
 Finally a centralized server process that information to determine where the satellite is in relation to a fixed point.

This repository contains all base-station code and is designed to be run on a Raspberry Pi 4 with the HackRF One SDR.

## Prerequisites

It is expected that this software is run on a a Raspberry Pi 4 with the "Raspbian GNU/Linux 11 (bullseye)" operating system.  
Other configurations may be possible but are untested.

LASSO has dependenies which not installed on a fresh Raspbian Install. To Install the required software for this project use the commands below:

> sudo apt update  
> sudo apt install -y gnuradio hackrf gr-osmosdr at pps-tools gpsd gpsd-clients python3-gps chrony autossh

## Setup
The lasso-node repository is setup using the lasso-setup utility. To view the
commmands available to this utility use the --help flag as shown below.

> cd tools  
> lasso-setup --help

After all options have been run it is recomended to perform a reboot. Upon the next powerup, the setup process should be complete.
It is a good idea to check if a file named "tunnel.log" has been generated in the top-level lasso-node directory (alongside this README.md). 
If the reverse ssh tunnel was properly configured, there should be text similar to below:

```
[2022-01-18 21:56:01] Creating a new tunnel connection using port 9999... SUCCESS
```
