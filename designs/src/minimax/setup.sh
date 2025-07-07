#!/bin/bash

set -euo pipefail

SRC_SV="repo/rtl/minimax.v"
OUT_V="minimax.v"
OPTS="-w"
LICENSE="repo/LICENSE"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Update license from repo
cp -u "$LICENSE" ./

[[ -f "$SRC_SV" ]] \
  || { echo "Error: Source file '$SRC_SV' not found." >&2; exit 1; }

# Convert systemverilog files to verilog
echo "Translating $SRC_SV  ->  $OUT_V"
sv2v $OPTS "$OUT_V" "$SRC_SV"
echo "Done."