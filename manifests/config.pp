class pamldap::config (
  $base_dn,
  $uris,
) {
  $uris_space = join($uris, ' ')
  $uris_comma = join($uris, ',')
  
  include "pamldap::config::$operatingsystem"
}
class pamldap::config::common {
  # defaults
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/pam.d/system-auth-ac':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/system-auth.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/pam.d/system-auth':
    ensure  => present,
    target  => 'system-auth-ac',
    require => File['/etc/pam.d/system-auth-ac'],
  }
  file { '/etc/pam.d/password-auth-ac':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/password-auth.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/pam.d/password-auth':
    ensure  => present,
    target  => 'password-auth-ac',
    require => File['/etc/pam.d/password-auth-ac'],
  }
  file { '/etc/nsswitch.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/nsswitch.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/sssd/sssd.conf':
    ensure  => present,
    mode    => '0600',
    content => template('pamldap/sssd.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
}

class pamldap::config::redhat inherits pamldap::config::common {
  file { '/etc/ldap.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/ldap.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { [ '/etc/pam_ldap.conf', '/etc/openldap/ldap.conf' ]:
    ensure  => link,
    target  => '/etc/ldap.conf',
    require => File['/etc/ldap.conf'],
    notify  => Class['pamldap::service'],
  }
}

class pamldap::config::centos inherits pamldap::config::redhat {
    # No changes
}

class pamldap::config::ubuntu inherits pamldap::config::common {
  file { '/etc/ldap/ldap.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/ldap.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
}
