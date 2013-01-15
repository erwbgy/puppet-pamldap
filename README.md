# puppet-pamldap

Configure a system to use LDAP for user authentication, authorisation and
related name resolution:

    pamldap::base_dn: 'dc=example,dc=com'
    pamldap::uris: [ 'ldap://10.7.96.13', 'ldap://10.7.96.14' ]

Currently only tested on Redhat-like systems.

## Parameters

*base_dn*: LDAP base distinguished name used in user and group entries

*uris*: LDAP server connection details - a list of URIs in the format
ldap:://[hostname]

## Credits

This is based on detailed documentation and setup by my colleague Neil
McBennett.  He did all the hard work, I just puppetised it.
