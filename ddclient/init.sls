ddclient:
  pkg.installed

# TODO: Figure out how to add credentials to salt pillars 
# Otherwise this configuration file will not work without
# username and password

/etc/ddclient.conf:
  file.managed:
    - source: file:///srv/salt/ddclient/ddclient.conf
    - user: root
    - group: root
    - mode: 700

ddclient_servce:
  service.running:
    - name: ddclient
    - restart: True
    - watch:
      - file: /etc/ddclient.conf
