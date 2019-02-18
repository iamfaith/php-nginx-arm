cd `dirname $0`
sudo docker build -t xianzixiang/php-nginx .
docker rm $(docker ps -aq)
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
