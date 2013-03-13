#
# Cookbook Name:: ow_webserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install base apps

package "htop" do
  action :install
end

package "vim" do
  action :install
end

# Make SSL cert/key directory
directory node['ow_webserver']['ssl_dir'] do
  owner node['nginx']['user']
  group node['nginx']['group']
  recursive true
  action :create
end

# Copy SSL certificate
cookbook_file node['ow_webserver']['ssl_dir'] + node['ow_webserver']['ssl_cert']  do
  source "star_openwatch_net.crt"
  owner node['nginx']['user']
  group node['nginx']['group']
  mode 0600
  action :create
end

# Write SSL key from encrypted data bag
ssl_key = Chef::EncryptedDataBagItem.load(node['ow_webserver']['ssl_databag_name'] , node['ow_webserver']['ssl_databag_item_name'] )

file node['ow_webserver']['ssl_dir'] + node['ow_webserver']['ssl_key'] do
  owner node['nginx']['user']
  group node['nginx']['group']
  content ssl_key['*.openwatch.net']
  mode 0600
  action :create
end

# Load encrypted data bag postgres user password
# into attributes for use by following recipes
psql_secrets = Chef::EncryptedDataBagItem.load(node['ow_webserver']['secret_databag_name'] , node['ow_webserver']['postgres_databag_item_name'] )
node.override['postgresql']['password']['postgres'] = psql_secrets['user_password']