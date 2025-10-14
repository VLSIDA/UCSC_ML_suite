#!/bin/bash
git submodule init OpenROAD-flow-scripts
git submodule update --recursive OpenROAD-flow-scripts
ln -s OpenROAD-flow-scripts/flow/util .
ln -s OpenROAD-flow-scripts/flow/scripts .
ln -s OpenROAD-flow-scripts/flow/platforms .
