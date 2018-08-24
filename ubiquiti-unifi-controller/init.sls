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
    - in-interface: lan0
    - protocol: udp
    - dport: 3478
    - jump: ACCEPT
    - save: True

allow_unifi_device_controller_communication:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 8080
    - jump: ACCEPT
    - save: True

allow_unifi_web_controller:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 8443
    - jump: ACCEPT
    - save: True

allow_unifi_HTTP_portal_redirect:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 8880
    - jump: ACCEPT
    - save: True

allow_unifi_HTTPS_portal_redirect:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 8843
    - jump: ACCEPT
    - save: True

allow_unifi_mobile_speed_test:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 6789
    - jump: ACCEPT
    - save: True

allow_unifi_local_database_comm:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 27117
    - jump: ACCEPT
    - save: True

allow_unifi_AP_EDU_broadcast:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: udp
    - dport: 5656:5699
    - jump: ACCEPT
    - save: True

allow_unifi_AP_discovery:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: udp
    - dport: 10001
    - jump: ACCEPT
    - save: True

allow_unifi_controller_L2_discoverable:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: udp
    - dport: 1900
    - jump: ACCEPT
    - save: True

stop_mongodb:
  service.dead:
    - name: mongodb
    - enable: False
