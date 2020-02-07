# 源
    163: http://mirrors.163.com/
    阿里云mirror: https://developer.aliyun.com/mirror
        ubuntu
            sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list 
    阿里云maven: https://maven.aliyun.com/mvn/view
    阿里云个人docker
        入口: cr.console.aliyun.com
            docker login --username=934260428@qq.com registry.cn-qingdao.aliyuncs.com
            docker tag java/device:1.0 registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker push registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
            docker pull registry.cn-qingdao.aliyuncs.com/mrs-iot/device:1.0
# linux日志
    dmesg
    journalctl
        -x
            # 显示解释
        -e
            # 显示到底部
        -u
            # 指定unit名
        --no-pager
            # 不输出到管道来分页
        -f
            # 追加显示
        --user-unit
            # 指定用户

    journalctl -f --user-unit onedrive
    journalctl -xeu kubelet --no-pager

    快捷键
        ctrl alt f1/f2/...
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
        nmap 192.168.100.1/24
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
    容器
        docker
            run
                --user root
                --name a
                --privileged
                -v
        docker status 45370         # 显示资源占用
        docker inspect 45370        # 详情

        docker run --name gateway --rm -d java/gateway:1.0
        docker run -it ubuntu

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
# git
    tag
        git tag -a v1.0.1  -m 'a' e67 
# kubenetes
## minikube
    docker login --username=934260428@qq.com registry.cn-hangzhou.aliyuncs.com
    命令
        minikube
            start --vm-driver=virtualbox \
                --memory=4096 \
                --cpus=2 \
                --log_dir=/home/outrun/logs \
                --insecure-registry=192.168.99.1:5000 \
                --insecure-registry=registry.cn-qingdao.aliyuncs.com \
                --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

                --kubernetes-version v1.17.0
                --docker-env=HTTP_PROXY=$HTTP_PROXY \
                --docker-env=HTTPS_PROXY=$HTTPS_PROXY \
                --docker-env=NO_PROXY=$NO_PROXY \
                --image-mirror-country=cn \
                --registry-mirror=https://registry.docker-cn.com \
                --extra-config=kubelet.MaxPods=5.
                    # registry一定是minikube容器ip, 可用ifconfig查看
                    # --insecure-registry修改需要minikube delete
            stop
            delete
            status 
            docker-env
            ip      # 得到单机集群ip
            service  -n iot mosquitto --url
                # 得到service的nodePort

            ssh
            dashboard
            addons
                list
                enable heapster
                enable ingress
    服务
        kube-system
            coredns
            etcd-minikube
            kube-addon-manager-minikube
            kube-proxy
            kube-scheduler-minikube
            nginx-ingress-controller
            storage-provisioner
        kubernetes-dashboard
            dashboard-metrics-scraper
            kubernetes-dashboard
## kubeadm
    kubeadm init
## kubectl
    配置
        envsubst < iot.yml |kubectl apply -f -

    全局参数
        --output="jsonpath={.data.\.dockerconfigjson}"
        --output=yaml
        --context=iot
        --namespace=iot 
        --all-namespaces=true
        -n
            # namespace
    Basic Commands (Beginner):
        create
            -f y1.yml
        expose
            deployment deploy1
                --target-port=8080
                --type=NodePort
        run   
            run deploy1 --image=gcr.io/google-samples/hello-app:1.0
            --port=8080
        set   
            image deploy gateway *=registry.cn-qingdao.aliyuncs.com/mrs-iot/gateway:1.0

    Basic Commands (Intermediate):
        explain
        get
            -o 
                # 格式
                yaml
                wide
            -l app=a1
            -c gateway
            --show-labels
            --selector app=a1
            --all-containers=true
        edit
            ingress iot-ingress
        delete 
            --force  
            --grace-period=0

    Deploy Commands:
        rollout
        scale
            deployment nginx-deployment
                --replicas=1
        autoscale
            deployment nginx-deployment 
                --min=2 --max=10 --cpu-percent=80

    Cluster Management Commands:
        certificate  
        cluster-info 
        top          
        cordon       
        uncordon     
        drain        
        taint        

    Troubleshooting and Debugging Commands:
        describe     
        logs
            -f
            --since=5m
        attach       
        exec         
            -it device-7b8965d85d-xz4qm bash
            -it device-7b8965d85d-xz4qm --container device -- /bin/bash
        port-forward 
        proxy        
            --port=8080
            http://localhost:8080/api/v1/proxy/namespaces/iot/services/device:http/
                # 访问内部端口
        cp           
        auth         

    Advanced Commands:
        diff      
        apply           # 升级
            -f y1.yml
        patch     
        replace   
        wait      
        convert   
        kustomize 

    Settings Commands:
        label     
        annotate  
        completion

    Other Commands:
        api-resources 
        api-versions  
        config        
            view
            current-context
            set-context $(kubectl config current-context) --namespace=iot
            use-context iot

        plugin        
        version       

    方案
        连阿里云k8s
            kubectl config set-cluster mrs --server=https://106.14.49.217:6443 --certificate-authority=/home/outrun/scripts/work/mrs-k8s/crt --embed-certs=true
            kubectl config set-context 297351062922226746-cdf45d630b2284f8ab79bea186c161d9f --cluster=mrs --user=297351062922226746 --namespace=lora-app
            kubectl config use-context 297351062922226746-cdf45d630b2284f8ab79bea186c161d9f
            kubectl config set-credentials 297351062922226746  --user=297351062922226746 --client-key=/home/outrun/scripts/work/mrs-k8s/297351062922226746.key.pem --client-certificate=/home/outrun/scripts/work/mrs-k8s/297351062922226746.crt --embed-certs=true
        私有仓库
            kubectl delete secret local
            kubectl -n iot create secret docker-registry local1 \
            --docker-server=192.168.99.1:5000 \
            --docker-username=outrun \
            --docker-password=asdf \
            --docker-email=934260428@qq.com
        所有nodeport
            kubectl get svc --all-namespaces -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'


## chrome
    chrome://net-internals/#dns


