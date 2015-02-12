# == Class: stigs::rules::srg_os_000259
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
class stigs::rules::srg_os_000259 ( ) {

  # Linux users
  if $::kernel == 'Linux' {

    # rhel-06-000046
    $lib_dirs = ['/lib', '/lib64', '/usr/lib', '/usr/lib64']
    $lib_dirs_string = join($lib_dirs, ' ')
    file { $lib_dirs:
      ensure => directory,
      owner  => 'root',
    }
    cron { 'rhel-06-000046':
      ensure  => present,
      command => "/bin/find ${lib_dirs_string} \\! -user root -exec /bin/chown root {} \\;",
      user    => 'root',
      minute  => fqdn_rand(60, 'rhel-06-000046'),
    }

    # rhel-06-000047
    $bin_dirs = ['/bin', '/usr/bin', '/usr/local/bin', '/sbin', '/usr/sbin', '/usr/local/sbin']
    $bin_dirs_string = join($bin_dirs, ' ')
    cron { 'rhel-06-000047 permissions':
      ensure  => present,
      command => "/bin/find ${bin_dirs_string} -type f -perm /go=w -a \\! -type l -exec /bin/chmod go-w {} \\;",
      user    => 'root',
      minute  => fqdn_rand(60, 'rhel-06-000047 permissions'),
    }
    cron { 'rhel-06-000047 owner':
      ensure  => present,
      command => "/bin/find ${bin_dirs_string} -type f \\! -user root -exec /bin/chown root {} \\;",
      user    => 'root',
      minute  => fqdn_rand(60, 'rhel-06-000047 owner'),
    }
  }

}
