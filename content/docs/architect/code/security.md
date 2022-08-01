---
Categories: ["安全"]
title: "Security"
date: 2018-10-11T18:47:57+08:00
---
# 服务器
## 木马
    自变异木马
        改变自身hash或将自身大量复制到不同目录, 后台运行，躲避清理
        自删除
        伪装成系统程序或绑定系统程序
    检查
        可疑进程
        定时任务
        启动项
            /etc/init.d或service --status-all
            systemctl list-unit-files | grep enabled
## 经验
    libudev.so                      # 自变异，/bin/下生成随机名称命令, 启动后可远程执行命令，在/etc/init.d下创建自启动项，在/etc/crontab中添加定时任务
        chmod 0000 /lib/libudev.so && rm -rf /lib/libudev.so && chattr +i /lib/
        /etc/init.d下随机名称文件删除, /etc/rc{0,1,2,3,4,5,6,S}.d中的软链删除
        /etc/crontab/gcc.sh删除
        sed '/gcc.sh/d' /etc/crontab && chmod 0000 /etc/crontab && chattr +i /etc/crontab 删除定时任务
        重启
        chattr -i /lib /etc/crontab 恢复可写
## DDoS
## 防范方法
### 漏洞扫描
    DVWA
        # Damn Vulnerable Web Application，PHP + MySQL模拟Web漏洞
    W3af
        # Web应用扫描, Python实现
    OpenVAS
        # 扫描主机漏洞
### 网络隔离
    内外网分离
    登录跳板机

# Web安全
## XSS
    # 向网页注入代码
## CSRF
    # Cross-Site Request Forgery, 跨站请求伪造
## SQL注入
## Hash Dos
    上传大Json Object, 利用Hash算法的伪随机性，制造Value不同但Hash碰撞的数据，耗尽CPU
## 上传文件脚本
    伪造Content-Type上传静态资源，再URL访问执行
## 防范方法
### 验证码
    根据滑动响应时间、拖拽速度、时间、位置、轨迹、重试次数来评估风险
### 信息存储
    密码非明文保存，加salt
    身份证号、手机号加"*"
    联系方式显示与否用户自己配置
### 加密
    对称加密
        DES             # 56位秘钥，已被AES取代
        3DES            # 做3次DES
        AES             # 128、192、256位秘钥
        Blowfish        # 1到448位变长秘钥
    非对称加密
        RSA             #
        DSA             # 性能快于RSA，只能数字签名
        ECDSA           # 螺旋曲线加密算法
        ECC             # 256位ECC秘钥相当于3072位RSA秘钥
    哈希算法
        MD5             # 不再安全
        SHA-1           # 不再安全
        SHA-256
### 授权、认证
    RBAC、ABAC
    SSO
    OAuth2.0
    OIDC
        # OpenId Connect，OAuth2上构建的身份认证
    SAML
        # Security Assertion Markup Language
        用于SSO，XML格式
        定义了三个角色：委托人、身份提供者(IDP)、服务提供者(SP)。用户SP做访问控制
    2FA
        # Two-factor authentication, 双因素认证

# 代码安全
## Java反序列化漏洞
    用户输入直接反序列化，可利用Apache Commons Collections执行任意代码


# 数据安全
## 数据备份


# 问题定义与排查方法
## 基础
	线上故障等级
		P0 致命问题
		P1 严重问题
		P2 一般问题
		P3 轻微问题
	线上故障分类
		外部依赖类
		运营质量类
		需求质量类
		系统质量类
## 混沌工程
	混沌工程画像
		ApplicationData
			进程Hang、Kill，启动异常，心跳异常，环境错误，包错误或损坏，配置错误、误删、获取超时
		Data
			系统单点，异步阻塞同步，依赖超时，依赖异常，业务线程池满，监控错误，OOM
		Runtime
			负载均衡失效，缓存热点，缓存限流
		Middleware
			数据库热点，数据库宕机，数据同步延迟，数据库主备延迟，数据库连接满，数据库热点
		OS
			CPU抢占，内存抢占，内存错乱，上下文切换
		Virtualization
			服务器宕机、假死，断电，超卖，混部
		Storage
			磁盘满、慢、坏，不可写，不可读
		Networking
			网络抖动、丢包、超时，网卡满，断网
	工具
		ChaosBlade
## Java
	Idea Debugger
## Redis
## MySQL
	Using intersect
		多余查询条件虽然命中索引，但会产生多余的索引查询使SQL变慢，应该使用唯一的单值索引
	force index指定期望的索引
	用count(*)不要count(1)
	use filesort可能会文件排序
## Trace
	Pinpoint记录


# 各开源协议
    GPL
        介绍
            GNU General Public License，GNU发布的通用协议，共3个版本，最新为GPLv3，Linux使用此协议
        特点
            发布的软件使用GPL的软件, 也要GPL
    LGPL
        介绍
            GNU Lesser General Public License，OpenOffice使用此协议
        特点
            类库引用可不开源，有代码修改要使用LGPL开源
    AGPL
        介绍
            Affero General Public License。类似的协议有CPAL、OSL
        特点
            除发布的软件，提供服务的软件，也要AGPL
    BSD
        介绍
            Berkly Software Distribution
        特点
            可以自由修改，修改可再次闭源发布。只需要BSD许可协议文件，但不能使用原作者名义宣传
    MPL
        介绍
            The Mozilla Public License
        特点
            可与其它授权的文件混合使用，新增代码可使用其它方式授权或闭源
            使用MPL的部分，对MPL修改的部分，要MPL
    MIT
        介绍
            近1/3的开源 软件使用。如ssh, JQuery, Putty，XWindow
        特点
            类似BSD，可使用原作者名义推广
    Apache2.0
        介绍
            软件有Android, Apache Web Server, Swift
        特点
            类似BSD，被修改的原始文件要著名版权

