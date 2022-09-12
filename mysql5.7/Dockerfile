FROM mysql:5.7

LABEL maintainer="phpdev<phpdev@qq.com>"

# repositorie mirror
RUN { \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free'; \
	} > /etc/apt/sources.list

# timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo 'Asia/Shanghai' > /etc/timezone; \
    chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod 0444 /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
