FROM bartsk/alpine
RUN apk add php7 \
            php7-curl \
            php7-mbstring \
            php7-iconv \
            php7-openssl \
            php7-json \
            php7-phar \ 
            php7-pdo \
            php7-tokenizer \
            php7-session \
            sshfs \
            rsync \
            curl && \
            curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer


ADD ./php.ini /etc/php7/php.ini

ADD ./sshfs-deploy.sh /root