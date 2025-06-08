# UCSC_ML_suite

1. Setup/clone ORFS:

```bash
git clone https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.git
```

2. Clone benchmarks into the ORFS flow directory.

```bash
cd OpenROAD-flow-scripts/flow
git clone git@github.com:VLSIDA/UCSC_ML_suite.git
```

3. Link the platforms directory, scripts, and Makefile using our setup:

```bash
cd UCSC_ML_suite
./setup.sh

```

4. Run a design!

```bash
make DESIGN_CONFIG=./designs/nangate45/gcd/config.mk
```
