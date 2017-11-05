openssh-server:
  pkg:
    - installed

# open tcp 22 for ssh
allow_ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: tcp
    - dport: 22
    - save: True

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: file:///srv/salt/openssh-server/sshd_config
    - user: root
    - group: root
    - mode: 644

ssh_authorized_keys:
  file.managed:
    - name: ~/.ssh/authorized_keys
    - source: file:///srv/salt/openssh-server/authorized_keys
    - user: root
    - group: root
    - mode: 600
    - makedirs: True

ssh:
  service.running:
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config
      - file: ~/.ssh/authorized_keys
pi:
  user.absent:
    - purge: True
    - force: True
