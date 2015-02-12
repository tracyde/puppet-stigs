# == Class: stigs
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
class stigs (
  $selinux               = 'enforcing',
  $selinuxtype           = 'targeted',
  $grub_password         = undef,
  $ssh_internalsftp      = false,
  $ssh_match             = undef,
  $pam_auth_template     = 'stigs/system-auth-ac.erb',
  $pam_password_template = 'stigs/password-auth-ac.erb',
  $pam_enablesssd        = false,
  $pam_enablekrb5        = false,
  $pam_enableldap        = false,
  $pam_mkhomedir         = false,
) {

  # validate input parameters
  validate_re($selinux, ['^enforcing$', '^permissive$', '^disabled$'])
  validate_re($selinuxtype, ['^targeted$', '^strict$'])
  #validate_re($grub_password, '^\$.+$')
  validate_bool($ssh_internalsftp)

  # including these modules to ensure we can use the defines
  # they create.
  include ::sysctl::base

  # Setup the firewall configuration
  resources { 'firewall':
    purge => true
  }
  Firewall {
    before => Class['::stigs::firewall::post'],
    require => Class['::stigs::firewall::pre'],
  }
  class { ['::stigs::firewall::pre', '::stigs::firewall::post']: }
  class { '::firewall': }

  class { '::stigs::pam':
    pam_auth_template     => $pam_auth_template,
    pam_password_template => $pam_password_template,
    pam_enablesssd        => $pam_enablesssd,
    pam_enablekrb5        => $pam_enablekrb5,
    pam_enableldap        => $pam_enableldap,
    pam_mkhomedir         => $pam_mkhomedir,
  }

  include ::stigs::rules::srg_os_000095
  include ::stigs::rules::srg_os_000109
  include ::stigs::rules::srg_os_000232
  include ::stigs::rules::srg_os_000248
  include ::stigs::rules::srg_os_999999
  include ::stigs::rules::srg_os_000259
  include ::stigs::rules::srg_os_000142
  include ::stigs::rules::srg_os_000120
  include ::stigs::rules::srg_os_000078
  include ::stigs::rules::srg_os_000075
  include ::stigs::rules::srg_os_000076
  class { '::stigs::rules::srg_os_000080': password => $grub_password }
  include ::stigs::rules::srg_os_000096
  include ::stigs::rules::srg_os_000215
  include ::stigs::rules::srg_os_000034
  include ::stigs::rules::srg_os_000103

  # rhel-06-000227 srg_os_000112
  # rhel-06-000239 srg_os_000106
  # rhel-06-000234 srg_os_000106
  # rhel-06-000236 srg_os_000106
  # rhel-06-000237 srg_os_000109
  # rhel-06-000240 srg_os_000023
  # rhel-06-000230 srg_os_000163
  # rhel-06-000230 srg_os_000163
  # rhel-06-000231 srg_os_000126
  # rhel-06-000241 srg_os_000242
  class { '::ssh::sshd_config':
    permitrootlogin     => 'no',
    bannerpath          => '/etc/issue',
    clientaliveinterval => '900',
    clientalivecountmax => '0',
    internalsftp        => $ssh_internalsftp,
    match               => $ssh_match,
  }

  # rhel-06-000159 srg_os_999999
  # rhel-06-000160 srg_os_999999
  # rhel-06-000161 srg_os_999999
  # rhel-06-000202 srg_os_000064
  # rhel-06-000313 srg_os_000046
  # rhel-06-000165 srg_os_000062
  # rhel-06-000173 srg_os_000062
  # rhel-06-000174 srg_os_000004
  # rhel-06-000175 srg_os_000239
  # rhel-06-000176 srg_os_000240
  # rhel-06-000177 srg_os_000241
  # rhel-06-000183 srg_os_999999
  # rhel-06-000184 srg_os_000064
  # rhel-06-000185 srg_os_000064
  # rhel-06-000186 srg_os_000064
  # rhel-06-000187 srg_os_000064
  # rhel-06-000188 srg_os_000064
  # rhel-06-000189 srg_os_000064
  # rhel-06-000190 srg_os_000064
  # rhel-06-000191 srg_os_000064
  # rhel-06-000192 srg_os_000064
  # rhel-06-000193 srg_os_000064
  # rhel-06-000194 srg_os_000064
  # rhel-06-000195 srg_os_000064
  # rhel-06-000196 srg_os_000064
  # rhel-06-000200 srg_os_000064
  include ::auditd

  include ::stigs::banner
}
