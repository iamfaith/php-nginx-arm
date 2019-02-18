cd `dirname $0`
sudo docker run -d -p 8080:8080 --rm -ti --name php-nginx xianzixiang/php-nginx
