# Minion set up

/etc/salt/minion:
  file.managed:
    - source: file:///srv/salt/salt/minion

salt-minion:
  service.running:
    - enable: True
    - reload: True
