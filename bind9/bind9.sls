allow_dns_udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: udp
    - dport: 53
    - save: True

allow_dns_tcp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: tcp
    - dport: 53
    - save: True

bind9:
  pkg:
    - installed

bind9utils:
  pkg:
    - installed

bind9-doc:
  pkg:
    - installed

dnsutils:
  pkg:
   - installed

etc_default_bind:
  file.managed:
    - name: /etc/default/bind9
    - source: file:///srv/salt/bind9/bind9
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

named.conf:
  file.managed:
    - name: /etc/bind/named.conf
    - source: file:///srv/salt/bind9/named.conf
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

named.conf.options:
  file.managed:
    - name: /etc/bind/named.conf.options
    - source: file:///srv/salt/bind9/named.conf.options
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

named.conf.local:
  file.managed:
    - name: /etc/bind/named.conf.local
    - source: file:///srv/salt/bind9/named.conf.local
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

db.dvn7035.com:
  file.managed:
    - name: /etc/bind/zones/db.dvn7035.com
    - source: file:///srv/salt/bind9/db.dvn7035.com
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

db.168.192:
  file.managed:
    - name: /etc/bind/zones/db.168.192
    - source: file:///srv/salt/bind9/db.168.192
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

bind9_service:
  service.running:
    - name: bind9
    - reload: True
    - watch:
      - file: /etc/default/bind9
      - file: /etc/bind/named.conf
      - file: /etc/bind/named.conf.options
      - file: /etc/bind/named.conf.local
      - file: /etc/bind/zones/db.dvn7035.com
      - file: /etc/bind/zones/db.168.192
