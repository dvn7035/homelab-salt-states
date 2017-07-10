openssh-server:
  pkg:
    - installed

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
    - makedirs: True

# ssh:
#  service.running:
#    - enable: True
#    - reload: True

service ssh force-reload:
  cmd.run

pi:
  user.absent:
    - purge: True
    - force: True
