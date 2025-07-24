#!/bin/bash

# Tested and working on WSL Ubuntu on Windows 11 in ./runorfs.sh

echo "Starting Setup..."

# Change to the script's directory to ensure .venv is created in the right place
export LITEETH_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/repo" && pwd)"
export LITEETH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$LITEETH_DIR" && echo "Working in directory: $(pwd)"

if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

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

if pip --version 2>/dev/null | grep -q "25.1.1"; then
    echo "Pip 25.1.1 is already installed, skipping upgrade..."
else
    echo "Installing/upgrading pip to 25.1.1..."
    pip install --upgrade pip --no-cache-dir
fi

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

REPO_LICENSE=$LITEETH_REPO/LICENSE
LICENSE_FILE=$LITEETH_DIR/LICENSE

if [ ! -f $LICENSE_FILE ]; then
    echo "Copying $REPO_LICENSE  ->  $LICENSE_FILE"
    cp -u $REPO_LICENSE $LICENSE_FILE
fi

echo "Finished Initial Setup"