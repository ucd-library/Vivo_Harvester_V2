#! /bin/bash

d=/usr/local/vivo/harvester
tar=~/elements-vivo-harvester-${VIVO_HARVESTER_VERSION}.tar.gz

function initialize_state_txt() {
  echo '0'
  date --utc --iso-8601=sec | sed -e 's/:00/00/'
  echo '0'
}

# If you haven't copied the volume, than this will
# Don't run if a state.txt file exists
if [[ ! -f ${d}/state.txt ]] ; then
  echo "Initializing ${d}"
  for i in /root/config/*.properties; do
      n=$(basename $i)
      sed -e 's|\${env:VIVO_ROOT_PASSWORD}|'"$VIVO_ROOT_PASSWORD"'|g' <$i >${d}/$n
  done
  initialize_state_txt > ${d}/data/state.txt
  ln -s ${d}/data/state.txt ${d}/state.txt
#  [[ -d ${d}/data/other_data ]] || mkdir ${d}/data/other_data
else
  echo "${d}/state.txt exists, previously initialized"
fi

# Switch to CMD
exec "$@"
