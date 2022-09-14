---
Categories: ["运维"]
title: "Kubernetes"
date: 2018-10-11T18:18:21+08:00
---

# 常用
## 查看
    系统日志
        journalctl -u kubelet | tail
        kubectl api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -nmdw
    日志
        kubectl logs -f --since=5m --all-containers=true -lapp=[svcName] -o wide
        kubectl get pod [podName] -o yaml
        kubectl get pods --namespace=mdw-log -l app=logstash-logstash -w    # 等待启动
        kubectl describe pods [podName]
        kubectl rollout status deploy/[deployName]          # 查升级记录
    节点详情
        kubectl get nodes -o json
    查状态
        kubectl rollout status deploy/[deployName]
    进容器
        kubectl exec -it [podName]  -- /bin/bash
    用busybox运行命令
        kubectl run -it --image busybox -n [nameSpace] [name] --restart=Never --rm
    查询所有nodeport
        kubectl get svc --all-namespaces -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}'
    查询node上跑pod个数
        kubectl get po --all-namespaces -o wide | grep cn-shanghai.i-uf6iudwa5b1tvdxb3yy8 |  wc -l 
## 监控
    kubectl top node -l app=app1
    kubectl top pod -nmdw --containers
    kubectl describe PodMetrics p1 -njnc-dev
## 编辑
    kubectl apply -f a.yml
    envsubst < jnc.yml |kubectl apply -f -
    kubectl label ns jnc istio-injection=enabled --overwrite
    kubectl label ns jnc istio-injection-
## 亲和性
    kubectl get nodes --show-labels
    kubectl label nodes node1 deploy=mdw
    kubectl taint nodes node1 key=value:NoSchedule                      # NoSchedule、PreferNoSchedule、NoExecute
## 调试
    kubectl proxy --port=8080 &
        # 以非https形式暴露api
    kubectl debug a1 -it --image=yauritux/busybox-curl --share-processes --copy-to=a1-debug
        # 嫁接
    kubectl run -it --rm test --image=a:0.1.0 --command -- /bin/bash
        # 改镜像命令
    kubectl run -it --rm  busybox1 --image=yauritux/busybox-curl -- /bin/bash
        # 同环境busybox
## 清理
    删除Evicted pod
        kubectl get po -njnc-dev | grep Evicted |awk '{print$1}'|xargs kubectl delete pod -njnc-dev
    强制删除pod
        kubectl delete po -nmdw --force --grace-period=0
    删除pv
        kubectl patch pv mdw-mysql-data -p '{"metadata":{"finalizers":null}}'
## 操作
    升级镜像
        kubectl set image deploy/[deployName] [imageName]=[imageName:Version]
        kubectl edit deploy/[deployName]
    扩容
        kubectl scale deployment [deployName] --replicas=3
        kubectl patch deployment [deployName] -p '{"spec":{"replicas":3}}'
    重启
        kubectl rollout restart deploy xxx
    回滚
        kubectl rollout undo deploy xxx
    打污点
        kubectl taint nodes node1 key1=a:NoExecute
            # 添加
        kubectl taint nodes --all key1-
            # 删除
    打标签
        kubectl label nodes node1 a=b
## 容器配置
    部署.docker/config.json成secret
        kubectl create secret generic regcred --from-file=.dockerconfigjson=<path/to/.docker/config.json> --type=kubernetes.io/dockerconfigjson
    配置私有仓库
        kubectl delete secret local
        kubectl -n iot create secret docker-registry local1 \
        --docker-server=192.168.99.1:5000 \
        --docker-username=outrun \
        --docker-password=asdf \
        --docker-email=934260428@qq.com
    连阿里云k8s
        kubectl config set-cluster mrs --server=https://106.14.49.217:6443 --certificate-authority=/home/outrun/scripts/work/mrs-k8s/crt --embed-certs=true
        kubectl config set-context 297351062922226746-cdf45d630b2284f8ab79bea186c161d9f --cluster=mrs --user=297351062922226746 --namespace=lora-app
        kubectl config use-context 297351062922226746-cdf45d630b2284f8ab79bea186c161d9f
        kubectl config set-credentials 297351062922226746  --user=297351062922226746 --client-key=/home/outrun/scripts/work/mrs-k8s/297351062922226746.key.pem --client-certificate=/home/outrun/scripts/work/mrs-k8s/297351062922226746.crt --embed-certs=true
## 集群配置
    设置当前集群namespace
        kubectl config set-context $(kubectl config current-context) --namespace=default
    配置DNS解析
        kubectl edit configmap coredns -n kube-system
            apiVersion: v1
            data:
            Corefile: |
                .:53 {
                    errors
                    hosts {
                        192.168.1.107 a.b.com
                    }
                }
        kubectl rollout restart deploy coredns -n kube-system



# 文件目录
    /etc/kubernetes
    /etc/resolve.conf
# 命令
## kubeadm
    kubeadm init
## kubectl
    全局参数
        --help                  # -h
        --output="jsonpath={.data.\.dockerconfigjson}"
        --output=yaml
        --context=iot
        --namespace=iot 
        --all-namespaces=true
        -n [namespace] 
        --all                           # 如匹配所有deploy文件
    Other Commands
        api-resources           # 查所有resource
            namespace/ns
            endpoints/ep
            nodes/no
            configmap/cm  
            replicationcontrollers/rc
            deployments/deploy
            statefulsets/sts
            service/svc 
            ingresses/ing
            persistentvolumes/pv
            persistentvolumeclaims/pvc
            storageclasses/sc
            pods/po
            cronjobs/cj
            daemonset/ds                    # 每个node运行一个
            certificatesigningrequests/csr  # csr证书
        api-versions            # 所有可用的apiVersion
        config                  # 设置集群
            config set current-context c1
        plugin                  # 设置插件
        version
    Basic Commands:
        create
            -f y1.yml
        expose                          # 修改端口
            expose deployment/[deployName]
            --target-port=8080 
            --type=NodePort
        run   
            run [deployName] 
            --image=gcr.io/google-samples/hello-app:1.0
            --port=8080
        set                             # 更新配置
            set image deploy/[deployName] *=image1:1.1
                # 所有镜像更新为image1:1.1
        explain                         # 查resource文档
            pv
        get
            -o                          # 格式
                yaml
                wide
                jsonpath='{.items[0].metadata.name}'
            -l app=a1                   # select label
            -c gateway
            --show-labels
            --selector app=a1
            --all-containers=true
        edit                            # 修改配置
            edit ingress ingress1
        delete 
            --force  
            --grace-period=0
    Deploy Commands:
        rollout
            history deploy/deploy1
            pause deploy/deploy1
            restart
            resume deploy/deploy1
            status 
            undo deploy/deploy1         # 回滚到上一版本
        scale
            scale deploy/deploy1
                --replicas=1
        autoscale
            autoscale deploy/deploy1
                --min=1
                --max=3
                --cpu-percent=80
    Cluster Management Commands:
        certificate
            approve [csrName]           # 手动签发证书，/etc/kubernetes/ssl/*
            deny
        cluster-info                    # 集群信息 
            dump
        top                             # cpu 内存负载
            node
            pod
        cordon [nodeName]               # node不可调度
        uncordon                        # node可调度
        drain [nodeName]                # 移除node
        taint                           # node污点
            taint nodes node1 key1=val1:NoSchedule
    Troubleshooting and Debugging Commands:
        describe     
        logs
        attach                          # 当前终端成为entrypoint
        exec         
            -it device-7b8965d85d-xz4qm bash
            -it device-7b8965d85d-xz4qm --container device -- /bin/bash
        port-forward                    # 端口映射
            port-forward [podName] 本地端口:pod端口
        proxy                           # 映射ApiServer到本地端口
            --port=8080
        cp                              # copy容器文件
            cp [namespaceName]/[podName]:[filePath] .
        auth         
            can-i list pods             # judge权限
            reconcile -f rbac.yaml      # 应用权限配置
                --dry-run               # 仅测试，列出变更
                --remove-extra-subjects         # 删除除外subject
                --remove-extra-permissions      # 删除除外权限
        debug                           # pod调试模式, alpha版功能，需要--feature-gates="EphemeralContainers=true"
            -it pod1 
            --image=image1              # 排错工具镜像
            --share-processes           # 共享进程
            --copy-to=pod1-debug
    Advanced Commands:
        diff      
            diff -f a.yml               # dry run 找出将实行的变更
        apply           # 升级
            -f y1.yml
            -k overlays/
        patch                           # 更新属性
            patch deploy/deploy1
            -p '{"spec":{"unschedulable":true}}'
        replace                         # 替换resource
            replace -f a.yml
        wait                            # 等待直到满足条件
            -f a.yml
            --for=condition=Available
            --timeout=1h
        kustomize                       # 多环境部署的overlays补丁
            kustomize [dir with kustomization.yml]
    Settings Commands:
        label
            label pods/pod1 a=b
            --overwrite                 # 覆盖更新
            --resource-version=1        # 匹配没修改过的情况
        annotate
            annotate pods/pod1 a='b'
            --overwrite
        completion                      # 生成终端命令补全配置
            completion bash > /etc/bash_completion.d/kubectl
# Helm
    目录
        charts/
        Chart.yaml
            apiVersion: v1
            appVersion: "1.0"
            description: A Helm chart for Kubernetes
            name: nginx-test
            version: 0.1.0
        requirements.yaml
        requirements.lock
        values.yaml
            replicaCount: 1
        templates/
            _helpers.tpl
            deployment.yaml
        
    helm命令
        查看
            ls/list
                --all-namespaces
            get values a1                   # 查看已部署的values变更
            history  a1                     # 查看历史版本
            get manifest a1                 # 查看已安装模板
            template                        # 查看编译后内容
                --debug
            search repo a1 
                --versions
        安装
            repo
                update
            install [deployName] [packageName|packageFile|packagePath] 
                -f values.yaml
                --values=values.yaml
                --set a=b
            upgrade                         # 热更新部署文件
                --debug --dry-run           # 只输出编译结果
                -i                          # 没有时执行install
                --disable-openapi-validation
            uninstall
        插件
            plugin
                install --version master https://gitee.com/mirrors_sonatype-nexus-community/helm-nexus-push.git
                ls
        运维
            rollback a1 1                   # 回滚到1版本
        打包
            create a1
            lint --strict a1                # 校验
            package a1                      # 打包成a1-0.1.0.tgz

    相关命令
        


# minikube
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

# 平台
    HPE Container Platform
    OpenShift
    VMware VSphere
    Minikube
    Rancher
    KubeSphere
    Google Cloud Platform(GCP)