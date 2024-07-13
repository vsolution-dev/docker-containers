FROM php:8.1-fpm-alpine

ENV TZ Asia/Seoul

ENV UNAME laravel
ENV UGROUP laravel
ENV UID 1000
ENV GID 1001

RUN addgroup --gid $GID $UGROUP \
 && adduser --disabled-password --ingroup $UGROUP --uid $UID $UNAME

RUN apk update \
 && apk add --no-cache \
    build-base \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    git \
    curl \
    openssh-client \
    bash \
    gettext

RUN docker-php-ext-install \
    mysqli \
    pdo_mysql \
    pcntl \
 && docker-php-ext-enable \
    mysqli \
    pdo_mysql \
    pcntl

RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

RUN sed -i 's/user = www-data/user = '"${UNAME}"'/' /usr/local/etc/php-fpm.d/www.conf \
 && sed -i 's/group = www-data/group = '"${UGROUP}"'/' /usr/local/etc/php-fpm.d/www.conf \
 && sed -i 's/listen.owner = www-data/listen.owner = '"${UNAME}"'/' /usr/local/etc/php-fpm.d/www.conf \
 && sed -i 's/listen.group = www-data/listen.group = '"${UGROUP}"'/' /usr/local/etc/php-fpm.d/www.conf

WORKDIR /home/$UNAME
COPY id_rsa ./.ssh/id_rsa
RUN chmod 600 ./.ssh/id_rsa \
 && touch ./.ssh/known_hosts \
 && ssh-keyscan github.com >> ./.ssh/known_hosts \
 && chown -R $UNAME:$UGROUP ./.ssh

USER $UNAME:$UGROUP

WORKDIR /app
RUN git clone $GIT_URL .

COPY --chown=$UNAME:$UGROUP \
    .env \
    docker-entrypoint.sh \
    ./

RUN chmod +x docker-entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["php-fpm"]
