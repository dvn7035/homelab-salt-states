pi:
  user.absent:
    - purge: True
    - force: True
    - require_in:
      - pkg: install_openssh-server

install_openssh-server:
  pkg.installed:
    - name: openssh-server
    - require_in:
      - file: sshd_config
      - file: ssh_authorized_keys
      - service: ssh_service

# open tcp 22 for ssh
allow_ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: tcp
    - dport: 22
    - save: True
    - require:
      - sls: iptables-base

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://openssh-server/sshd_config
    - user: root
    - group: root
    - mode: 644

ssh_authorized_keys:
  file.managed:
    - name: /root/.ssh/authorized_keys
    - source: salt://openssh-server/authorized_keys
    - user: root
    - group: root
    - mode: 600
    - makedirs: True

ssh_service:
  service.running:
    - name: ssh
    - enable: True
    - restart: True
    - watch:
      - file: /etc/ssh/sshd_config
      - file: /root/.ssh/authorized_keys
