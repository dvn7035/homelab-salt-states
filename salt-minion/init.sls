# Set up minion file
/etc/salt/minion:
  file.managed:
    - source: file:///srv/salt/salt-minion-no-master/minion

salt-minion:
  service.running:
    - restart: True
    - watch:
      - file: /etc/salt/minion
