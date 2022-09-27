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
    目录
        /var/lib/docker
# 配置
    镜象网站
        https://hub.docker.com/
    阿里云个人仓库
        入口: cr.console.aliyun.com
            docker login -u 934260428@qq.com registry.cn-qingdao.aliyuncs.com
            docker tag java/device:1.0 registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker push registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker pull registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
    /etc/sysconfig/docker
        # /etc/init.d/docker.conf
        OPTIONS='--selinux-enabled --log-driver=journald --insecure-registry 45.55.56.16:5000 --dns 8.8.8.8'
        DOCKER_CERT_PATH=/etc/docker
# 命令
## 常用系统命令
    systemctl daemon-reload
    systemctl restart docker
## docker
    -h
    version
    login
        docker login -u outrun -p asdf
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
            --user root
            --name a
            --privileged
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
            --net=bridge            # 网络模式，bridge使用虚拟网桥docker0, host共享主机命名空间, container与已存在的一个容器共享命名空间, none关闭网络功能, overlay

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
        stop 026
        restart 026e
        attach 026                  # 进入容器运行命令行, 可显示日志
        kill 026e
        prune
    ps -a                           # 容器列表
    rm                              # 移除容器
        docker rm docker ps -aq
            # 移除所有未运行的容器
        rm -f 026


    build .                         # 用当前目录Dockerfile创建新镜像
        -t="nginx/test"             # target
        --no-cache                  # 不用cache
        -f a.dockerfile             # 指定文件
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
    system 
        prune                       # 清理所有container, network, image, cache
    network                         # 网卡
        ls
        rm
        prune                       # 删除全部未使用
        inspect                     # 详情
        create
            -d nat                  # 指定驱动
    volume                          # 卷标, 默认挂载到/var/lib/docker/volumes
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
    
    常用
        docker inspect 45370        # 详情
            --format "{{.State.Pid}}"
        docker login a.com -u outrun -p asdf
        docker build -t java/gateway:1.0 .
        docker push java/gateway:1.0
        docker images|grep none|awk '{print $3}'|xargs docker rmi -f
            # 删除none镜像
        docker image inspect 4de
        docker system prune -a
        docker exec -it -u root ef2 /bin/bash
        docker run --name gateway --rm -d java/gateway:1.0
        docker run -it ubuntu
        docker restart ef2
        docker logs -f -t ef2
        docker status 45370         # 显示资源占用
        docker save -o a.tar.gz a
        docker load < a.tar.gz
## nsenter
    # 指定pid, 不需ssh进入容器运行shell
    docker inspect --format {{.State.Pid}} nginx
    nsenter -t4629 -n
### 场景
    查看镜像内文件
        docker run -it --entrypoint sh nginx:latest
    查看/var/lib/docker/overlay2/id文件对应container
        docker ps -q | xargs docker inspect --format '{{.State.Pid}}, {{.Id}}, {{.Name}}, {{.GraphDriver.Data.WorkDir}}' | grep bff250
# Dockerfile
    指令
        FROM nginx                          # 基于镜像
        MAINTAINER outrun                   # 指定维护者信息
        EXPOSE 80                           # 内部服务开启的端口
        ENV NODE_ENV test                   # 环境变量
        WORKDIR /src                        # 指定工作目录
        COPY ./bin /data/a                  # 复制外部文件到内部
        VOLUME ["/data/log"]                # 创建挂载点
        ENTRYPOINT ["/data/a/a"]            # 启动命令，只有一个
        CMD ["-config", "config.toml"]      # docker run 时运行
        RUN echo 'test'                     # build过程中执行的命令
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
    配置
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
              - ./data:/bitnami                                         # 本地:镜像
# 仓库
## habor
## registry
    htpasswd  -Bbn outrun asdf > auth/htpasswd

    客户端使用
        /etc/docker/daemon.json
            {"insecure-registries":["127.0.0.1:5000"]}
        sudo systemctl daemon-reload
        sudo systemctl restart docker

        docker login 127.0.0.1:5000

        docker tag java/device:1.0 127.0.0.1:5000/java/device:1.0
        docker push 127.0.0.1:5000/java/device:1.0
        curl --user outrun:asdf 127.0.0.1:5000/v2/_catalog
            # v2表示版本 registry:2
        docker pull 127.0.0.1:5000/java/device:1.0
    常用API
        curl --user outrun:asdf -X GET  registry:5000/v2/_catalog
            # 列表
        curl --user outrun:asdf -X GET  registry:5000/v2/ubuntu/tags/list
            # tags
        curl --user outrun:asdf -X GET  registry:5000/v2/ubuntu/manifests/latest
            # tag
        curl --user outrun:asdf -X GET -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" registry:5000/v2/ubuntu/manifests/latest 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}'
            # digest
        curl --user outrun:asdf -X DELETE -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" registry:5000/v2/ubuntu/manifests/sha256:134c7fe821b9d359490cd009ce7ca322453f4f2d018623f849e580a89a685e5d
            # 删除
        docker exec -it 4ebff4cdc646 /bin/registry garbage-collect  /etc/docker/registry/config.yml
            # 删除后, 运行垃圾回收
# 方案
    查容器pid
        docker container top ea1
        docker inspect -f '{{.State.Pid}}' ea1
    批量删除镜像
        docker rmi $(docker image ls -a |grep jncloud |awk '{print $3}')
    进入容器
        docker exec -it mysql bash
    制作镜像并运行
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
        docker exec -it --user root 8ce /bin/sh
# 工具
    harbor
        企业级register镜像服务器
    pipwork
        shell写的docker网格配置工具