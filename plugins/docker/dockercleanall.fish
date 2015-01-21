function dockerclean -d "Delete all stopped containers and untagged images."
  dockercleanc || true && dockercleani
end