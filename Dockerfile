FROM php:7.0-apache

LABEL "com.github.actions.name"="WordPress Pot Generator"
LABEL "com.github.actions.description"="WordPress Pot File Generator"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Varun Sridharan <varunsridharan23@gmail.com>"
LABEL version="1.0.0"
LABEL repository="https://github.com/varunsridharan/github-actions-wordpress-pot-generator"

# Environments
ENV TIMEZONE                 Asia/Kolkata
ENV PHP_MEMORY_LIMIT         512M
ENV MAX_UPLOAD               50M
ENV PHP_MAX_FILE_UPLOAD      200
ENV PHP_MAX_POST             100M
ENV PHP_INI_DIR              /etc/php7/php.ini
ENV HOME                     /root
ENV PATH                     "/composer/vendor/bin:~/.local/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME            /composer
ENV VAULT_VERSION 1.0.2

# install the PHP extensions we need
RUN apt-get update && apt-get install -y wget git mysql-client && rm -rf /var/lib/apt/lists/* 

RUN apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& git config --global user.email "wppotgenerator+github@gmail.com" \
	&& git config --global user.name "WPPot Generator on GitHub"

RUN php -v

# Set environments
RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" "$PHP_INI_DIR" && \
    sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" "$PHP_INI_DIR" && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" "$PHP_INI_DIR" && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" "$PHP_INI_DIR" && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" "$PHP_INI_DIR" && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" "$PHP_INI_DIR"

# Update php config
RUN mkdir -p "/etc/php7/conf.d" && \
    echo "memory_limit=-1" > "/etc/php7/conf.d/memory-limit.ini" && \
    echo "date.timezone=Asia/Kolkata" > "/etc/php7/conf.d/date_timezone.ini"


# Setup wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
