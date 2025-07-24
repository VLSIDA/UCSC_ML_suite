#!/bin/bash

set -e

echo "Setting up $DESIGN_NAME..."

LITEETH_DIR="$BENCH_DESIGN_HOME/src/liteeth"
LITEETH_REPO="$BENCH_DESIGN_HOME/src/liteeth/repo"
PY_GEN=$LITEETH_REPO/liteeth/gen.py
cd "$LITEETH_DIR"

PY_ENV="$LITEETH_DIR/.venv/bin/activate"
source "$PY_ENV"

[ -d $LITEETH_DIR/build ] && rm -rf build && echo "Cleaning previous build..."
python3 $PY_GEN $YML_FILE && echo "Generating axi core..."
cp $LITEETH_DIR/build/gateware/liteeth_core.v $LITEETH_DIR/$DESIGN_NAME.v && echo "Copying verilog files..."

LITEETH_BUILD="${DESIGN_NAME}_build"
if [ ! -d $LITEETH_DIR/liteeth_builds/$LITEETH_BUILD ]; then
    mkdir $LITEETH_DIR/liteeth_builds && mkdir $LITEETH_DIR/liteeth_builds/$LITEETH_BUILD
    cp -r build $LITEETH_DIR/liteeth_builds/$LITEETH_BUILD
else
    echo "Original build in $LITEETH_DIR/liteeth_builds"
fi

[ -d $LITEETH_DIR/build ] && rm -rf build && echo "Cleaning previous build..."