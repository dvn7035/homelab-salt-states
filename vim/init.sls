vim:
  pkg:
    - installed

/root/.vimrc:
  file.managed:
    - source: salt://vim/vimrc
    - require:
      - pkg: vim
