#!/bin/bash

# liteeth_mac_axi_mii
echo "Setting up liteeth_mac_axi_mii..."
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[ -d $LITEETH_DIR/scripts/build ] && rm -rf build && echo "Cleaning previous build..."
python $LITEETH_REPO/liteeth/gen.py $LITEETH_REPO/examples/axi-lite-mii.yml && echo "Generating axi core..."
cp $CUR_DIR/build/gateware/liteeth_core.v $LITEETH_DIR/liteeth_mac_axi_mii.v

if [ ! -d $LITEETH_DIR/liteeth_builds/mac_axi_build ]; then
    mkdir $LITEETH_DIR/liteeth_builds && mkdir $LITEETH_DIR/liteeth_builds/mac_axi_build
    cp -r build $LITEETH_DIR/liteeth_builds/mac_axi_build
else
    echo "Original build in $LITEETH_DIR/scripts/build"
fi

patch -l $LITEETH_DIR/liteeth_mac_axi_mii.v < $CUR_DIR/patch/mac_axi.patch && echo "Converting to ASIC..."

[ -d $LITEETH_DIR/scripts/build ] && rm -rf build && echo "Cleaning previous build..."