# Class: stigs::banner
#
# This module manages the /etc/motd, /etc/issue, and /etc/issue.net 
# files using a template
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include ::stigs::banner
#
class stigs::banner (
  $template = 'stigs/banner.erb'
) {
  case $::operatingsystem {
    centos, redhat, scientific: {
      $banner_files = ['/etc/motd', '/etc/issue', '/etc/issue.net']
      file { $banner_files:
        ensure  => file,
        backup  => false,
        content => template($template),
      }
    }
    default: { fail('Unrecognized operating system') }
  }
}
