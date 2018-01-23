vim:
  pkg:
    - installed

~/.vimrc:
  file.managed:
    - source:
      - file:///srv/salt/vim/vimrc
