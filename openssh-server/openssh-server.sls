openssh-server:
  pkg:
    - installed

ssh:
  service.running:
    - enable: True
    - restart: True

/etc/sshd_config:
  file.managed:
    - source: file:///srv/salt/openssh-server/sshd_config
    - user: root
    - group: root
    - mode: 644

~/.ssh/authorized_keys:
  file.managed:
    - source: file:///srv/salt/openssh-server/authorized_keys
    - user: root
    - group: root
    - mode: 600
