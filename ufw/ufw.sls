ufw:
  pkg:
    - installed


# make this stateful
ufw-enable:
  cmd.run:
    - name: ufw enable
    - require:
      - pkg: ufw

ufw-ssh:
  cmd.run:
    - name: ufw allow SSH
    - require:
      - pkg: ufw
