openssh-server:
  pkg:
    - installed

ssh:
  file.managed:
    - name: /etc/sshd_config
    - source: file:///srv/salt/openssh-server/sshd_config
    - user: root
    - group: root
    - mode: 644
  file.managed:
    - source: file:///srv/salt/openssh-server/authorized_keys
    - user: root
    - group: root
    - mode: 600
    - makedirs: True
  service.running:
    - watch:
      - file: ~/.ssh/authorized_keys
      - file: /etc/sshd_config

pi:
  user.absent:
    - purge: True
    - force: True
