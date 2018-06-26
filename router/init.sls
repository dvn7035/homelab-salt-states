# configure interfaces
dhcpcd_configuration:
  file.managed:
    - name: /etc/dhcpcd.conf
    - source: file:///srv/salt/router/dhcpcd.conf
    - user: root
    - group: root
    - mode: 664

dhcpcd:
  service.running:
    - restart: True
    - watch:
        - file: /etc/dhcpcd.conf 

# TODO: Figure out how sysctl.assign as a state
# forward ipv4 and disable ipv6
enable_ipv4_forwarding:
  module.run:
    - sysctl.assign:
      - name: net.ipv4.ip_forward
      - value: 1

disable_ipv6:
  module.run:
    - sysctl.assign:
      - name: net.ipv6.conf.all.disable_ipv6
      - value: 1

default_disable_ipv6:
  module.run:
    - sysctl.assign:
      - net.ipv6.conf.default.disable_ipv6
      - value: 1

lo_disable_ipv6:
  module.run:
    - sysctl.assign:
      - net.ipv6.conf.lo.disable_ipv6
      - value: 1 

# dnsmasq for dhcp and dns
install_dnsmasq:
  pkg.installed:
    - pkgs:
      - dnsmasq

dnsmasq_configuration:
  file.managed:
    - name: /etc/dnsmasq.conf
    - source: file:///srv/salt/router/dnsmasq.conf
    - user: root
    - group: root
    - mode: 644

dnsmasq:
  service.running:
    - restart: True
    - watch:
      - /etc/dnsmasq.conf

# iptable rules for routing

# forward all traffic originating from LAN
forward_all_originating_LAN:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: eth1
    - source: 10.0.0.0/8
    - jump: ACCEPT
    - save: True 

# allow dhcp from LAN
allow_dhcp_lan:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: eth1
    - protocol: udp
    - dport: 67:68
    - jump: ACCEPT
    - save: True

# allow DNS from LAN and lo
allow_dns_from_LAN_udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: eth1
    - protocol: udp
    - dport: 53
    - jump: ACCEPT
    - save: True

allow_dns_from_LAN_tcp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: eth1
    - protocol: tcp
    - dport: 53
    - jump: ACCEPT
    - save: True

# forward all related and established traffic from WAN
forward_related_established_originating_WAN:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: eth0
    - out-interface: eth1
    - match: conntrack
    - ctstate: ESTABLISHED,RELATED
    - jump: ACCEPT
    - save: True

# do NAT masquerading for packets headed to WAN
nat_masquerading:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - out-interface: eth0
    - jump: MASQUERADE
    - save: True
