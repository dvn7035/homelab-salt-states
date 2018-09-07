# Set up minion file
/etc/salt/minion:
  file.managed:
    - source: salt://salt-minion/minion

salt-minion:
  service.running:
    - restart: True
    - enable: True
    - watch:
      - file: /etc/salt/minion
