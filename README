This is my configuration for my raspberry pi. The states are meant
to be run headless without a salt master server. You can use this
inspiration for projects on your pi, but be aware some of the
configuration only applies to my situation (e.g. the sshd_config
file specifies that my private ssh key can log in as root over ssh;
probably something you don't want me to be able to do to your pi).

To apply this salt state on a computer make sure you
have the salt-minion program installed. Then move this entire
folder to /srv/salt and run salt-call --local state.apply
