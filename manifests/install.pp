class pamldap::install {
  if ! defined(Package['sssd']) {
    package { 'sssd':  ensure => installed }
  }
  if ! defined(Package['sssd-client']) {
    package { 'sssd-client':  ensure => installed }
  }
  if ! defined(Package['openldap-clients']) {
    package { 'openldap-clients':  ensure => installed }
  }
}
