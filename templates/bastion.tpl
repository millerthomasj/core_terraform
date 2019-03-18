#cloud-config

packages:

runcmd:
  - echo "${hostname_prefix}-$(curl http://169.254.169.254/latest/meta-data/instance-id).${domain} ansible_group=bastion consul_node_name=bastion-$(curl http://169.254.169.254/latest/meta-data/instance-id)" > /etc/ansible/hosts
  - cd /etc/ansible && sudo /usr/local/bin/ansible-playbook -c local site.yml -e initial_build=true -e team_name=${project} -e env=${env}
  - cd /etc/ansible && sudo /usr/local/bin/ansible-playbook -c local hardening.yml
