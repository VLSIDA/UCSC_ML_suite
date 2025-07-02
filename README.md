# UCSC_ML_suite

1. Clone this repository:

```bash
git clone git@github.com:VLSIDA/UCSC_ML_suite.git
```

2. Run the setup to clone ORFS as a submodule and link the settings:

```bash
cd UCSC_ML_suite
./setup.sh

```

3. [Run ORFS](https://vlsida.github.io/chip-tutorials/orfs-installation.html#run-orfs-docker-image) (this will run the Docker image corresponding to our submodule):

```bash
./runorfs.sh
```

4. Run a design in the Docker image:

```bash
cd UCSC_ML_suite
make DESIGN_CONFIG=./designs/nangate45/lfsr_top/config.mk
```

## Goal/Objectives

GOAL: Port open source designs to asap7/sky130/nangate45 technologies using ORFS, as a benchmark suite for ML projects.

Objective 1: Setup github CI/CD (to work with google cloud compute engine)

Objective 2: Formulate testbenches to verify the functionality of designs post-flow completion.

Objective 3: Expand suite by creating various versions of designs that fail at specific parts of the flow.

## Resources

In order to change (or update) the UCSC_ML_suite repository, you'll need to submit a pull request. For more information on submitting a PR, see [here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).
