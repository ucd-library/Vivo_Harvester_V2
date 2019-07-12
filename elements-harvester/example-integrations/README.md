# Example Integrations
This folder contains details of various ways that the harvester can be integrated with other systems when deployed on a server.

## Apache Proxy
This does not strictly relate to the harvester, in that it provides example configuration files for setting up Apache as a reverse poxy in front of the Java Servlet container where you have deployed VIVO.
It is relevant to the harvester though, as having this reverse proxy configuration is essential if you wish to use the "web interface" integration, a specific example configuration file is provided for this use case.

## Cron
This provides examples of how to setup a CRONTAB to automatically run the harvester on a defined schedule, so that the data in your VIVO instance is kept up to date with changes in Elements.

## SystemD
This provides details of how to integrate the FragmentLoader process as a SystemD controlled daemon process.

## Web Interface
This provides information, and a set of CGI scripts, on how to use Apache to enable a simple "web interface" to both control and monitor the harvester.