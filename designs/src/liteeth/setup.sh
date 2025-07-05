#!/bin/bash

# Tested and working on WSL Ubuntu on Windows 11

echo "Starting Setup..."

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

# Always activate the virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

if [ -w "$HOME" ] 2>/dev/null || [ -w "$(dirname ~/.gitconfig)" ] 2>/dev/null; then
    git config --global core.longpaths true
    git config --global core.autocrlf false
    git config --global core.preloadindex true
    git config --global core.fscache true
else
    echo "Warning: Cannot set git config (permission denied), skipping..."
fi



check_package() {
    python3 -c "import $1" 2>/dev/null
}

# Check if pip 25.1.1 is already installed
if pip --version 2>/dev/null | grep -q "25.1.1"; then
    echo "Pip 25.1.1 is already installed, skipping upgrade..."
else
    echo "Installing/upgrading pip to 25.1.1..."
    pip install --upgrade pip --no-cache-dir
fi

# Check and install each package with progress
echo "Checking and installing Python packages..."

if ! check_package yaml; then
    echo "Installing PyYAML..."
    pip install --no-cache-dir pyyaml 
fi

if ! check_package migen; then
    echo "Installing Migen (this may take a while)..."
    pip install --no-cache-dir git+https://github.com/m-labs/migen.git@4c2ae8dfeea37f235b52acb8166f12acaaae4f7c 
fi

if ! check_package litex; then
    echo "Installing LiteX (this may take a while)..."
    pip install --no-cache-dir git+https://github.com/enjoy-digital/litex.git 
fi

if ! check_package liteeth; then
    echo "Installing LiteEth (this may take a while)..."
    pip install --no-cache-dir git+https://github.com/enjoy-digital/liteeth.git 
fi

if ! check_package liteiclink; then
    echo "Installing LiteICLink (this may take a while)..."
    pip install --no-cache-dir git+https://github.com/enjoy-digital/liteiclink.git 
fi

echo "Finished Initial Setup"

# SETTING UP CORES

rm -rf build
rm -rf scripts/build

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR/scripts"

[ ! -f "../liteeth_mac_axi_mii.v" ] && bash setup_mac_axi.sh
[ ! -f "../liteeth_mac_wb_mii.v" ] && bash setup_mac_wb.sh  

# Cores left to be modified
[ ! -f "../liteeth_udp_stream_sgmii.v" ] && bash setup_udp_sgmii.sh
[ ! -f "../liteeth_udp_stream_rgmii.v" ] && bash setup_udp_rgmii.sh
[ ! -f "../liteeth_udp_raw_rgmii.v" ] && bash setup_udp_raw.sh
[ ! -f "../liteeth_udp_gth_sgmii.v" ] && bash setup_usp_gth.sh

# bash setup_udp_sgmii.sh && \
# bash setup_udp_rgmii.sh && \
# bash setup_udp_raw.sh && \
# bash setup_usp_gth.sh && \
rm -rf build
cd ..

echo "setup successful"
