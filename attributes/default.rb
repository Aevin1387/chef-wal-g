
# List of packages WAL-E needs
pkg_dependencies = %w(
  daemontools
  libevent-dev
  libxslt-dev
  postgresql-client
)

default[:wal_g][:packages] = pkg_dependencies

default[:wal_g][:archive_url]      = 'https://github.com/wal-g/wal-g/releases/download'
default[:wal_g][:archive_name]     = 'wal-g.linux-amd64.tar.gz'
default[:wal_g][:version]          = '0.1.4'

default[:wal_g][:install_path]     = '/usr/local/bin/wal-g'

default[:wal_g][:env_dir]             = '/etc/wal-g'
default[:wal_g][:aws_access_key]      = ''
default[:wal_g][:aws_secret_key]      = ''
default[:wal_g][:s3_prefix]           = ''

default[:wal_g][:base_backup][:disabled]  = false
default[:wal_g][:base_backup][:minute]    = '0'
default[:wal_g][:base_backup][:hour]      = '0'
default[:wal_g][:base_backup][:day]       = '*'
default[:wal_g][:base_backup][:month]     = '*'
default[:wal_g][:base_backup][:weekday]   = '1'

default[:wal_g][:user]                = 'postgres'
default[:wal_g][:group]               = 'postgres'
default[:wal_g][:pgdata_dir]          = '/var/lib/postgresql/9.6/main/'
