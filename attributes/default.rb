#
# Cookbook Name:: ow_python
# Attributes:: default
#
# Copyright 2013, OpenWatch FPC
#
# Licensed under the AGPLv3
#

# Chef repo
default['ow_webserver']['secret_databag_name'] 		= "secrets"
default['ow_webserver']['secret_databag_item_name'] = "ow_webserver"

# SSL
default['ow_webserver']['ssl_databag_name'] 		= "ssl"
default['ow_webserver']['ssl_databag_item_name'] 	= "ssl"
default['ow_webserver']['ssl_dir']					= "/srv/ssl/"
default['ow_webserver']['ssl_cert']     			= "star_openwatch_net.crt"
default['ow_webserver']['ssl_key']     				= "star_openwatch_net.key"
