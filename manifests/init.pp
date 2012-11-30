class pamldap (
  $base_dn,
  $uris,
) {
  class { 'pamldap::config':
    base_dn => $base_dn,
    uris    => $uris,
  }
  include pamldap::install
  include pamldap::service
}
