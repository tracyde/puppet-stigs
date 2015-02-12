# == Class: stigs::rules::srg_os_000021
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
class stigs::rules::srg_os_000021 ( ) {

  # Linux users
  if $::kernel == 'Linux' {

    # rhel-06-000061
    # rhel-06-000357 srg_os_000249
    $auth_stanza = "auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900\nauth        required      pam_faillock.so authsucc deny=3 unlock_time=604800 fail_interval=900"
    file_line { 'rhel-06-000061_0':
      path  => '/etc/pam.d/system-auth-ac',
      line  => $auth_stanza,
      after => '^auth        sufficient    pam_unix.so ',
    }
    #file_line { "rhel-06-000061_1":
    #  path => '/etc/pam.d/system-auth-ac',
    #  line => "auth        required      pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900",
    #  after => "^auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900",
    #  require => Line["^auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900"],
    #}

  }

}
