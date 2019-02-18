cd `dirname $0`
sudo docker run -d -p 8080:8080 -v /var/www/blog:/var/www/html --rm -ti --name php-nginx xianzixiang/php-nginx
