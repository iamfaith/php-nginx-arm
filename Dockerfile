FROM xianzixiang/py3
LABEL Maintainer="faith" \
      Description="Lightweight container with Nginx 1.14 & PHP-FPM 7.2 based on xenial."

# Install packages
RUN apt-get update; \
    apt-get install -y php7.0 php7.0-fpm php7.0-mysql nginx supervisor

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
#RUN chown -R apache:apache /run && \
#  chown -R apache:apache /var/lib/nginx && \
#  chown -R apache:apache /var/tmp/nginx && \
#  chown -R apache:apache /var/log/nginx

# Setup document root
RUN mkdir -p /var/www/html

RUN rm -rf /var/lib/apt/lists/*;\
    apt-get clean
    
# Switch to use a non-root user from here on
# USER apache

# Add application
WORKDIR /var/www/html
COPY src/ /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
