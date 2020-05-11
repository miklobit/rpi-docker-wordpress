FROM oscarortegano/rpi-docker-lamp:latest
MAINTAINER Oscar Ortegano <oscarortegano@gmail.com>, Joaquín de la Zerda <joaquindelazerda@gmail.com>, Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>

# Install plugins
RUN apt-get update && \
  apt-get -y install php7.0-gd php-xml php7.0-xml

# Download latest version of Wordpress into /app
RUN rm -fr /app && git clone --depth=1 https://github.com/WordPress/WordPress.git /app

# Configure Wordpress to connect to local DB
ADD wp-config.php /app/wp-config.php

# Modify permissions to allow plugin upload
RUN chown -R www-data:www-data /app/wp-content /var/www/html

# Add database setup script
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD create_db.sh /create_db.sh
RUN chmod +x /*.sh


EXPOSE 80 3306
CMD ["/run.sh"]
