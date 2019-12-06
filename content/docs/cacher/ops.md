# docker
    sudo systemctl daemon-reload
    sudo systemctl restart docker

    docker build -t java/gateway:1.0 .
    docker run --name gateway -d java/gateway:1.0

    docker status 45370         # 显示资源占用
    docker inspect 45370        # 详情
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