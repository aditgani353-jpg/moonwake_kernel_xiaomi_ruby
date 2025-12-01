#!/bin/bash
# Copyright cc 2025 thian

# setup color
red='\033[0;31m'
green='\e[0;32m'
white='\033[0m'
yellow='\033[0;33m'


URL_CLANG="https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r530567.git" # r530567
URL_CLANG2="https://gitlab.com/DR-KernelArchive/clang/r563880.git" # r563880
Clang_DIR="myclang"



function install_dependencies() {
    echo -e "${yellow}Installing dependencies...${white}"
    sudo apt-get update
    sudo apt-get install -y zip wget gcc g++ \
            gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf
    echo -e "${red}Dependencies installed successfully.${white}"
}

function install_2() {
    echo -e "${green}Installing dependencies2...${white}"
    sudo apt install -y nano bc bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd sudo make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu
    echo -e "${red}Dependencies2 installed successfully.${white}"
}

function download_clang(){
    printf "\n${yellow}please select clang version to download:\n1. r530567-crdroidandroid\n2. r563880-DR-KernelArchive\n${white}"
    read -r clang_version
    if [[ $clang_version == "1" ]]; then
        echo -e "${green}Downloading clang r530567...${white}"
        git clone $URL_CLANG $Clang_DIR
        echo -e "${red}Clang r530567 downloaded successfully.${white}"
    elif [[ $clang_version == "2" ]]; then
        echo -e "${green}Downloading clang r563880...${white}"
        git clone $URL_CLANG2 $Clang_DIR
        echo -e "${red}Clang r563880 downloaded successfully.${white}"
    else
        echo -e "${red}Invalid selection. Skipping clang download.${white}"
    fi
}

function install_root(){
    printf "\n${yellow}Do you want to install ksu (kernel su) for root access? (y/n): ${white}"
    read -r install_ksu
    if [[ $install_ksu == "y" || $install_ksu == "Y" ]]; then
        printf "${green}select ksu type:\n1. kernel-su\n2. kernelsu-next-ori\n3. kernelsu-next-by-DR-KernelArchive\n${white}"
        read -r ksu_type
        if [[ $ksu_type == "1" ]]; then
            echo -e "${green}Installing kernel-su...${white}"
            curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s v0.9.5
            echo -e "${red}kernel-su installed successfully.${white}"
        elif [[ $ksu_type == "2" ]]; then
            echo -e "${green}Installing kernelsu-next-ori...${white}"
            curl -LSs "https://raw.githubusercontent.com/KernelSU-Next/KernelSU-Next/next/kernel/setup.sh" | bash -s next
            echo -e "${red}kernelsu-next-ori installed successfully.${white}"
        elif [[ $ksu_type == "3" ]]; then
            echo -e "${green}Installing kernelsu-next-by-DR-KernelArchive...${white}"
            curl -LSs "https://raw.githubusercontent.com/DR-KernelArchive/KernelSU-Next/refs/heads/next/kernel/setup.sh" | bash -s next
            echo -e "${red}kernelsu-next-by-DR-KernelArchive installed successfully.${white}"
        else
            echo -e "${red}Invalid selection. Skipping ksu installation.${white}"
        fi
    else
        echo -e "${yellow}Skipping ksu installation.${white}"
    fi  
}

install_dependencies
install_2
download_clang
install_root