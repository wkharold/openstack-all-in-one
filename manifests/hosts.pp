#
# This puppet manifest is already applied first to do some environment specific things
#

apt::source { 'openstack_folsom':
  location          => "http://ubuntu-cloud.archive.canonical.com/ubuntu",
  release           => "precise-updates/folsom",
  repos             => "main",
  required_packages => 'ubuntu-cloud-keyring',
}

# an apt-get update is usally required to ensure that
# we get the latest version of the openstack packages
exec { '/usr/bin/apt-get update':
  refreshonly => true,
  logoutput   => true,
}

#
# specify a connection to the hardcoded puppet master
#
host {
  'puppet':              ip => '172.16.0.2';
  'openstack': 		 ip => '172.16.0.3';
}

group { 'puppet':
  ensure => 'present',
}

# bring up the bridging interface explicitly
#exec { '/sbin/ifconfig eth2 up': }

node default { }
