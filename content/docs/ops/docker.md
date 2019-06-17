---
Categories: ["运维"]
title: "Docker"
date: 2018-10-11T18:18:21+08:00
---

# 介绍
        基于linux LXC，可以实现虚拟化
# 镜象网站
        https://hub.docker.com/
# 命令
    docker
        -h
        search mysql
        pull centos:7
                centos:latest
                outrun11/test:nginx1
        images centos
                # 本地镜象列表
        ps -a
                # 容器列表
        rmi centos:latest
                # 删除镜象
        rm
                # 移除容器
                docker rm docker ps -aq
                        # 移除所有未运行的容器
                rm -f 026
        kill 026e
        restart 026e
        start 026
                    # 启动已建立的进程
            cp 026e:/docker/file /local/file
        login
        build -t="nginx/test" .
                # 用当前目录Dockerfile创建新镜像
        tag nginx/test:test1 outrun11/test:nginx1
                # 要求docker网站中创建了名为test的repository
        push outrun11/test:nginx1
            logs beae3392
            run
                    # 从镜像建立进程
                    # id可以只输入前几位
                    # -t 伪tty, -i 交互的
                    # -rm=true执行完后删除
                    # -v /etc/:/opt/etc/ 挂载本机/etc到容器/opt/etc, /etc/:/opt/etc/:ro 只读挂载, /etc/ 对外共享/etc
                    # -p 1234:80 端口映射本机1234端口到容器80
                    # --volumes-from etc_share 使用另一个容器对外共享的磁盘
                    # -d 后台运行
                    # --link redis_server:redis 连接容器的redis命令
                    # -w /var/node 当前工作目录
                    # -e NODE_ENV='' 环境变量

                    -t -i centos /bin/bash
                    # 启动容器, 执行bash
                    b15 /bin/echo 'hello'
                    # 启动容器
                    --rm=true -i -t --name=ls-volume -v /etc/:/opt/etc/ centos ls /opt/etc
                    # 创建共享
                    -i -t -p 1337:1337 --name=etc_share -v /etc/ centos mkdir /etc/my_share && /bin/sh -c "while true; do echo hello; sleep 1; done"
                    # 持续运行
                    --rm=true -i -t --volumes-from etc_share --name=ls_etc centos ls /etc
                    # 使用共享
# 配置
    /etc/sysconfig/docker
            # /etc/init.d/docker.conf
            OPTIONS='--selinux-enabled --log-driver=journald --insecure-registry 45.55.56.16:5000 --dns 8.8.8.8'
            DOCKER_CERT_PATH=/etc/docker
# Dockerfile
    FROM nginx
            # 基于镜像
    EXPOSE 80
            # 内部服务开启的端口
    ENV NODE_ENV test
            # 环境变量
    COPY ./bin /data/a
            # 复制外部文件到内部
    VOLUME ["/data/log"]
            # 创建挂载点
    ENTRYPOINT ["/data/a/a"]
            # 容器启动命令，只有一个
    CMD ["-config", "config.toml"]
            # 启动命令，只有一个。可为entrypoint指定参数
    RUN echo 'test'
            # 在当前镜像基础上执行命令，提交为新的镜像
    MAINTAINER outrun
            # 指定维护者信息
# 方案
    进入容器
        docker exec -it mysql bash
    私有仓库
            docker pull registry
            iptables -I INPUT 1 -p tcp --dport 5000 -j ACCEPT
            docker run -d -p 5000:5000 --privileged=true -v /opt/registry:/tmp/registry registry 
            /etc/sysconfig/docker
                    OPTIONS='--selinux-enabled --log-driver=journald --insecure-registry 45.55.56.16:5000'
                    DOCKER_CERT_PATH=/etc/docker

            docker tag busybox 45.55.56.16:5000/busybox
            docker push 45.55.56.16:5000/busybox
            docker search 45.55.56.16:5000/
            
            o-> 客户端
            /etc/docker/daemon.json
                    {"insecure-registries":["45.55.56.16:5000"]}

    jenkins
            docker pull jenins
            mkdir /var/jenkins_home
            docker run -d --name myjenkins -p 49001:8080 -u 0 -v /var/jenkins_home:/var/jenkins_home jenkins
                    # -u 0 用root帐户启动
            
    nsenter
            # 不需ssh进入容器shell
            docker run -v /usr/local/bin:/target jpetazzo/nsenter
                    # 安装
            docker ps 
                    # 查看要进入的容器id
            docker inspect --format {{.State.Pid}} 214
                    # 容器id得到pid
            nsenter --target 4629 --mount --uts --ipc --net  --pid

    提交镜像到官方
            docker -ps -a
            docker login
            docker commit d79 outrun11/node_pm2
                    # 把容器提交为镜像
            docker images node_pm2
            docker push outrun11/node_pm2

    redis
            docker run --name redis-server -p 6379:6379 -d redis redis-server --appendonly yes
                    # 启动redis
            docker run --rm=true -it --link redis-server:redis redis /bin/bash
                    # 连接redis

    node项目
            docker run --rm -i -t -v /var/node/docker_node:/var/node/docker_node -w /var/node/docker_node/ outrun11/node_pm2 npm install
                    # 部署项目
            mkdir /var/log/pm2

            docker run -d --name 'nodeCountAccess' -p 8000:8000 -v /var/node/docker_node:/var/node/docker_node  -v /var/log/pm2:/root/.pm2/logs --link redis-server:redis -w /var/node/docker_node/ outrun11/node_pm2 pm2 start --no-daemon app.js

    rabbitmq
            docker run -d -e RABBITMQ_NODENAME=my-rabbit --name some-rabbit -p 5672:5672 rabbitmq


    mysql
        初次
            docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=asdf -v /data/var/mysql/:/var/lib/mysql -d mysql
            docker stop 5c5
            docker run -it -v /data/var/mysql/:/var/lib/mysql -v /home/outrun/docker/etc/mysql/my.cnf:/etc/mysql/my.cnf mysql /bin/bash
            mysqld_safe --user=mysql --skip-grant-tables --skip-networking &
            mysql mysql
            update user set authentication_string=password('asdf') where user='root' ;
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'asdf' WITH GRANT OPTION;
            flush privileges;
            # restart mysql
            docker run -d -p 3306:3306 -v /data/var/mysql/:/var/lib/mysql -v /home/outrun/docker/etc/mysql/my.cnf:/etc/mysql/my.cnf mysql
    制作镜像
        make
        docker build -t search:v1 .
        docker images
        docker run -p 50088:80 -d search:v1
        docker ps -a
        docker logs ea1
        docker rmi bc8
    es
        docker run -it  -v /home/test/es/config/:/usr/share/elasticsearch/config/ -v /home/test/es/plugins/:/usr/share/elasticsearch/plugins/ elasticsearch:5.4.3 /bin/bash
        docker run -d -p 9200:9200 -p 9300:9300 --name es  -v /home/test/es/config/:/usr/share/elasticsearch/config/ -v /home/test/es/plugins/:/usr/share/elasticsearch/plugins/ elasticsearch:5.4.3
# 工具
    harbor
            企业级register镜像服务器
    pipwork
        shell写的docker网格配置工具