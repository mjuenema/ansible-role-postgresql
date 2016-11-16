Testing
=======

There are various ways to test this playbook.

Docker container
----------------

Create a Docker container and run `playbook.yml` inside. For non-systemd 
distributions this is straight-forward.

Create Docker container.

    $ docker run -it centos:6 /bin/bash

Install dependencies.

    $ sudo yum -y install epel-release
    $ sudo yum -y install python-pip gcc make libffi-devel openssl-devel python-devel git vim-enhanced wget curl

Install Ansible.

    $ sudo pip install ansible==2.0.1.0

Clone the repository and checkout the branch you want to test.

    $ git clone https://github.com/mjuenema/ansible-role-postgresql.git
    $ cd ansible-role-postgresql
    $ git checkout -b BRANCH
    $ git pull origin BRANCH

Run the playbook.

    $ ansible-playbook -vvvv -c local -v -i tests/inventory playbook.yml

Distributions that run systemd are a bit more complicated.

Create a Docker container that can run systemd and execute a shell inside.

    $ docker run -d -it --privileged --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro mjuenema/centos7
    $ docker exec -it <container> /bin/bash

Then continue as described above for non-systemd distributions.


Molecule/Travis-CI
------------------

Molecule is a tool for testing Ansible roles in multiple distributions. Any pushes
to this repository will trigger tests in [Travis-CI](https://travis-ci.org/mjuenema/ansible-role-postgresql).

