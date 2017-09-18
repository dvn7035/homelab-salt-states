openssh-server:
  pkg:
    - installed

sshd_config:
  file.managed:
    - name: /etc/sshd_config
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
      - file: /etc/sshd_config
      - file: ~/.ssh/authorized_keys
pi:
  user.absent:
    - purge: True
    - force: True
