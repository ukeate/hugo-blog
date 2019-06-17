---
Categories: ["运维"]
title: "Svn"
date: 2018-10-11T18:22:50+08:00
---

# svn
    linux下移植的版本控制器
    默认端口: 3690
# 目录结构
    conf:配置文件
    db:数据库
    hooks:勾子（自定义功能）
    locks:文件锁
# 命令
## 服务器
    svn --version
    svnadmin create c:\svn        # 创建仓库
                                        ## hooks勾子 locks锁 conf db
    svnserve -h
    svnserve -d -r c:\svn      # 启动服务(-d是后台运行，windows不支持，需要创建服务)
                                            ## --listen-port 3691 指定监听端口
    windows 下注册服务
                    sc create 服务名 binPath= "d:/suversion/bin/svnserve --service -r c:\svn" displayName= "显示名"
                        # 注意双引号前面要有空格
                    sc delete 服务名

    使用多个仓库
            svnadmin create d:\svn2 创建仓库以后
            svnserve -d -r d:\svn2 --listen-port 3691        配置用另一个服务端口启动该仓库        # svn默认启动端口是3690
            svn://192.168.10.3:3691        来访问该仓库
### 客户端
    添加项目
            svn add test/
            svn ci -m "first"                # svn commit -m "fisrt"
                                            ## ci是checkin
    检出
            svn checkout svn://192.168.0.2/framework
    显示所有分支(目录)
            svn ls svn://192.168.0.2/fr --verbose
    创建分支
            svn copy svn://192.168.0.2/repo/trunk/ svn://192.168.0.2/repo/branches/try-sth -m 'make branch try-sth'
                    # 注意trunk后面要有/
    更换本地分支
            svn switch svn://192.168.0.2/repo/branches/try-sth
# 配置
    conf/svnserve.conf
            anon-access = read                # 匿名用户权限
            auth-access = write                # 登录用户权限
                                    # write权限包括read权限
                                    ＃ none没有验证无权限(匿名权限)
            password-db = passwd        # 加载conf/passwd文件（中的用户帐户）
            authz-db = authz                        ＃开启权限控制
                    同目录authz文件中配置权限
                    [/]                               # 对根目录设置权限
                    * = r                            # 所有人都可读
                    outrun = rw                # 配置所有版本库只读，outrun可读可写
                    @admin = rw                # @组名    对组进行引用
            realm = aa
                                    # 认证域名称, 本svn路径为 svn://192.168.0.2/aa
    conf/authz
            
    conf/passwd
            [groups]
                    admin = outrun
    例子
        authz
                [groups]
                admin = a1, a2
                [/]
                @admin = rw
                a3 = rw
                * = r
        passwd
                [users]
                a1 = 123
                a2 = 123
                a3 = 123
        svnserve.conf
                [general]
                anon-access = none
                auth-access = write
                password-db = passwd
                authz-db = authz
                realm = trunk
                force-username-case = none
# 工具
    tortoiseSVN
        下载
                    右键 svn checkout 选择版本 下载 (show log 查看日志) 

            上传
                    第一次提交 右键 tor.../import
                    svn://192.168.10.188     # 输入用户名、密码登录
                    第二次提交 右键 commit
            还原
                    右键 tor.../Revert 还原其中的文件
            多人
                    右键 svn update ,更新另一个人提交的文件内容
            新建文件的提交    
                    tor../add 或 commit的时候选择该文件
                    tor./Repo-browser，浏览仓库
            加锁文件    # 只有自己在不提交更改的前提下才可以解锁
            tor../get lock      # 不会改变版本
                    tor../release lock  # 解锁,但是新下载的工程不可以再解锁，如果删除原工程则无法解锁
            冲突
                    当前版本已经有人修改后commit的话提示版本已经过时
                    update:下载所有版本，右键 tor../edit conflicts -> mark as resolved确定解决
                    # 避免冲突：减少公共修改时间，重写前更新
            使用经验
                    TortoiseSVN -> Setting -> Saved Data 可以清空自动登录

    svn的myeclipse插件：
                    # eclipse6中不能用，eclipse7每次报错，能用，eclipse8报错一次，能用 eclipse10不报错
            1.复制插件文件夹features与plugins到/myeclipse 10/dropins/文件夹中
            2.创建目录/myeclipse 10/my_plugin/svn/
                            复制插件文件夹features与plugins到/myeclipse 10/my_plugin/svn/文件夹中
                            /myeclipse 10/dropins/添加svn.link文件 ，内容为:path=my_plugin\\svn                # 这里写相对路径
            3.使用：重启myeclipse,弹出确认窗口（也可以从window -> show view中找到svn的视图）
                    项目：右键->share project 上传项目到svn(bug 第一次只上传空文件夹,再右键Team/提交 时上传项目文件)
                            再右键就可以对该项目进行一系列的操作了
                    导入项目：file -> import -> svn

    rapidsvn
            