#!/bin/bash
cd OpenROAD-flow-scripts
tag=$(git describe --tags 2>/dev/null)
if [ -z "$tag" ]; then
  echo "Warning: Commit is not on an exact tag."
  tag="latest" # fallback tag or handle error
fi
echo "Running OpenROAD flow with tag: ${tag}"
docker run --rm -it \
  -u $(id -u ${USER}):$(id -g ${USER}) \
  -v $(pwd)/flow:/OpenROAD-flow-scripts/flow \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ${HOME}/.Xauthority:/.Xauthority \
  --network host \
  --security-opt seccomp=unconfined \
  openroad/orfs:${tag}
