# UCSC_ML_suite

1. Clone this repository:

```bash
git clone git@github.com:VLSIDA/UCSC_ML_suite.git
```

1. Run the setup to clone ORFS as a submodule and link the settings:

```bash
cd UCSC_ML_suite
./setup.sh

```

1. [Run ORFS](https://vlsida.github.io/chip-tutorials/orfs-installation.html#run-orfs-docker-image)

1. Run a design

```bash
make DESIGN_CONFIG=./designs/nangate45/gcd/config.mk
```
