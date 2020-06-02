#! /bin/bash
d=/usr/local/vivo/harvester
config=/etc/vivo/harvester

#https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file
function expandVarsStrict(){
  local line lineEscaped
  while IFS= read -r line || [[ -n $line ]]; do  # the `||` clause ensures that the last line is read even if it doesn't end with \n
    # Escape ALL chars. that could trigger an expansion..
    IFS= read -r -d '' lineEscaped < <(printf %s "$line" | tr '`([$' '\1\2\3\4')
    # ... then selectively reenable ${ references
    lineEscaped=${lineEscaped//$'\4'\{/\$\{}
    # Finally, escape embedded double quotes to preserve them.
    lineEscaped=${lineEscaped//\"/\\\"}
    eval "printf '%s\n' \"$lineEscaped\"" | tr '\1\2\3\4' '`([$'
  done
}

function initialize_state_txt() {
  echo '0'
  date --utc --iso-8601=sec | sed -e 's/:00/00/'
  echo '0'
}

# If you haven't copied the volume, than this will
# Don't run if a state.txt file exists
if [[ ! -f ${d}/state.txt ]] ; then
  echo "Initializing ${d}"
  # Overwriting script files
  cp $config/script/* $d/scripts
  initialize_state_txt > ${d}/data/state.txt
  ln -s ${d}/data/state.txt ${d}/state.txt
#  [[ -d ${d}/data/other_data ]] || mkdir ${d}/data/other_data
else
  echo "${d}/state.txt exists, previously initialized"
fi

for i in $config/*.properties; do
  n=$(basename $i)
  if [[ ! -f ${d}/$n ]]; then
    expandVarsStrict <$i >${d}/$n
  fi
done

# Switch to CMD
exec "$@"
