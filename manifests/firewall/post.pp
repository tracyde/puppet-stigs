# Class: stigs::firewall::post
#
# This class stubs the puppetlabs-firewall post rules 
#
# Parameters:
#
# Actions:
#
# Requires:
# - puppetlabs/firewall
#
# Sample Usage:
#  include ::stigs::firewall::post
#
class stigs::firewall::post ( ) {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
