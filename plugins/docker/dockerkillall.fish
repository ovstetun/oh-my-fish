function dockerkillall -d "Kill all running containers"
  docker kill (docker ps -q)
end