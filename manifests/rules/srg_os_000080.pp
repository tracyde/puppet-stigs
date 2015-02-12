# == Class: stigs::rules::srg_os_000080
#
# Full description of class site here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { site:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class stigs::rules::srg_os_000080 ( $password = undef ) {

  # validate parameters
  #validate_re($password, '^\$.+$')

  # Linux users
  if $::kernel == 'Linux' {

    # rhel-06-000069
    file_line { 'rhel-06-000069':
      path  => '/etc/sysconfig/init',
      line  => 'SINGLE=/sbin/sulogin',
      match => '^SINGLE=',
    }
    # rhel-06-000070
    file_line { 'rhel-06-000070':
      path  => '/etc/sysconfig/init',
      line  => 'PROMPT=no',
      match => '^PROMPT=',
    }
    if $password != undef {
      # rhel-06-000068
      augeas { 'grub-create-password':
        context => '/files/etc/grub.conf',
        changes => [
          'ins password after default',
          "set password/encrypted ''",
          "set password ${password}",
        ],
        onlyif  => 'match password size == 0',
      }
      augeas { 'grub-set-password':
        context => '/files/etc/grub.conf',
        changes => [
          "set password ${password}",
        ],
        require => Augeas['grub-create-password'],
      }
    } else {
      warning('Grub password undefined, grub is unprotected!')
    }

  }

}
