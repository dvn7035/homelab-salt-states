iptables:
  pkg.installed

# iptables rules

# open 22 for ssh
allow_ssh:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - proto: tcp
    - dport: 22
    - save: True
 
# general firewall policies

# allow loopback connections
allow_incoming_lo:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lo
    - jump: ACCEPT
    - save: True

allow_outgoing_lo:
  iptables.append:
    - table: filter
    - chain: OUTPUT
    - out-interface: lo
    - jump: ACCEPT
    - save: True

# allow established and related networking
allow_established_related_incoming:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: conntrack
    - ctstate: ESTABLISHED,RELATED
    - jump: ACCEPT
    - save: True

# by default allow all outgoing
default_allow_outgoing:
  iptables.set_policy:
    - table: filter
    - chain: OUTPUT
    - policy: ACCEPT
    - save: True

# otherwise default policy drop all packets
default_incoming_drop:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
    - save: True

default_forward_drop:
  iptables.set_policy:
    - table: filter
    - chain: FORWARD
    - policy: DROP
    - save: True
