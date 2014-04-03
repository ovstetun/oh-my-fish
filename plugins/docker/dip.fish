function dip -d "Find the IPadress of a running docker container"
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' $argv[1]
end
