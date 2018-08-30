install_ddclient:
  pkg.installed:
    - name: ddclient
    - require_in:
      - file: /etc/ddclient.conf
      - service: ddclient_service

# TODO: Figure out how to add credentials to salt pillars 
# Otherwise this configuration file will not work without
# username and password

/etc/ddclient.conf:
  file.managed:
    - source: salt://ddclient/ddclient.conf
    - user: root
    - group: root
    - mode: 700

ddclient_servce:
  service.running:
    - name: ddclient
    - enable: True
    - restart: True
    - watch:
      - file: /etc/ddclient.conf
