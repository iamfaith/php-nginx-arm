cd `dirname $0`
sudo docker run -d -p 8080:8080 --rm -v /var/www/blog:/var/www/html -ti --name php-nginx xianzixiang/php-nginx
