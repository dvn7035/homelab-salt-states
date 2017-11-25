# Minion set up to run headless
/etc/salt/minion:
  file.managed:
    - source: file:///srv/salt/salt/minion

salt-minion:
  service.running:
    - reload: True
    - watch:
      - file: /etc/salt/minion
