# disable dhcpcd
disable_dhcpcd:
  service.dead:
    - name: dhcpcd
    - enable: False

# configure interface names with systemd.network
# needs a reboot to actually take effect
name_for_wan_interface:
  file.managed:
    - name: /etc/systemd/network/25-wan0.link
    - source: salt://router/25-wan0.link
    - user: root
    - group: root
    - mode: 644

name_for_lan_interface:
  file.managed:
    - name: /etc/systemd/network/25-lan0.link
    - source: salt://router/25-lan0.link
    - user: root
    - group: root
    - mode: 644

configure_ip_and_dhcp_for_interfaces:
  file.managed:
    - name: /etc/network/interfaces.d/router-interface-settings
    - source: salt://router/router-interface-settings
    - user: root
    - group: root
    - mode: 644
    - template: jinja

# forward ipv4 and disable ipv6
enable_ipv4_forwarding:
  module.run:
    - sysctl.persist:
      - name: net.ipv4.ip_forward
      - value: 1
      - config: /etc/sysctl.conf
    - require:
      - sls: salt-minion

disable_ipv6:
  module.run:
    - sysctl.persist:
      - name: net.ipv6.conf.all.disable_ipv6
      - value: 1
      - config: /etc/sysctl.conf
    - require:
      - sls: salt-minion

default_disable_ipv6:
  module.run:
    - sysctl.persist:
      - net.ipv6.conf.default.disable_ipv6
      - value: 1
      - config: /etc/sysctl.conf
    - require:
      - sls: salt-minion

lo_disable_ipv6:
  module.run:
    - sysctl.persist:
      - net.ipv6.conf.lo.disable_ipv6
      - value: 1 
      - config: /etc/sysctl.conf
    - require:
      - sls: salt-minion

# iptable rules for routing

# forward all traffic from lan0 to wan0
forward_all_traffic_from_lan0_to_wan0:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: lan0
    - out-interface: wan0
    - jump: ACCEPT
    - save: True
    - require:
      - sls: iptables-base

# forward all related and established traffic from wan0
forward_related_established_from_wan0:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: wan0
    - out-interface: lan0
    - match: conntrack
    - ctstate: ESTABLISHED,RELATED
    - jump: ACCEPT
    - save: True
    - require:
      - sls: iptables-base

# do NAT masquerading for packets headed to wan0
nat_masquerading:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - out-interface: wan0
    - jump: MASQUERADE
    - save: True
    - require:
      - sls: iptables-base
