class pamldap::install {
  if ! defined(Package['sssd']) {
    package { 'sssd':  ensure => installed }
  }
  case $::osfamily {
    'Redhat': {
      if ! defined(Package['sssd-client']) {
        package { 'sssd-client':  ensure => installed }
      }
      if ! defined(Package['openldap-clients']) {
        package { 'openldap-clients':  ensure => installed }
      }
    }
    'Debian': {
      if ! defined(Package['libnss-sss']) {
        package { 'libnss-sss':  ensure => installed }
      }
      if ! defined(Package['libpam-sss']) {
        package { 'libpam-sss':  ensure => installed }
      }
      if ! defined(Package['ldap-utils']) {
        package { 'ldap-utils':  ensure => installed }
      }
    }
  }
}
