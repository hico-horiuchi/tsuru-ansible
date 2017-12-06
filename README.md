## Tsuru Ansible Playbooks

This playbooks are based on [tsuru/now/run.bash](https://github.com/tsuru/now/blob/master/run.bash) and [tsuru/tsuru/docker-compose.yml](https://github.com/tsuru/tsuru/blob/master/docker-compose.yml) .

#### Preparations

    $ brew install git
    $ easy_install pip
    $ pip install virtualenv
    $ sudo gem install bundler
    $ git clone git@github.com:hico-horiuchi/tsuru-ansible.git

#### Ansible

    $ cd tsuru-ansible
    $ virtualenv venv
    $ source venv/bin/activate
    $ pip install -r requirements.txt
    $ rehash
    $ cp hosts_samples/hosts.example_com hosts
    $ vi ~/.vault_password
    $ ansible-playbook -i hosts -vv site.yml | tee /tmp/`date +%Y%m%d%H%M%S`_tsuru_ansible.log

#### Serverspec

    $ cd tsuru-ansible
    $ bundle install --jobs=4 --path=vendor/bundler --binstubs=vendor/bin
    $ bundle exec rake serverspec:all | tee /tmp/`date +%Y%m%d%H%M%S`_tsuru_serverspec.log
