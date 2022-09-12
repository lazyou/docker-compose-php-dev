FROM mysql:8.0.26

LABEL maintainer="cwl <328602875@qq.com>"

# repositorie mirror
RUN { \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free'; \
	} > /etc/apt/sources.list

# timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo 'Asia/Shanghai' > /etc/timezone;

COPY my.cnf /etc/mysql/conf.d/

CMD ["mysqld"]

EXPOSE 3306
