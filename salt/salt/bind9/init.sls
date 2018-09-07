install_bind:
  pkg.installed:
    - name: bind9
    - require_in:
      - file: /etc/bind9/db.0
      - file: /etc/bind9/db.127
      - file: /etc/bind9/db.233.27.172
      - file: /etc/bind9/db.255
      - file: /etc/bind9/db.empty
      - file: /etc/bind9/db.internal.dvn7035.com
      - file: /etc/bind9/db.local
      - file: /etc/bind9/db.root
      - file: /etc/bind9/named.conf
      - file: /etc/bind9/named.conf.default-zones
      - file: /etc/bind9/named.conf.local
      - file: /etc/bind9/named.conf.options
      - file: /etc/bind9/zones.rfc1918

allow_dns_from_lan0_tcp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: tcp
    - dport: 53
    - jump: ACCEPT
    - save: True
    - require: 
      - sls: iptables-base

allow_dns_from_lan0_udp:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lan0
    - protocol: udp
    - dport: 53
    - jump: ACCEPT
    - save: True
    - require: 
      - sls: iptables-base

/etc/bind9/db.0:
  file.managed:
    - source: salt://bind9/db.0
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/db.127:
  file.managed:
    - source: salt://bind9/db.127
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/db.233.27.172:
  file.managed:
    - source: salt://bind9/db.233.27.172
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/db.255:
  file.managed:
    - source: salt://bind9/db.255
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/db.empty:
  file.managed:
    - source: salt://bind9/db.empty
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/db.internal.dvn7035.com:
  file.managed:
    - source: salt://bind9/db.internal.dvn7035.com
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/db.local:
  file.managed:
    - source: salt://bind9/db.local
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/db.root:
  file.managed:
    - source: salt://bind9/db.root
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

/etc/bind9/named.conf:
  file.managed:
    - source: salt://bind9/named.conf
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/named.conf.default-zones:
  file.managed:
    - source: salt://bind9/named.conf.default-zones
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/named.conf.local:
  file.managed:
    - source: salt://bind9/named.conf.local
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/named.conf.options:
  file.managed:
    - source: salt://bind9/named.conf.options
    - user: root
    - group: bind
    - mode: 644
    - makedirs: True

/etc/bind9/zones.rfc1918:
  file.managed:
    - source: salt://bind9/zones.rfc1918
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
