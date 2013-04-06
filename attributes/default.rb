#
# Cookbook Name:: ow_python
# Attributes:: default
#
# Copyright 2013, OpenWatch FPC
#
# Licensed under the AGPLv3
#

# Chef repo
default['ow_webserver']['secret_databag_name'] 			= "secrets"
default['ow_webserver']['secret_databag_item_name'] 	= "ow_webserver"

# Firewall

default['ow_webserver']['open_all_ports']				= []  #Open to tcp and udp
default['ow_webserver']['open_tcp_ports']				= [22, 80, 443]
default['ow_webserver']['open_udp_ports']				= []

# Database backups
default['ow_webserver']['aws_backup_bucket']			= "openwatch-backups"
default['ow_webserver']['postgres_backup_databases']	= []
default['ow_webserver']['postgres_role']				= "postgres"
default['ow_webserver']['gpg_key']						= "contact@openwatch.net"
default['ow_webserver']['postgres_backup_root']			= "/var/db_backups/"
default['ow_webserver']['postgres_backup_module_root']	= "/etc/db_backups/"
default['ow_webserver']['postgres_backup_module_name']  = "backup_postgres.py"
default['ow_webserver']['backup_hour']  				= "4"
default['ow_webserver']['backup_minute']  				= "19"

# SSL
default['ow_webserver']['ssl_databag_name'] 		= "ssl"
default['ow_webserver']['ssl_databag_item_name'] 	= "ssl"
default['ow_webserver']['ssl_dir']					= "/srv/ssl/"
default['ow_webserver']['ssl_cert']     			= "star_openwatch_net.crt"
default['ow_webserver']['ssl_key']     				= "star_openwatch_net.key"

# Default packages
default['ow_webserver']['packages'] 				= ["htop", "vim", "ufw"]
