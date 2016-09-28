
DRIVER := vagrant
PROVIDER := virtualbox


all: help

help:
	@echo "make molecule_test_all		- Run Molecule test against all platforms"
	@echo "make molecule_test_centos6	- Run Molecule test against CentOS 6"
	@echo "make molecule_test_centos7	- Run Molecule test against CentOS 7"
	@echo "make molecule_test_precise32	- Run Molecule test against Ubuntu 12.04 (precise) 32-bit"
	@echo "make molecule_test_precise64	- Run Molecule test against Ubuntu 12.04 (precise) 64-bit"
	@echo "make molecule_test_trusty32	- Run Molecule test against Ubuntu 14.04 (trusty) 32-bit"
	@echo "make molecule_test_trusty64	- Run Molecule test against Ubuntu 14.04 (trusty) 64-bit"
	@echo "make molecule_test_xenial	- Run Molecule test against Ubuntu 16.04 (xenial)"
	@echo "make molecule_test_wheezy	- Run Molecule test against Debian 7 (wheezy) 64-bit"
	@echo "make molecule_test_jessie	- Run Molecule test against Debian 8 (jessie) 64-bit"
	@echo "make molecule_destroy		- Destroy all test machines"
	@echo "make molecule_clean		- Cleanup the .molecule folder"


molecule_test_all: molecule_test_centos6 molecule_test_centos7 \
                   molecule_test_trusty32 molecule_test_trusty64 \
                   molecule_test_jessie molecule_test_jessie

molecule_destroy:
	molecule destroy

# Need to destroy any running machines first
molecule_clean: molecule_destroy
	rm -rfv .molecule

molecule_test_centos6: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=centos-6

molecule_test_centos7: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=centos-7

molecule_test_trusty32: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=ubuntu-trusty32

molecule_test_trusty64: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=ubuntu-trusty64

molecule_test_precise32: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=ubuntu-precise32

molecule_test_precise64: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=ubuntu-precise64

molecule_test_wheezy: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=debian-wheezy

molecule_test_jessie: molecule_clean
	molecule test --driver=$(DRIVER) --provider=$(PROVIDER) --platform=debian-jessie
