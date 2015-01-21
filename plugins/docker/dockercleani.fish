function dockercleani -d "Delete all untagged docker images"
  printf ">>> Deleting untagged images"
  docker rmi (docker images -q -f dangling=true)
end