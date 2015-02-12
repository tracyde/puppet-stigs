# == Class: stigs::rules::srg_os_000096
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
class stigs::rules::srg_os_000096 ( ) {

  # Linux users
  if $::kernel == 'Linux' {

    file { '/etc/modprobe.d/install-false.conf':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }

    # rhel-06-000124
    file_line { 'rhel-06-000124':
      path    => '/etc/modprobe.d/install-false.conf',
      line    => 'install dccp /bin/false',
      require => File['/etc/modprobe.d/install-false.conf'],
    }
    # rhel-06-000125
    file_line { 'rhel-06-000125':
      path    => '/etc/modprobe.d/install-false.conf',
      line    => 'install sctp /bin/false',
      require => File['/etc/modprobe.d/install-false.conf'],
    }
    # rhel-06-000127
    file_line { 'rhel-06-000127':
      path    => '/etc/modprobe.d/install-false.conf',
      line    => 'install tipc /bin/false',
      require => File['/etc/modprobe.d/install-false.conf'],
    }
    # rhel-06-000503 srg_os_000273
    file_line { 'rhel-06-000503':
      path    => '/etc/modprobe.d/install-false.conf',
      line    => 'install usb-storage /bin/false',
      require => File['/etc/modprobe.d/install-false.conf'],
    }
    # rhel-06-000126
    file_line { 'rhel-06-000126':
      path    => '/etc/modprobe.d/install-false.conf',
      line    => 'install rds /bin/false',
      require => File['/etc/modprobe.d/install-false.conf'],
    }
    # rhel-06-000249
    file_line { 'rhel-06-000249':
      path  => '/etc/postfix/main.cf',
      line  => 'inet_interfaces = localhost',
      match => '^inet_interfaces = ',
    }

    # rhel-06-000203
    # rhel-06-000204
    package { 'xinetd':
      ensure => 'absent',
    }
    # rhel-06-000221
    package { 'ypbind':
      ensure => 'absent',
    }
    # rhel-06-000261
    package { 'abrt':
      ensure => 'absent',
    }
      
    # rhel-06-000009
    service { 'rhnsd':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000262
    service { 'atd':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000265
    service { 'ntpdate':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000266
    # covered in ::stigs::pam module

    # rhel-06-000267
    service { 'qpidd':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000268
    service { 'rdisc':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000269
    service { 'netconsole':
      ensure => stopped,
      enable => false,
    }

  }

}
