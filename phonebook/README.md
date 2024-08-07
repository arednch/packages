# AREDN-Packages: Phonebook

The Phonebook package bundles a phonebook service running on the AREDN Node fetching
a CSV from an upstream server and converting into XML phonebooks which can be fetched by phones.

By now it has grown much beyond that though. For more details, see the source repository which includes an extensive documentation for flags, config file format, etc: https://github.com/arednch/phonebook

This documentation file here only documents the specifics of how phonebook is bundled for AREDN / OpenWRT.

For release notes, see the [release page](https://github.com/arednch/packages/releases) or
[this document](https://docs.google.com/document/d/18D14Ch3GjUZmSRQALEKslvtEJ0O76pZkV3VNJ6vsB14/edit).

## Package Content

- `Makefile`: Standard OpenWRT makefile defining how the package is built and installed. See this file if you are unsure where files are copied to during installation.

- `phonebook.config`: This is the configuration file for the phonebook and is copied to `/etc/phonebook.conf` during the installation. This is where you can update flags (check the [phonebook repository](https://github.com/arednch/phonebook) for the possible settings) in order to change its behavior.

- `phonebook_urls`: This is a plain text file which gets copied to `/etc/phonebook_urls` and contains the endpoints from which `/etc/cron.hourly/fetch_phonebook` loads the CSV from.

- `fetch_phonebook.cron`: This is the shell script that gets started hourly (copied to `/etc/cron.hourly/fetch_phonebook`) and fetches the CSV every hour until it exists or every 24hrs afterwards.

- `update_phonebook.cron`: This is the shell script that gets started hourly (copied to `/etc/cron.hourly/update_phonebook`) in order to refresh the local phonebook XML files based on the CSV.

- `phonebook.sh`: A shell script that during installation gets copied to `/www/cgi-bin/phonebook.sh` and can then be called via the Node's webinterface (http://localnode.local.mesh/cgi-bin/phonebook.sh) in order to force a phonebook update.

- `update_urls.sh`: A shell script that during the installation gets copied to `/www/cgi-bin/update_urls.sh` and can then be called via the Node's webinterface (http://localnode.local.mesh/cgi-bin/update_urls.sh) in order to change the sources for the CSV phonebook to fetch (see `/etc/phonebook_urls` above).
