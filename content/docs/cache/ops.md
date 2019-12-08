# xargs
    xrags 
        -d "\t"         # 定义分隔符
        -t              # -t打印执行的命令
        -L 1            # 1行执行一次
        -n 1            # 一次使用1项
        -I arg1 sh -c 'echo arg1; mkdir arg1'       
            # 执行多命令
        --max-procs 0   # 并行执行，不限数量
# awk
# maven
    mvn clean package -DskipTests
    maven
        maven helper plugin
        打包main方法jar不能引用
        用父项目mvn package, 如果用子项目mvn package会找不到其它子项目(not exist)
        模块运行前mvn package
# docker
    系统
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        docker build --help
    镜像
        docker build -t java/gateway:1.0 .
        docker images
        docker image inspect 4de
        镜像文档: https://hub.docker.com/r/ivdata/snapserver/
    容器
        docker status 45370         # 显示资源占用
        docker inspect 45370        # 详情

        docker run --name gateway --rm -d java/gateway:1.0
        docker exec -it -u root ef2 /bin/bash
        docker restart ef2
        docker logs -f -t ef2

# snap
# brew
    安装：/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
    目录: /usr/local/Homebrew
    命令
        brew
            update              # 更新brew
            search
            install
            remove
            upgrade
            tap                 # 安装扩展
            options             # 查看安装选项
            info
            home                # 访问包官网
            services
                list            # 查看已安装
                cleanup         # 清除无用配置
                restart         # 重启
# ubuntu
    apt-cache madison nginx     # 查看仓库中所有版本
# centos
    yum install epel-release
    gcc升级
        yum -y install centos-release-scl
        yum -y install devtoolset-6-gcc devtoolset-6-gcc-c++ devtoolset-6-binutils
        scl enable devtoolset-6 bash
        echo "source /opt/rh/devtoolset-6/enable" >>/etc/profile
    dnf install @development-tools
    snap info mosquitto         # 查看仓库所有版本