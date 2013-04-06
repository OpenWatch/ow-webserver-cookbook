#
# Cookbook Name:: ow_webserver
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install base apps
packages = node['ow_webserver']['packages']

packages.each do |app|
  package app
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

# Apply firewall rules
open_all_ports = node['ow_webserver']['open_all_ports']
if !open_all_ports.empty?
  firewall_rule "open_tcp_and_udp_ports" do
    ports open_all_ports
    action :allow
  end
end

open_tcp_ports = node['ow_webserver']['open_tcp_ports']
if !open_tcp_ports.empty?
  firewall_rule "open_tcp_ports" do
    ports open_tcp_ports
    protocol :tcp
    action :allow
  end
end

open_udp_ports = node['ow_webserver']['open_udp_ports']
if !open_udp_ports.empty?
  firewall_rule "open_udp_ports" do
    ports open_udp_ports
    protocol :udp
    action :allow
  end
end

firewall "ufw" do
  action :enable
end
