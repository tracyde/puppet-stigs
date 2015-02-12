# == Class: stigs::rules::srg_os_999999
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
class stigs::rules::srg_os_999999 ( ) {

  # Linux users
  if $::kernel == 'Linux' {

    # rhel-06-000228
    package { 'sendmail':
      ensure => absent,
    }
    #rhel-06-000222
    package { 'tftp-server':
      ensure => absent,
    }
    # rhel-06-000256
    package { 'openldap-servers':
      ensure => absent,
    }
    # rhel-06-000071 srg_os_000030
    package { 'screen':
      ensure => 'installed',
    }

    file { '/etc/shadow':
      owner => 'root',
      group => 'root',
      mode  => '0000',
    }
    file { '/etc/gshadow':
      owner => 'root',
      group => 'root',
      mode  => '0000',
    }
    file { '/etc/passwd':
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
    file { '/etc/group':
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
    file { '/etc/grub.conf':
      owner => 'root',
      group => 'root',
      mode  => '0600',
    }

    # rhel-06-000080
    sysctl { 'net.ipv4.conf.default.send_redirects': value => '0' }
    # rhel-06-000081
    sysctl { 'net.ipv4.conf.all.send_redirects': value => '0' }
    # rhel-06-000082
    sysctl { 'net.ipv4.ip_forward': value => '0' }
    # rhel-06-000083
    sysctl { 'net.ipv4.conf.all.accept_source_route': value => '0' }
    # rhel-06-000084
    sysctl { 'net.ipv4.conf.all.accept_redirects': value => '0' }
    # rhel-06-000086
    sysctl { 'net.ipv4.conf.all.secure_redirects': value => '0' }
    # rhel-06-000089
    sysctl { 'net.ipv4.conf.default.accept_source_route': value => '0' }
    # rhel-06-000090
    sysctl { 'net.ipv4.conf.default.secure_redirects': value => '0' }
    # rhel-06-000096
    sysctl { 'net.ipv4.conf.all.rp_filter': value => '1' }
    # rhel-06-000097
    sysctl { 'net.ipv4.conf.default.rp_filter': value => '1' }
    # rhel-06-000098
    sysctl { 'net.ipv6.conf.default.accept_redirects': value => '0' }
    # rhel-06-000088
    sysctl { 'net.ipv4.conf.all.log_martians': value => '1' }
    # rhel-06-000091
    sysctl { 'net.ipv4.conf.default.accept_redirects': value => '0' }
    # rhel-06-000092
    sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts': value => '1' }
    # rhel-06-000093
    sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses': value => '1' }

    # rhel-06-000224
    service { 'crond':
      ensure => running,
      enable => true,
    }
    # rhel-06-000246
    service { 'avahi-daemon':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000526
    service { 'autofs':
      ensure => stopped,
      enable => false,
    }
    # rhel-06-000287
    service { 'postfix':
      ensure => running,
      enable => true,
    }

    # rhel-06-000098
    file { '/etc/modprobe.d/disabled.conf':
      ensure => 'file',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    file_line { 'rhel-06-000098':
      path    => '/etc/modprobe.d/disabled.conf',
      line    => 'options ipv6 disable=1',
      require => File['/etc/modprobe.d/disabled.conf'],
    }
    # rhel-06-000054
    file_line { 'rhel-06-000054':
      path  => '/etc/login.defs',
      line  => "PASS_WARN_AGE\t7",
      match => "^PASS_WARN_AGE\t",
    }
    # rhel-06-000345
    file_line { 'rhel-06-000345':
      path  => '/etc/login.defs',
      line  => 'UMASK           077',
      match => '^UMASK ',
    }
    # rhel-06-000346
    file_line { 'rhel-06-000346':
      path  => '/etc/init.d/functions',
      line  => 'umask 022',
      match => '^umask ',
    }
    # rhel-06-000308
    file_line { 'rhel-06-000308':
      path => '/etc/security/limits.conf',
      line => '* hard core 0',
    }
    # rhel-06-000319 srg_os_000027
    file_line { 'rhel-06-000319':
      path => '/etc/security/limits.conf',
      line => '* hard maxlogins 10',
    }
    # rhel-06-000334 gen006660
    # rhel-06-000335 srg_os_000118
    file_line { 'rhel-06-000334':
      path  => '/etc/default/useradd',
      line  => 'INACTIVE=35',
      match => '^INACTIVE=',
    }
    # rhel-06-000020
    file_line { 'rhel-06-000020':
      path  => '/etc/selinux/config',
      line  => "SELINUX=${::stigs::selinux}",
      match => '^SELINUX=',
    }
    # rhel-06-000023
    file_line { 'rhel-06-000023':
      path  => '/etc/selinux/config',
      line  => "SELINUXTYPE=${::stigs::selinuxtype}",
      match => '^SELINUXTYPE=',
    }

    # rhel-06-000017
    stigs::delete_string { 'grub.conf remove selinux':
      file    => '/etc/grub.conf',
      pattern => '[[:space:]]*selinux=0',
    }

  }

}
