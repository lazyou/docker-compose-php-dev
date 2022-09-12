### 项目概述
* php 相关开发环境

* php开发用 docker 环境, 包含 php7.2 php7.4 php8.0, mysql5.6 mysql5.7 mysql8.0, nginx1.19, node14, redis5.


### 运行环境要求
* docker 20.10+


### 开发环境部署/安装
* 请确保本地安装了 [docker](https://yeasy.gitbook.io/docker_practice/install)，及 [docker-compose](https://yeasy.gitbook.io/docker_practice/compose/install)。


### 基础安装
#### 1. .env 文件配置， 并设置 UID， GID
* `cp .env.example .env`


#### 2. 克隆项目代码
```bash
cd 目录
mkdir workspace
cd workspace
git clone <项目代码仓库地址>
```


#### 3. 拉取镜像
```bash
cd 目录

docker-compose pull
```


#### 4. 启动服务
```bash
docker-compose up -d

docker-compose exec php8.0 /bin/bash
php bin/hyperf.php start


docker-compose exec node /bin/bash
npm run dev

# restart service
docker-compose restart nginx
```


#### 5. 修改dockerfile 重新 build
* `docker-compose build`

* `docker-compose up --build`


### 6.1 重启某个服务
* `docker-compose restart nginx`



### 6.2 重新编译某个服务
* `docker-compose build php8.0-fpm`



### 6.3 查看某个服务日志
* `docker-conpose log [-f] nginx`


### 7. 使用 phpmyadmin (然而不好用， 可临时用)
```sh
# 去 https://www.phpmyadmin.net/ 下载最新 all-languages

cp config.sample.inc.php config.inc.php

# 设置 
$cfg['blowfish_secret'] = '1qHGA3PxE5OJKSGXrzeXYyRer97ONT5V'; # 随机32位字符串即可
$cfg['Servers'][$i]['host'] = 'mysql8';
```


### 其他问题
* 解决PHP低版本连接数据库问题, 记得自行修改密码, 别被这里的给覆盖了
```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '自行修改密码';
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '自行修改密码';
ALTER USER 'default'@'%' IDENTIFIED WITH mysql_native_password BY '自行修改密码';
```

* --keyserver 如果连接有问题可以尝试如下的命令
    * `&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 4F4EA0AAE5267A6C \`
