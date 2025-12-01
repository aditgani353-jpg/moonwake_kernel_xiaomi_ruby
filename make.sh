#!/bin/bash
# Copyright cc 2025 thian

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'


function moonwake_defconfig(){
    echo -e "${yellow}Setting up MoonWake ruby defconfig...${white}"
    make ARCH=arm64 O=out ruby_defconfig
    #vendor/lz4kd.config vendor/bbr.config vendor/noop.config vendor/lru.config vendor/kernelsu.config vendor/susfs.config
    make ARCH=arm64 O=out vendor/lz4kd.config
    make ARCH=arm64 O=out vendor/bbr.config
    make ARCH=arm64 O=out vendor/noop.config
    make ARCH=arm64 O=out vendor/lru.config
    make ARCH=arm64 O=out vendor/kernelsu.config
    make ARCH=arm64 O=out vendor/susfs.config
    echo -e "${red}MoonWake ruby defconfig set up successfully.${white}"
    echo -e "\n"
    #add vendor/serial.config
    printf "\n${yellow}Do you want to add vendor/serial.config for arduino/esp32 to the defconfig? (y/n): ${white}"
    read -r add_serial
    if [[ $add_serial == "y" || $add_serial == "Y" ]]; then
        make ARCH=arm64 O=out vendor/serial.config
        echo -e "${red}vendor/serial.config added successfully.${white}"
    else
        echo -e "${red}Skipping vendor/serial.config addition.${white}"
    fi
    #add vendor/nethunter.config

    printf "\n${yellow}Do you want to add vendor/nethunter.config for nethunter to the defconfig? (y/n): ${white}"
    read -r add_nethunter
    if [[ $add_nethunter == "y" || $add_nethunter == "Y" ]]; then
        make ARCH=arm64 O=out vendor/nethunter.config
        echo -e "${red}vendor/nethunter.config added successfully.${white}"
    else
        echo -e "${red}Skipping vendor/nethunter.config addition.${white}"
    fi
    echo -e "\n"
    echo -e "${green}Defconfig setup complete.${white}"
    echo -e "\n"
    echo -e "${yellow}You can now proceed to build the kernel using ./build.sh.${white}"
} 