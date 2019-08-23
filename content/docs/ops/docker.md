---
Categories: ["运维"]
title: "Docker"
date: 2018-10-11T18:18:21+08:00
---

# 基础
    介绍
        基于linux LXC，可以实现虚拟化
    优点
        低成本、高利用率、充分灵活、动态调度
        核心网的最终形态
    镜象网站
        https://hub.docker.com/
    配置
        /etc/sysconfig/docker
            # /etc/init.d/docker.conf
            OPTIONS='--selinux-enabled --log-driver=journald --insecure-registry 45.55.56.16:5000 --dns 8.8.8.8'
            DOCKER_CERT_PATH=/etc/docker
# 命令
    docker
        -h
        version
        search mysql                    # 搜索镜像
        pull centos:7                   # 下载镜像
            centos:latest
            outrun11/test:nginx1
        image
            ls
            pull
            rm
        images centos                   # 本地镜象列表
        rmi centos:latest               # 删除镜象
        container
            run                         # 新建容器
                --name                  # 显示名
                -t                      # 伪tty, -i 交互的
                -rm=true                # 执行完后删除
                -v /etc/:/opt/etc/      # 挂载本机/etc到容器/opt/etc, /etc/:/opt/etc/:ro 只读挂载, /etc/ 对外共享/etc
                -p 1234:80              # 端口映射本机1234端口到容器80
                --volumes-from etc_share                    # 使用另一个容器对外共享的磁盘
                -d                      # 后台运行
                --link redis_server:redis                   # 连接容器的redis命令
                -w /var/node            # 当前工作目录
                -e NODE_ENV=''          # 环境变量

                --name nsqd -p 4150:4150 nsqio/nsq /nsqd
                    # 端口
                -it centos /bin/bash
                    # 启动容器, 执行bash
                b15 /bin/echo 'hello'
                    # 启动容器
                -it --rm=true --name=ls-volume -v /etc/:/opt/etc/ centos ls /opt/etc
                    # 创建共享
                -it -p 1337:1337 --name=etc_share -v /etc/ centos mkdir /etc/my_share && /bin/sh -c "while true; do echo hello; sleep 1; done"
                    # 持续运行
                -it --rm=true --volumes-from etc_share --name=ls_etc centos ls /etc
                    # 使用共享
            exec                        # 已有容器中运行
                -i
                -t
            ls
            start 026                       # 启动已建立的容器, id可以只输入前几位
                cp 026e:/docker/file /local/file
            restart 026e
            kill 026e
        ps -a                           # 容器列表
        rm                              # 移除容器
            docker rm docker ps -aq
                # 移除所有未运行的容器
            rm -f 026


        login
        build -t="nginx/test" .         # 用当前目录Dockerfile创建新镜像
        tag nginx/test:test1 outrun11/test:nginx1
            # 远程docker基站创建repository, 名字test
        push outrun11/test:nginx1
            logs beae3392


        swarm                           # 一个或多个docker组成
            init
        node                            # swarm节点
            ls
        service                         # 运行于swarm的服务
            create
            ls
            ps
            rm
            inspect                     # 详情
            scale                       # 加减副本
            update                      # 变更属性
            logs                        # 查日志


        network                         # 网卡
            ls
            rm
            prune                       # 删除全部未使用
            inspect                     # 详情
            create
                -d nat                  # 指定驱动


        volume
            create
            ls
            rm
            prune                       # 删除全部未使用
            inspect


        stack                           # 单文件定义多服务
            deploy
            ls
            ps
            rm
# docker-compose
    docker-compose
        -h                              # 帮助
        -f                              # 指定模板
        version

        up                              # 所有模板创建容器
            -d                          # 后台
        down                            # 删除容器、网络、卷、镜像
        rm                              # 删除容器
        create                          # 创建容器

        stop                            # 停止容器
        start                           # 启动容器
        restart
        pause                           # 暂停容器
        unpause
        kill                            # 强制停止容器
        scale                           # 指定容器个数

        ps                              # 列出所有容器
        logs                            # 查日志
        port                            # 显示容器映射端口
        run                             # 容器中执行命令
        exec

        config                          # 查看配置
        build                           # (重)构建容器
        pull                            # 拉依赖镜像
        push                            # 推送镜像


# Dockerfile
    FROM nginx                          # 基于镜像
    MAINTAINER outrun                   # 指定维护者信息
    EXPOSE 80                           # 内部服务开启的端口
    ENV NODE_ENV test                   # 环境变量
    WORKDIR /src
    COPY ./bin /data/a                  # 复制外部文件到内部
    VOLUME ["/data/log"]                # 创建挂载点
    ENTRYPOINT ["/data/a/a"]            # 容器启动命令，只有一个
    CMD ["-config", "config.toml"]      # 启动命令，只有一个。可为entrypoint指定参数
    RUN echo 'test'                     # 在当前镜像基础上执行命令，提交为新的镜像
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
    制作镜像
        make
        docker build -t search:v1 .
        docker images
        docker run -p 50088:80 -d search:v1
        docker ps -a
        docker logs ea1
        docker rmi bc8
    提交镜像到官方
        docker -ps -a
        docker login
        docker commit d79 outrun11/node_pm2
            # 把容器提交为镜像
        docker images node_pm2
        docker push outrun11/node_pm2
    代理
        /etc/systemd/system/docker.service.d/http-proxy.conf            # 没有时创建
            Environment="HTTP_PROXY=http://127.0.0.1:8123"
                "HTTPS_PROXY=http://127.0.0.1:8123"
                "NO_PROXY=192.168.1.1,localhost"
        systemctl daemon-reload
    换源
        /etc/docker/daemon.json                                         # 没有时创建
            {
              "registry-mirrors": ["https://nmp74w3y.mirror.aliyuncs.com"]
            }
        systemctl daemon-reload
        systemctl restart docker
    登录运行容器
        docker exec -it 8ce /bin/bash
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
    es
        docker run -it  -v /home/test/es/config/:/usr/share/elasticsearch/config/ -v /home/test/es/plugins/:/usr/share/elasticsearch/plugins/ elasticsearch:5.4.3 /bin/bash
        docker run -d -p 9200:9200 -p 9300:9300 --name es  -v /home/test/es/config/:/usr/share/elasticsearch/config/ -v /home/test/es/plugins/:/usr/share/elasticsearch/plugins/ elasticsearch:5.4.3
    dokuwiki
        docker-compose.yml
            version: '3'
            services:
              dokuwiki:
                restart: always
                image: bitnami/dokuwiki:latest
                ports:
                  - 8004:80
                environment:
                  - DOKUWIKI_FULL_NAME=outrun
                  - DOKUWIKI_EMAIL=934260428@qq.com
                  - DOKUWIKI_WIKI_NAME=Wiki
                  - DOKUWIKI_USERNAME=outrun
                  - DOKUWIKI_PASSWORD=asdfasdf
                volumes:
                  - ./.data:/home/outrun/scripts/config/dokuwiki/data
        docker-compose -f /路径/docker-compose.yml up -d

# 工具
    harbor
        企业级register镜像服务器
    pipwork
        shell写的docker网格配置工具