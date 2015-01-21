function dockercleanc -d "Delete all stopped containers"
  printf ">>> Deleting stopped containers\n\n"
  docker rm (docker ps -a -q)
end