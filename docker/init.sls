# Making sure old versions of docker were uninstalled

docker:
  pkg.removed

# Dependencies for installing Docker through the repo

repo_setup:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

~/docker.gpg:
  file.managed:
    - source: https://download.docker.com/linux/debian/gpg
    - source_hash: sha256=1500c1f56fa9e26b9b8f42452a553675796ade0807cdce11975eb98170b3a570

docker_repo_for_jessie:
  pkgrepo.managed:
    - name: deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main
    - key_url: https://download.docker.com/linux/debian/gpg

docker-engine:
  pkg.installed
