#!/bin/bash

# Tested and working on WSL Ubuntu on Windows 11

echo "Starting Setup..."

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then

    # Windows (Git Bash/MSYS2/Cygwin)
    python -m venv .venv
    source .venv/Scripts/activate

    git config --global core.longpaths true
    git config --global core.autocrlf false
    git config --global core.preloadindex true
    git config --global core.fscache true
elif [[ -n "$WSL_DISTRO_NAME" ]]; then

    # WSL (Windows Subsystem for Linux)
    python3 -m venv .venv
    source .venv/bin/activate
    
    git config --global core.longpaths true
else

    # Linux/macOS/Unix-like systems
    python3 -m venv .venv
    source .venv/bin/activate
fi

pip install --upgrade pip
pip install pyyaml

# Install specific migen commit that litex_setup.py uses
pip install git+https://github.com/m-labs/migen.git@4c2ae8dfeea37f235b52acb8166f12acaaae4f7c

pip install git+https://github.com/enjoy-digital/litex.git
pip install git+https://github.com/enjoy-digital/liteeth.git
pip install git+https://github.com/enjoy-digital/liteiclink.git

echo "Finished Initial Setup"

##########################################################################
######################### SETTING UP CORES ###############################
##########################################################################

rm -rf build
rm -rf scripts/build

cd scripts && \
bash setup_mac_axi.sh && \
bash setup_mac_wb.sh && \
bash setup_udp_sgmii.sh && \
bash setup_udp_rgmii.sh && \
bash setup_udp_raw.sh && \
bash setup_usp_gth.sh && \
rm -rf build
cd ..

echo "setup successful"
