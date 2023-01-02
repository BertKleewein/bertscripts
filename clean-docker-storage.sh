
echo "removing exited containers"
sudo docker rm $(docker ps -a -f status=exited -q)

echo "removing containers that were created but never used"
sudo docker rm $(docker ps -a -f status=created -q)

echo "removing all unused images"
sudo docker rmi -f $(docker images -q)

