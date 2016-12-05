#
# Create image with
#
#    docker build .
#

FROM centos:6

MAINTAINER Markus Juenemann <markus@juenemann.net>

RUN yum -y install epel-release && \
    yum -y install ansible sudo && \
    yum clean all

COPY . /etc/ansible/roles/ansible-role-postgresql

RUN ansible-playbook -vvvv \
                     -i /etc/ansible/roles/ansible-role-postgresql/tests/inventory \
                     -c local \
                     -e 'postgresql_service_enabled: false' \
                     -e 'postgresql_version: 9.5' \
                     -e 'postgresql_databases: []' \
                     -e 'postgresql_ext_install_contrib: yes' \
                     -e 'postgresql_ext_install_dev_headers: yes' \
                     -e 'postgresql_ext_install_postgis: no' \
                     -e 'postgresql_ext_postgis_version: 2.2' \
                      /etc/ansible/roles/ansible-role-postgresql/tests/playbook.yml && \
    yum clean all

# Start PostgreSQL in foreground
#
RUN sed -i 's/&"/"/g' /etc/init.d/postgresql-*

ENTRYPOINT /etc/init.d/postgresql-* start
