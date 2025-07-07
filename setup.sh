#!/bin/bash
git submodule init
git submodule update --recursive --depth 1 --recommend-shallow
ln -s OpenROAD-flow-scripts/flow/util .
ln -s OpenROAD-flow-scripts/flow/scripts .
ln -s OpenROAD-flow-scripts/flow/platforms .
