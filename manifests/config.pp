class pamldap::config (
  $base_dn,
  $uris,
) {
  $uris_space = join($uris, ' ')
  $uris_comma = join($uris, ',')
  # defaults
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/pam.d/system-auth':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/system-auth.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/nsswitch.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/nsswitch.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { [ '/etc/ldap.conf', '/etc/openldap/ldap.conf' ]:
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/ldap.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
  file { '/etc/sssd/sssd.conf':
    ensure  => present,
    mode    => '0444',
    content => template('pamldap/sssd.conf.erb'),
    require => Class['pamldap::install'],
    notify  => Class['pamldap::service'],
  }
}
