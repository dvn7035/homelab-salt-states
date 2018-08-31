base:
  '*':
    - vim
    - bash_settings
    - openssh-server
    - iptables-base
    - salt-minion
  '*whitebase*':
    - router
    - fail2ban
    - ddclient
    - bind9
