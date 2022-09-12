FROM nginx:1.19

LABEL maintainer="phpdev<phpdev@qq.com>"

RUN { \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free'; \
		echo 'deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free'; \
	} > /etc/apt/sources.list

# Timezone
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone

COPY nginx.conf /etc/nginx/nginx.conf
