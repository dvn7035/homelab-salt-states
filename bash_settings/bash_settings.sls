~/.bashrc:
  file.managed:
    - source:
      - file:///srv/salt/bash_settings/bashrc
