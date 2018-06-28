base:
  '*':
    - vim
    - bash_settings
    - openssh-server
    - iptables-base
    - router
    #- salt-minion-no-master TODO: Fix my problem where I need salt-minion to reload it's config in the middle of its run 
    # Problem is releated router/init.sls's use of module run and use_superseded in /etc/salt/minion
