WAL-G Cookbook
==============

Installs and configures [WAL-G](https://github.com/wal-g/wal-g) using
envdir to store configuration. Sets up a cron_d entry to perform base
backups.
*You still need to configure Postgres manually/separately to
archive WAL files.*

(Tested on Debian/Ubuntu only - will probably break on other
distributions.)

Tested on Ubuntu 16.04 extensively.

Attributes
----------

- [:wal_g][:base_backup][:disabled] - Install wal-g but don't modify the postgres configuration or install the crontab - useful for restore-only environments.
- [:wal_g][:packages] - The packages needed by wal-g. Override if these are installed in your environment elsewhere.

- [:wal_g][:version] - Specify the version you want to install
- [:wal_g][:base_backup] - Specifies the time period to issue cron backups

- [:wal_g][:pgdata_dir] - Postgres data directory, override for your postgres version

Recipes
-------

- default.rb - Installs wal-g

License and Authors
-------------------
Authors:

* Cory Stephenson (aevin@me.com)

Acknowledgements:

Based on the [Wal-E cookbook](https://github.com/wal-e/chef-wal-e) by Russ Garrett (rusis@garrett.co.uk)
