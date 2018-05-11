#cloud-config

packages:
  - gcc
  - python-pip
  - git
  
runcmd:
  - git clone https://stash.dev-charter.net/stash/scm/portals/ansible.git /etc/ansible
  - echo "${hostname_prefix}-$(curl http://169.254.169.254/latest/meta-data/instance-id).${domain} ansible_group=bastion consul_node_name=bastion-$(curl http://169.254.169.254/latest/meta-data/instance-id)" > /etc/ansible/hosts
  - chmod 755 /etc/ansible/extensions/setup/setup.sh && /etc/ansible/extensions/setup/setup.sh -i
  - cd /etc/ansible && sudo /usr/local/bin/ansible-playbook -c local site.yml -e initial_build=true
