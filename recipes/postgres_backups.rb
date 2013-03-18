# Must be run after postgresql has created postgres user

# Install boto

secrets = Chef::EncryptedDataBagItem.load(node['ow_webserver']['secret_databag_name'], node['ow_webserver']['secret_databag_item_name'])

backup_module_root = node['ow_webserver']['postgres_backup_module_root']
backup_module_script = node['ow_webserver']['postgres_backup_module_name']

# Make dir for backup module
directory backup_module_root do
  owner 'postgres'
  group 'postgres'
  mode "700"
  recursive true
  action :create
end

# Make dir for backups
directory node['ow_webserver']['postgres_backup_root'] do
  owner 'postgres'
  group 'postgres'
  mode "770"
  recursive true
  action :create
end

# Make backup module
template backup_module_root + 'backup_postgres.py' do
    source 'backup_postgres.py.erb'
    owner 'postgres'
    group 'postgres'
    mode "770"
    variables({
    :aws_bucket => node['ow_webserver']['aws_backup_bucket'],
    :aws_access_key => secrets['aws_key'],
    :aws_secret => secrets['aws_secret'],
    :postgres_role => node['ow_webserver']['postgres_role'],
    :gpg_key_name => node['ow_webserver']['gpg_key'],
    :backup_path => node['ow_webserver']['postgres_backup_root'],
    :databases => node['ow_webserver']['postgres_backup_databases']
    })
end

python_pip "boto" do
	action :install
end

# Add to cron
cron "postgres_backups" do
  hour "4"
  minute "19"
  user 'postgres'
  command 'python ' + backup_module_root + backup_module_script
end
