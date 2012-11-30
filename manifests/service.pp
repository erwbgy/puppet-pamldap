class pamldap::service {
  service { 'sssd':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['pamldap::config'],
  }
}
