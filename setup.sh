#!/bin/bash
git submodule init
git submodule update --recursive
ln -s OpenROAD-flow-scripts/flow/util .
ln -s OpenROAD-flow-scripts/flow/scripts .
ln -s OpenROAD-flow-scripts/flow/platforms .
ln -s OpenROAD-flow-scripts/flow/Makefile Makefile.openroad
