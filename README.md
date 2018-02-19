# Capistrano Exercise

## Provisioning to Vagrant

```shell
$ cd ansible/
$ vagrant up
$ vagrant ssh-config >> ~/.ssh/config
$ ansible-playbook -i hosts -l staging site.yml
```

## Deployment to Vagrant

```shell
$ bundle exec cap staging deploy
```
