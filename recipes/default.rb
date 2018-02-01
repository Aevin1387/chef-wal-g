#
# Cookbook Name:: wal-g
# Recipe:: default

# install packages
unless node[:wal_g][:packages].nil?
  node[:wal_g][:packages].each do |pkg|
    package pkg
  end
end

# Install from archive
archive_url = "#{node[:wal_g][:archive_url]}/v#{node[:wal_g][:version]}/#{node[:wal_g][:archive_name]}"
ark 'wal-g' do
  url archive_url
  has_binaries ['wal-g']
  strip_components 0
end

directory node[:wal_g][:env_dir] do
  user    node[:wal_g][:user]
  group   node[:wal_g][:group]
  mode    '0550'
end

vars = {
  'WALE_GPG_KEY_ID'           => node[:wal_g][:gpg_key_id],
  'WALE_S3_PREFIX'            => node[:wal_g][:s3_prefix],
  'AWS_ACCESS_KEY_ID'         => node[:wal_g][:aws_access_key],
  'AWS_SECRET_ACCESS_KEY'     => node[:wal_g][:aws_secret_key],
  'AWS_REGION'                => node[:wal_g][:aws_region],
  'AWS_ENDPOINT'              => node[:wal_g][:aws_endpoint],
  'AWS_S3_FORCE_PATH_STYLE'   => node[:wal_g][:aws_s3_force_path_style],
  'WALG_S3_STORAGE_CLASS'     => node[:wal_g][:s3_storage_class],
  'WALG_DOWNLOAD_CONCURRENCY' => node[:wal_g][:download_concurrency],
  'WALG_UPLOAD_CONCURRENCY'   => node[:wal_g][:upload_concurrency],
  'PGHOST'                    => node[:wal_g][:pg_host],
  'USER'                      => node[:wal_g][:user],
  'PATH'                      => node[:wal_g][:command_path],
  'HOME'                      => node[:wal_g][:home],
}.select { |k,v| v }

vars.each do |key, value|
  file "#{node[:wal_g][:env_dir]}/#{key}" do
    content value
    user    node[:wal_g][:user]
    group   node[:wal_g][:group]
    mode    '0440'
  end
end

cron_d 'wal_g_base_backup' do
  user node[:wal_g][:user]
  command "/usr/bin/envdir #{node[:wal_g][:env_dir]} #{node[:wal_g][:install_path]} backup-push #{node[:wal_g][:pgdata_dir]}"
  not_if { node[:wal_g][:base_backup][:disabled] }

  minute node[:wal_g][:base_backup][:minute]
  hour node[:wal_g][:base_backup][:hour]
  day node[:wal_g][:base_backup][:day]
  month node[:wal_g][:base_backup][:month]
  weekday node[:wal_g][:base_backup][:weekday]
end
