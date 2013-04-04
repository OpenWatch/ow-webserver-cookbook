name             'ow_webserver'
maintainer       'OpenWatch FPC'
maintainer_email 'contact@openwatch.net'
license          'All rights reserved'
description      'Installs/Configures ow_webserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "ow_webserver", "readies openwatch.net SSL cert and key for nginx"

depends "nginx"
depends "postgresql"
depends "python"
depends "vt-gpg"
depends "firewall"