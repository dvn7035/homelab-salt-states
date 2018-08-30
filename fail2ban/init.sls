install_fail2ban:
  pkg.installed:
    - name: fail2ban
    - require_in:
      - file: /etc/fail2ban/jail.local
      - service: fail2ban_service

/etc/fail2ban/jail.local:
  file.managed:
    - source: salt://fail2ban/jail.local
    - user: root
    - group: root
    - mode: 644

fail2ban_service:
  service.running:
    - name: fail2ban
    - restart: True
    - watch:
      - file: /etc/fail2ban/jail.local
