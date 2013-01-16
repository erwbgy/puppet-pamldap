# puppet-pamldap

Configure a system to use LDAP for user authentication, authorisation and
related name resolution.

Currently only tested on Redhat-like systems.

## Usage

Include the pamldap module in your puppet configuration:

    include pamldap

and add required hiera configuration - for example:

    pamldap::base_dn: 'dc=example,dc=com'
    pamldap::uris: [ 'ldap://10.7.96.13', 'ldap://10.7.96.14' ]

It can also be used as a parameterised class - for example:

    class { 'pamldap':
      base_dn => 'dc=example,dc=com',
      uris    => [ 'ldap://10.7.96.13', 'ldap://10.7.96.14' ],
    }

## Parameters

*base_dn*: LDAP base distinguished name used in user and group entries

*uris*: LDAP server connection details - a list of URIs in the format
ldap:://[hostname]

## Show user and group info from LDAP

Create userinfo and groupinfo aliases in ~/.bashrc:

    $ vim ~/.bashrc
    alias userinfo='perl -le "print join(qw(:),getpwnam(\$_)) foreach @ARGV"'
    alias groupinfo='perl -le "print join(qw(:),getgrnam(\$_)) foreach @ARGV"'

Then you can query user and group information from LDAP that you would normally
see in /etc/passwd and /etc/group:

    $ groupinfo users
    users:x:100:
    $ userinfo kburdis fbloggs
    kburdis:x:500:100:::Keith Burdis:/home/kburdis:/bin/bash
    fbloggs:x:501:100:::Fred Bloggs:/home/kburdis:/bin/bash

When run as root you will see information from LDAP that would normally be in
/etc/shadow:

    # userinfo kburdis fbloggs
    kburdis:$6$oniRviiF...:500:100:::Keith Burdis:/home/kburdis:/bin/bash
    fbloggs:$7$OghzqIlp...:501:100:::Fred Bloggs:/home/fbloggs:/bin/bash
    # groupinfo sysadmins users
    sysadmins:x:514:kburdis
    users:x:100:

## Credits

This is based on detailed documentation and setup by my colleague Neil
McBennett.  He did all the hard work, I just puppetised it.
