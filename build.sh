cd `dirname $0`
sudo docker build -t xianzixiang/php-nginx-arm .
sudo docker rm $(docker ps -aq)
sudo docker rmi $(sudo docker images -a| grep none | awk '{print $3}')
