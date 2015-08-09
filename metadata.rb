name             'containerfarm'
maintainer       'Chef Software, Inc.'
maintainer_email 'jdunn@chef.io'
license          'Apache 2.0'
description      'Create a farm of containers for testing'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'docker'
depends 'iptables'
