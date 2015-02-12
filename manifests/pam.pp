# == Class: stigs::pam
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
class stigs::pam (
  $pam_auth_template = 'stigs/system-auth-ac.erb',
  $pam_password_template = 'stigs/password-auth-ac.erb',
  $pam_enablesssd = false,
  $pam_enablekrb5 = false,
  $pam_enableldap = false,
  $pam_mkhomedir  = false,
) {

  # Linux users
  if $::kernel == 'Linux' {

    # rhel-06-000098
    file { '/etc/pam.d/system-auth-ac':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($pam_auth_template),
    }
    file { '/etc/pam.d/password-auth-ac':
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($pam_password_template),
    }
    stigs::find_string { 'rhel-06-000372':
      file    => '/etc/pam.d/system-auth-ac',
      pattern => 'session     required      pam_lastlog.so showfailed',
      require => File['/etc/pam.d/system-auth-ac'],
    }
    # rhel-06-000056 srg_os_000071
    # rhel-06-000057 srg_os_000069
    # rhel-06-000058 srg_os_000266
    # rhel-06-000059 srg_os_000070
    # rhel-06-000060 srg_os_000072
    stigs::find_string { 'rhel-06-000056':
      file    => '/etc/pam.d/system-auth-ac',
      pattern => 'password    requisite     pam_cracklib.so dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 difok=4 try_first_pass retry=3 type=',
      require => File['/etc/pam.d/system-auth-ac'],
    }
    # rhel-06-000061
    # rhel-06-000357 srg_os_000249
    stigs::find_string { 'rhel-06-000061_0':
      file    => '/etc/pam.d/system-auth-ac',
      pattern => 'auth        \[default=die\] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900',
      require => File['/etc/pam.d/system-auth-ac'],
    }
    stigs::find_string { 'rhel-06-000061_1':
      file    => '/etc/pam.d/system-auth-ac',
      pattern => 'auth        required      pam_faillock.so authsucc deny=3 unlock_time=604800 fail_interval=900',
      require => File['/etc/pam.d/system-auth-ac'],
    }
    package { 'authconfig':
      ensure => absent,
    }

    # Install oddjob if pam_mkhomedir is set
    if ($pam_mkhomedir) {
      $installoddjob = 'installed'
      $ensureoddjob = 'running'
      $enableoddjob = true
    } else {
      $installoddjob = 'absent'
      $ensureoddjob = 'stopped'
      $enableoddjob = false
    }
    package { 'oddjob':
      ensure => $installoddjob,
    }
    package { 'oddjob-mkhomedir':
      ensure => $installoddjob,
    }
    service { 'oddjobd':
      ensure    => $ensureoddjob,
      enable    => $enableoddjob,
      subscribe => [ File['/etc/pam.d/system-auth-ac'], File['/etc/pam.d/password-auth-ac'] ],
      require   => Package['oddjob'],
    }

    # rhel-06-000030
    stigs::delete_string { 'remove nullok':
      file    => '/etc/pam.d/system-auth-ac',
      pattern => '[[:space:]]*nullok',
      require => File['/etc/pam.d/system-auth-ac'],
    }

  }

}
