# Class: stigs::firewall::pre
#
# This class stubs the puppetlabs-firewall pre rules 
#
# Parameters:
#
# Actions:
#
# Requires:
# - puppetlabs/firewall
#
# Sample Usage:
#  include ::stigs::firewall::pre
#
class stigs::firewall::pre ( ) {
  Firewall {
    require => undef,
  }

  # rhel-06-000120
  firewallchain { 'INPUT:filter:IPv4':
    ensure => 'present',
    policy => 'drop',
  }
  # Disable IPV6
  #firewallchain { 'INPUT:filter:IPv6':
  #  ensure => 'present',
  #  policy => 'drop',
  #}

  # Default firewall rules
  firewall { '000 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }->
  firewall { '001 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '002 accept all to iface lo':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '003 accept all ssh traffic':
    port   => 22,
    proto  => 'tcp',
    state  => ['NEW'],
    action => 'accept',
  }
}
