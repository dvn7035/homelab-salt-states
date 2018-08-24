# dnsmasq for dhcp
install_dnsmasq:
  pkg.installed:
    - name: dnsmasq

dnsmasq_configuration:
  file.managed:
    - name: /etc/dnsmasq.conf
    - source: salt://dnsmasq-dhcp/dnsmasq.conf
    - user: root
    - group: root
    - mode: 644

dnsmasq:
  service.running:
    - restart: True
    - enable: True
    - watch:
      - /etc/dnsmasq.conf

# TODO: Check if I even need the ports open because of raw sockets
# allow dhcp from LAN
#allow_dhcp_lan:
#  iptables.append:
#    - table: filter
#    - chain: INPUT
#    - in-interface: lan0
#    - protocol: udp
#    - dport: 67:68
#    - jump: ACCEPT
#    - save: True
