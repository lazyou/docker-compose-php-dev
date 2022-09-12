FROM ubuntu:20.04

LABEL maintainer="phpdev<phpdev@qq.com>"

# Fixes some weird terminal issues such as broken clear / CTRL+L
ENV TERM=linux

# Ensure apt doesn't ask questions when installing stuff
ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' > /etc/apt/sources.list; \
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' >> /etc/apt/sources.list; \
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' >> /etc/apt/sources.list; \
    echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' >> /etc/apt/sources.list

# Install Ondrej repos for Ubuntu focal, PHP8.0, composer and selected extensions - better selection than
# the distro's packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends gnupg ca-certificates \
    && echo "deb https://launchpad.proxy.ustclug.org/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ondrej-php.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        tzdata \
        curl \
        unzip \
        fish \
        php8.0-apcu \
        php8.0-bcmath \
        php8.0-bz2 \
        php8.0-cli \
        php8.0-common \
        php8.0-curl \
        php8.0-fpm \
        php8.0-gd \
        php8.0-intl \
        php8.0-mbstring \
        php8.0-mysql \
        php8.0-opcache \
        php8.0-readline \
        php8.0-redis \
        php8.0-swoole \
        php8.0-xml \
        php8.0-zip \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && ln -sf /usr/sbin/php-fpm8.0 /usr/sbin/php-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# RUN apt-get update \
#     && apt-get -y --no-install-recommends install \
#         build-essential \
#         git \
#         jq \
#         php8.0-dev \
#     && cd /tmp \
#     && export SWOOLE_VERSION=`curl -s https://api.github.com/repos/swoole/swoole-src/releases/latest |jq -r .tag_name` \
#     && git clone https://gitee.com/swoole/swoole.git swoole-src \
#     && cd swoole-src \
#     && git checkout ${SWOOLE_VERSION} \
#     && phpize \
#     && ./configure --enable-openssl --enable-http2 --enable-sockets --enable-mysqlnd \
#     && make \
#     && make install-modules \
#     && apt-get autoremove --purge -y git php8.0-dev build-essential \
#     && cd / \
#     && rm -rf /tmp/swoole-src \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN echo "memory_limit=1G" > /etc/php/8.0/cli/conf.d/00_default.ini \
    && echo "opcache.enable_cli = 'On'" >> /etc/php/8.0/cli/conf.d/00_opcache.ini \
    && echo "swoole.use_shortname = 'Off'" >> /etc/php/8.0/cli/conf.d/25_swoole.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

STOPSIGNAL SIGQUIT

# PHP-FPM packages need a nudge to make them docker-friendly
COPY overrides.conf /etc/php/8.0/fpm/pool.d/z-overrides.conf

RUN set -xe \
    && apt-get update \
    && apt-get install -y nginx supervisor nodejs npm --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

RUN npm config set registry https://registry.npm.taobao.org

RUN rm -f /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 8080

COPY crond-entrypoint.sh /usr/local/bin/crond-entrypoint
RUN chmod +x /usr/local/bin/crond-entrypoint

RUN groupadd --gid 1000 qltech \
  && useradd --uid 1000 --gid qltech --shell /bin/bash --create-home qltech

RUN chmod -R 777 /run

USER qltech

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

WORKDIR /workspace

# CMD ["/usr/sbin/php-fpm8.0", "-O" ]

# EXPOSE 9000

# If you'd like to be able to use this container on a docker-compose environment as a quiescent PHP CLI container
# you can /bin/bash into, override CMD with the following - bear in mind that this will make docker-compose stop
# slow on such a container, docker-compose kill might do if you're in a hurry
# CMD ["tail", "-f", "/dev/null"]
