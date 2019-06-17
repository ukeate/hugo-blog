---
Categories : ["架构"]
title: "iscsi"
date: 2018-10-11T15:31:36+08:00
---

# 存储的概念和术语
        scsi: 小型计算机系统接口(Small Computer System Interface)
        fc: 光纤通道(Fibre channel)
        das: 直连式存储(Direct-Attached Storage)
        nas: 网络接入存储(Network-Attached Storage)
        san: 存储区域网络(Storage Area Network)
                连接设备: 路由,  光纤交换机, 集线器(hub)
                接口: scsi fc
                通信协议: ip scsi

        iscsi: internet scsi
                优点
                        可以网络传输
                        服务器数量无限
                        在线扩容．动态部署
                架构
                        控制器架构: 专用数据传输芯片．专用RAID数据校验芯片．专用高性能cache缓存和专用嵌入式系统平台
                        iscsi连接桥架构: 
                                前端协议转换设备(硬件)
                                后端存储(scsi磁盘阵列．fc存储设备)
                        pc架构
                                存储设备搭建在pc服务器上，通过软件管理成iscsi, 通过网卡传输数据
                                实现
                                        以太网卡 + initiator软件
                                        toe网卡 + initiator软件
                                        iscsi HBA卡
                iscsi系统组成
                        iscsi initiator 或　iscsi hba
                        iscsi target
                        以太网交换机
                        一台或多台服务器

