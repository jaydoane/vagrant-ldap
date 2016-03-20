# Vagrant-Ansible Openldap Server

Create a CentOS 6.7 based openldap server at 192.168.56.31 (by
default) with some preinstalled users and groups which make it useful
for testing Cloudant Local installations.

## Prerequisites

These instructions assume you have a Mac running at least Yosemite
with homebrew installed, and that you *don't* already have Vagrant and
VirtualBox installed.

- `brew install brew-cask`
- `brew install Caskroom/cask/virtualbox`
- `brew install Caskroom/cask/vagrant`
- `pyenv virtualenv ansible`
- `pyenv activate ansible`
- `pip install ansible`

## Usage

- `vagrant up`

- Add the following lines to your local.ini
    ```
    [ldap_auth]
    servers = 192.168.56.31
    use_ssl = false
    ```
    and restart cloudant local
