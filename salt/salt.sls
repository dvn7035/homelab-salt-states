# Minion set up

/etc/salt/minion:
  file.managed:
    - source: file:///srv/salt/salt/minion

#TODO: figure out the right way to do this with the service module
service salt-minion force-reload:
  cmd.run
