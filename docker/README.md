# Dockerfile

This directory contains code to create a docker image for the VIVO harvester, so
that it can be used in a containerized environment. The Dockerfile is meant to
closely mimic the normal installation.

The typical way that this container is expected to be run is that the directory
`/usr/local/vivo/harvester/data` is either a docker volume or a local mount.  Either
way, it is expected that path is persistent.

This means that some components that users would like to modify for their
respective installations, `/usr/local/vivo/harvester/elements_fetch.properties`,
`/usr/local/vivo/harvester/fragment_loader.properties` and the scripts in
`/usr/local/vivo/harvester/scripts` can be modified on container creation from
the entrypoint script.

Users can do this via the path `/etc/vivo/harvester/`. On the container
creation, if properties files exist in this directory, they are installed into
`/usr/local/vivo/harvester`.  Similarly, any scripts in
`/etc/vivo/harvester/scripts` will be copied to the
`/usr/local/vivo/harvester/scripts` directory.

The properties files and the scripts in this directory are used as defaults.
Note every file goes through a bash style expansion, so that you can modify some
values with updates to your environment variables.  Please review the
individual files for all potential values

## Environment File Example

This example shows using the standard files provided, and environmental
variables to copy specifics into the properties files.

``` yaml
version: '3'
services:
  harvest:
    image: ucdlib/vivo-harvester
    command: tail -f /dev/null
    environment:
      - ELEMENTS_API_ENDPOINT= https://qa-oapolicy.universityofcalifornia.edu:8002/elements-secure-api/v5.5
      - ELEMENTS_API_USERNAME=secret_user
      - ELEMENTS_API_PASSWORD=secret_pw
      - VIVO_API_USERNAME=vivo@ucdavis.edu
      - VIVO_API_PASSWORD=vivo_root_password
      - VIVO_ELEMENTS_GRAPH=http://oapolicy.universityofcalifornia.edu
      - VIVO_BASEURI_PREFIX=http://experts.library.ucdavis.edu/
    volumes:
       - ./data:/usr/local/vivo/harvester/data

  vivo:
    image:
     ...
```

Here's an example of mounting local scripts files for development reasons.  This
could be used to test your scripts.

``` yaml
  volumes:
    - ./scripts:/usr/local/vivo/harvester/scripts
```

## Dockerfile example

You can also use this as a starting point for your Dockerfile.  Here you can add
in your specific defaults to not clutter up your environment (NO passwords!).
Then use your image with limited environmental variables required.

``` Dockerfile
from ucdlib/vivo-harvester
COPY *.properties /etc/vivo/harvester
COPY scripts/* /etc/vivo/harvester/scripts
```

# Scripts
