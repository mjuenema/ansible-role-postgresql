## mjuenema/ansible-role-postgresql

Ansible role which installs and configures PostgreSQL, extensions, databases and users.

This is a fork of the fantastic [ANXS/postgresql](https://github.com/ANXS/postgresql) but I made several changes that most likely won't be accepted back into the original project.

* Added support for testing with [Molecule](http://molecule.readthedocs.io/)
* Added installation of PostGIS development files.
* Added ```Makefile``` for running [Molecule](http://molecule.readthedocs.io/) tests (see below for details).

#### Installation

This has been tested on Ansible 1.9.4 and higher.

To install:

```
ansible-galaxy install https://github.com/mjuenema/ansible-role-postgresql mjuenema.postgresql
```

#### Dependencies

- ANXS.monit ([Galaxy](https://galaxy.ansible.com/list#/roles/502)/[GH](https://github.com/ANXS/monit)) if you want monit protection (in that case, you should set `monit_protection: true`)


#### Variables

```yaml
# Basic settings
postgresql_version: 9.3
postgresql_encoding: 'UTF-8'
postgresql_locale: 'en_US.UTF-8'
postgresql_ctype: 'en_US.UTF-8'

postgresql_admin_user: "postgres"
postgresql_default_auth_method: "trust"

postgresql_service_enabled: false # should the service be enabled, default is true

postgresql_cluster_name: "main"
postgresql_cluster_reset: false

# List of databases to be created (optional)
# Note: for more flexibility with extensions use the postgresql_database_extensions setting.
postgresql_databases:
  - name: foobar
    owner: baz          # optional; specify the owner of the database
    hstore: yes         # flag to install the hstore extension on this database (yes/no)
    uuid_ossp: yes      # flag to install the uuid-ossp extension on this database (yes/no)
    citext: yes         # flag to install the citext extension on this database (yes/no)
    encoding: 'UTF-8'   # override global {{ postgresql_encoding }} variable per database
    lc_collate: 'en_GB.UTF-8'   # override global {{ postgresql_locale }} variable per database
    lc_ctype: 'en_GB.UTF-8'     # override global {{ postgresql_ctype }} variable per database

# List of database extensions to be created (optional)
postgresql_database_extensions:
  - db: foobar
    extensions:
      - hstore
      - citext

# List of users to be created (optional)
postgresql_users:
  - name: baz
    pass: pass
    encrypted: no       # denotes if the password is already encrypted.

# List of user privileges to be applied (optional)
postgresql_user_privileges:
  - name: baz                   # user name
    db: foobar                  # database
    priv: "ALL"                 # privilege string format: example: INSERT,UPDATE/table:SELECT/anothertable:ALL
    role_attr_flags: "CREATEDB" # role attribute flags
```

There's a lot more knobs and bolts to set, which you can find in the defaults/main.yml


#### Testing

The included ```Makefile``` provides a wrapper around the [Molecule](http://molecule.readthedocs.io/) controlled tests.

```
make
make molecule_tests		         - Run Molecule test against all platforms
make molecule_test_centos6	   - Run Molecule test against CentOS 6
make molecule_test_centos7	   - Run Molecule test against CentOS 7
make molecule_test_precise32	 - Run Molecule test against Ubuntu 12.04 (precise) 32-bit
make molecule_test_precise64	 - Run Molecule test against Ubuntu 12.04 (precise) 64-bit
make molecule_test_trusty32	   - Run Molecule test against Ubuntu 14.04 (trusty) 32-bit
make molecule_test_trusty64	   - Run Molecule test against Ubuntu 14.04 (trusty) 64-bit
make molecule_test_xenial	     - Run Molecule test against Ubuntu 16.04 (xenial)
make molecule_test_wheezy	     - Run Molecule test against Debian 7 (wheezy) 64-bit
make molecule_test_jessie	     - Run Molecule test against Debian 8 (jessie) 64-bit
make molecule_destroy		       - Destroy all test machines
```

Currently the following PostgreSQL versions and Linux distributions are supported.

|                               | 8.4 | 9.0 | 9.1 | 9.2 | 9.3 | 9.4 | 9.5 |
|-------------------------------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| CentOS 6                      |     |     |     |     |     |     |     |
| CentOS 7                      |     |     |     |     |     |     |     |
| Ubuntu 12.04 (precise) 32-bit |     |     |     |     |     |     |     |
| Ubuntu 12.04 (precise) 64-bit |     |     |     |     |     |     |     |
| Ubuntu 14.04 (trusty) 32-bit  |     |     |     |     |     |     |     |
| Ubuntu 14.04 (trusty) 64-bit  |     |     |     |     |     |     |     |
| Debian 7 (wheezy) 64-bit      |     |     |     |     |     |     |     |
| Debian 8 (jessie) 64-bit      |     |     |     |     |     |     |     |

#### License

Licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

#### Thanks

A big thanks to the original project [ANXS/postgresql](https://github.com/ANXS/postgresql).

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/mjuenema/ansible-role-postgresql/issues)!
