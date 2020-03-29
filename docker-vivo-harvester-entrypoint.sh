#! /bin/bash

d=/usr/local/vivo/harvester
tar=~/elements-vivo-harvester-${VIVO_HARVESTER_VERSION}.tar.gz

function initialize_state_txt() {
  echo '0'
  date --utc --iso-8601=sec
  echo '0'
}

# Don't run if a state.txt file exists
if [[ ! -f ${d}/state.txt ]] ; then
  echo "Initializing ${d}"
  tar -xzf --directory=${d} ${tar}
  cp examples/example-config/* ${d}
  cp examples/example-bin/*.sh ${d}
  mkdir scripts && cp -r examples/example-scripts/example-elements scripts
  initialize_state_txt > ${d}/state.txt
  mkdir ${d}/data
else
  echo "${d}/state.txt exists, previously initialized"
fi

# Switch to CMD
exec "$@"
