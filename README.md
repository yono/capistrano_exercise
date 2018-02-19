# Capistrano Excersize

## Provisioning to Vagrant

$ cd ansible/
$ vagrant up
$ vagrant ssh-config >> ~/.ssh/config
$ ansible-playbook -i hosts -l staging site.yml

## Deployment to Vagrant

$ bundle exec cap staging deploy
