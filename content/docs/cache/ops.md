# 查日志
    ERROR
    __tag__:__path__:/var/log/nginx/error.log
# 环境
    scp eureka-server-1.0-SNAPSHOT.jar shenwq@36.137.165.51:~
# 源
    163: http://mirrors.163.com/
    阿里云mirror: https://developer.aliyun.com/mirror
        ubuntu
            sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list 
    阿里云maven: https://maven.aliyun.com/mvn/view
    阿里云个人docker
        入口: cr.console.aliyun.com
            docker login -u 934260428@qq.com registry.cn-qingdao.aliyuncs.com
            docker tag java/device:1.0 registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker push registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker pull registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
# 分析
    nmon
    pidstat -p 434
        -u 1        # CPU
        -r 1        # 内存
        -d 1        # 磁盘
        -w          # 上下文切换
    iftop -n
        # 网络流量
    iotop
        p   # 显示pid
        o   # 只显示活跃
# java
    -Dserver.port=18001
    -Deureka.client.serviceUrl.defaultZone=http://localhost:19090/eureka
    -javaagent:/opt/svc/apache-skywalking-apm-bin/agent/skywalking-agent.jar
    -Dspring.profiles.active=prod
    -Dlogging.config=classpath:logback-spring-prod.xml
# mvn
    mvn dependency:tree -Dverbose -Dincludes=org.apache.commons:commons-lang3
        # 分析包依赖
# go
    go env -w GOPROXY=https://goproxy.cn,direct
    go list -m -u all 来检查可以升级的package，使用go get -u need-upgrade-package 升级后会将新的依赖版本
# linux日志
    dmesg
    journalctl
        -x
            # 显示解释
        -e
            # 显示到底部
        -u
            # 指定unit名, 如kubelet
        --no-pager
            # 不输出到管道来分页
        -f
            # 追加显示
        -q
            # 只显示warn以上信息
        --user-unit
            # 指定用户
        --since "2018-03-26" 
        --until "2018-03-26 03:00"

    journalctl -f --user-unit onedrive
    journalctl -xeu kubelet --no-pager

    快捷键
        ctrl alt f1/f2/...
# 网络
    ifconfig docker0 down
        ifconfig docker0 up
    tcpdump -n tcp port 8383 -i lo and src host 183.14.132.117
        -w 文件         # 文件会记录详细包
        -c 条数
        -n              # 不转端口成name
        -i 网卡
        -vvv            # 最详细输出
# 命令
    envsubst '${THREAD_NUM}' < decoder.conf.template > decoder.conf
    grep
        -v grep         # 过滤掉grep

        grep -nr --exclude-dir={.git, res, bin} 'a' .
            # 递归查找
    xargs
        -d "\t"         # 定义分隔符
        -t              # -t打印执行的命令
        -L 1            # 1行执行一次
        -n 1            # 一次使用1项
        -I arg1 sh -c 'echo arg1; mkdir arg1'       
            # 执行多命令
        --max-procs 0   # 并行执行，不限数量
    awk
        awk '{print $1}'
    sed
        sed -i '1i\new line'
            # 第一行前插入
    nmap
        nmap 192.168.100.1/24 -p1-65535
    onedrive
        systemctl --user enable onedrive
        systemctl --user start onedrive
        journalctl --user-unit onedrive -f

        onedrive --resync
    su
        切换登录
            sudo -i su outrun
    simplehttp
        python -m SimpleHTTPServer 8080
    diff        # 改变以匹配第二个文件
        diff -y a b
        diff dir1 dir2

        diff -uN a b > b.patch
        patch -p0 < b.patch
        patch -RE -p0 < b.patch

        diff -uNra a b > b.patch
        cd a
        patch -p1  < ../b.patch
        patch -RE -p1 < ../b.patch
    vimdiff a b
    rsync -av --exclude=.git --exclude=logs/* ./* 192.168.0.14:/data/app/ext-marketing/

    后台
        fg
        bg
        nohup
            nohup *** > /dev/null 2>&1 & 
        ^z
        ^c
        &
        jobs
    组合
        kill进程
            ps -ef|grep -v "grep"|grep aurora/app.js |awk '{print $2}'| xargs kill -9
        复制多个
            ls -rt | tail -4 | xargs -i cp -r {} ~/sdb/work/ryxWork/架构/
        替换文本
            sed -i "s/a/b/g" `grep -rl "a" ./`
        代码行数
            find -name "*.go" -or -name "*.py" |xargs grep -v "^$" |wc -l
        unzip中转码
            unzip -P “$(echo 中文 | iconv -f utf-8 -t gbk)”
        爬网站
            wget -x -P curSite -r -l 100 -k -L -np http://nodeapi.ucdok.com/api/
            带cookie
                wget --post-data="username=u1&password=asdf" --save-cookies=cookie --keep-session-cookies "http://www.abc.com/logging.php"
                wget -x -P curSite -r -l 1 -k -L -np --load-cookies=cookie --keep-session-cookies "https://www.abc.com/display/1"
# docker
    目录
        /var/lib/docker
    配置
        systemctl daemon-reload
        systemctl restart docker
        docker login -u outrun -p asdf
    registry
        docker login -u outrun -p asdf registry:5000
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
    镜像
        镜像文档: https://hub.docker.com/r/ivdata/snapserver/
        docker build -t java/gateway:1.0 .
        docker images
        docker image inspect 4de
        docker images|grep none|awk '{print $3}'|xargs docker rmi -f
            # 删除none镜像

        docker save -o a.tar.gz a
        docker load < a.tar.gz
            --input a.tar.gz
    容器
        docker
            run
                --user root
                --name a
                --privileged
                -v
        docker status 45370         # 显示资源占用
        docker inspect 45370        # 详情
            --format "{{.State.Pid}}"
        docker run --name gateway --rm -d java/gateway:1.0
        docker run -it ubuntu

        docker exec -it -u root ef2 /bin/bash
        docker restart ef2
        docker logs -f -t ef2
    system
        docker system prune -a

# chrome
    chrome://net-internals/#dns