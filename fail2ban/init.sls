install_fail2ban:
  pkg.installed:
    - name: fail2ban

/etc/fail2ban/jail.local:
  file.managed:
    - source: file:///srv/salt/fail2ban/jail.local
    - user: root
    - group: root
    - mode: 644

fail2ban:
  service.running:
    - restart: True
    - watch:
      - file: /etc/fail2ban/jail.local
