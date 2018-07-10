# configure interfaces subnet mask
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

# set routing tables

# TODO: figure out how to manage routing tables in a stateful manner
route delete -net 0.0.0.0 gw 10.0.0.1 netmask 0.0.0.0 dev enx0050b625c2f5:
  cmd.run

# forward ipv4 and disable ipv6
enable_ipv4_forwarding:
  module.run:
    - sysctl.persist:
      - name: net.ipv4.ip_forward
      - value: 1
      - config: /etc/sysctl.conf

disable_ipv6:
  module.run:
    - sysctl.persist:
      - name: net.ipv6.conf.all.disable_ipv6
      - value: 1
      - config: /etc/sysctl.conf

default_disable_ipv6:
  module.run:
    - sysctl.persist:
      - net.ipv6.conf.default.disable_ipv6
      - value: 1
      - config: /etc/sysctl.conf

lo_disable_ipv6:
  module.run:
    - sysctl.persist:
      - net.ipv6.conf.lo.disable_ipv6
      - value: 1 
      - config: /etc/sysctl.conf

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

#TODO: Figure out how to rename interfaces and apply immediately
# in saltstack

# forward all traffic originating from LAN
forward_all_originating_LAN:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: enx0050b625c2f5
    - jump: ACCEPT
    - save: True 

# allow dhcp from LAN
allow_dhcp_lan:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 67:68
    - jump: ACCEPT
    - save: True

# allow DNS from LAN
allow_dns_from_LAN_udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 53
    - jump: ACCEPT
    - save: True

allow_dns_from_LAN_tcp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 53
    - jump: ACCEPT
    - save: True

# forward all related and established traffic from WAN
forward_related_established_originating_WAN:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - in-interface: enx0050b62451d7
    - out-interface: enx0050b625c2f5
    - match: conntrack
    - ctstate: ESTABLISHED,RELATED
    - jump: ACCEPT
    - save: True

# do NAT masquerading for packets headed to WAN
nat_masquerading:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - out-interface: enx0050b62451d7
    - jump: MASQUERADE
    - save: True


# Controller for Ubiquiti Unifi AP
install_oracle:
  pkg.installed:
    - name: oracle-java8-jdk

ubiquiti_repo:
  pkgrepo.managed:
    - name: deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti
    - key_url: https://dl.ubnt.com/unifi/unifi-repo.gpg
    - require_in:
      - pkg: unifi

install_unifi:
  pkg.installed:
    - name: unifi
    - fromrepo: stable

allow_unifi_STUN:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 3478
    - jump: ACCEPT
    - save: True

allow_unifi_device_controller_communication:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 8080
    - jump: ACCEPT
    - save: True

allow_unifi_web_controller:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 8443
    - jump: ACCEPT
    - save: True

allow_unifi_HTTP_portal_redirect:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 8880
    - jump: ACCEPT
    - save: True

allow_unifi_HTTPS_portal_redirect:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 8843
    - jump: ACCEPT
    - save: True

allow_unifi_mobile_speed_test:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 6789
    - jump: ACCEPT
    - save: True

allow_unifi_local_database_comm:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: tcp
    - dport: 27117
    - jump: ACCEPT
    - save: True

allow_unifi_AP_EDU_broadcast:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 5656:5699
    - jump: ACCEPT
    - save: True

allow_unifi_AP_discovery:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 10001
    - jump: ACCEPT
    - save: True

allow_unifi_controller_L2_discoverable:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: enx0050b625c2f5
    - protocol: udp
    - dport: 1900
    - jump: ACCEPT
    - save: True

stop_mongodb:
  service.dead:
    - name: mongodb
    - enable: False
