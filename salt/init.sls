# Set up minion file
/etc/salt/minion:
  file.managed:
    - source: file:///srv/salt/salt/minion

# Open ports 4505 4506

open_4505:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: TCP
    - dport: 4505
    - save: True

open_4506:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: TCP
    - dport: 4506
    - save: True

salt-minion:
  service.running:
    - reload: True
    - watch:
      - file: /etc/salt/minion
