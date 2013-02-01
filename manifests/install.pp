class pamldap::install {
  include "pamldap::install::$operatingsystem"
}

class pamldap::install::common {
  if ! defined(Package['sssd']) {
    package { 'sssd':  ensure => installed }
  }
}

class pamldap::install::redhat inherits pamldap::install::common {
  if ! defined(Package['sssd-client']) {
    package { 'sssd-client':  ensure => installed }
  }
  if ! defined(Package['openldap-clients']) {
    package { 'openldap-clients':  ensure => installed }
  }
}

class pamldap::install::centos inherits pamldap::install::redhat {
    # No changes
}

class pamldap::install::ubuntu inherits pamldap::install::common {
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