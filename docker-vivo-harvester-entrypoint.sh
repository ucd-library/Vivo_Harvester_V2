#! /bin/bash

d=/usr/local/vivo/harvester
tar=~/elements-vivo-harvester-${VIVO_HARVESTER_VERSION}.tar.gz

if [[ ! -f ${d}/elementsfetch.properties ]] ; then
  cd ${d};
  tar -xzf ${tar}
  echo untarring ${tar} and copying examples to ${d}
  cp examples/example-config/* .
  cp examples/example-bin/*.sh .
  mkdir scripts && cp -r examples/example-scripts/example-elements scripts
fi

# Need to just copy the properties files to /etc/vivo/harvester/ ?
# or maybe root?


# Is this really the best method?
exec "$@"
