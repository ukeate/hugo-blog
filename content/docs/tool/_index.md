---
title: 工具
type: docs
---

# 系统
## windows
    # 方案
        附件 -> 系统工具 -> 字符映射表 -> 新宋体 中查看汉字的unicode编码

        远程协助
                端口：3389
            1.系统属性 远程
            2.附件：远程连接
                    # xp:单用户，远程操作时原用户无法操作

        chm 不显示内容
                右键 -> 常规 -> 解锁

    # 命令
        route print
        route delete
        route add 0.0.0.0 mask 0.0.0.0 10.0.2.2
        nstsc   # 运程桌面
    # cmd
        CMD 属性
                cmd /c dir 是执行完dir命令后关闭命令窗口。
                cmd /k dir 是执行完dir命令后不关闭命令窗口。
                cmd /c start dir 会打开一个新窗口后执行dir指令，原窗口会关闭。
                cmd /k start dir 会打开一个新窗口后执行dir指令，原窗口不会关闭。

        语法命令
                | findstr asdf                        # 相当于grep

        CMD命令
                1. gpedit.msc-----组策略
                2. sndrec32-------录音机
                3. Nslookup-------IP地址侦测器
                4. explorer-------打开资源管理器
                5. logoff---------注销命令
                6. tsshutdn-------60秒倒计时关机命令
                7. lusrmgr.msc----本机用户和组
                8. services.msc---本地服务设置
                9. oobe/msoobe /a----检查XP是否激活
                10. notepad--------打开记事本
                11. cleanmgr-------垃圾整理
                12. net start messenger----开始信使服务(或其它服务)
                13. compmgmt.msc---计算机管理
                14. net stop messenger-----停止信使服务(或其它服务)
                15. conf-----------启动netmeeting
                16. dvdplay--------DVD播放器
                17. charmap--------启动字符映射表
                18. diskmgmt.msc---磁盘管理实用程序
                19. calc-----------启动计算器
                20. dfrg.msc-------磁盘碎片整理程序
                21. chkdsk.exe-----Chkdsk磁盘检查
                22. devmgmt.msc--- 设备管理器
                23. regsvr32 /u *.dll----停止dll文件运行
                24. drwtsn32------ 系统医生
                25. rononce -p ----15秒关机
                26. dxdiag---------检查DirectX信息
                27. regedt32-------注册表编辑器
                28. Msconfig.exe---系统配置实用程序
                29. rsop.msc-------组策略结果集
                30. mem.exe--------显示内存使用情况
                31. regedit.exe----注册表
                32. winchat--------XP自带局域网聊天
                33. progman--------程序管理器
                34. winmsd---------系统信息
                35. perfmon.msc----计算机性能监测程序
                2. 36. winver---------检查Windows版本
                37. sfc /scannow-----扫描错误并复原
                38. taskmgr-----任务管理器（2000／xp／2003
                39. winver---------检查Windows版本
                40. wmimgmt.msc----打开windows管理体系结构(WMI)
                41. wupdmgr--------windows更新程序
                42. wscript--------windows脚本宿主设置
                43. write----------写字板
                44. winmsd---------系统信息
                45. wiaacmgr-------扫描仪和照相机向导
                46. winchat--------XP自带局域网聊天
                47. mem.exe--------显示内存使用情况
                48. Msconfig.exe---系统配置实用程序
                49. mplayer2-------简易widnows media player
                50. mspaint--------画图板
                51. mstsc----------远程桌面连接
                52. mplayer2-------媒体播放机
                53. magnify--------放大镜实用程序
                54. mmc------------打开控制台
                55. mobsync--------同步命令
                56. dxdiag---------检查DirectX信息
                57. drwtsn32------ 系统医生
                58. devmgmt.msc--- 设备管理器
                59. dfrg.msc-------磁盘碎片整理程序
                60. diskmgmt.msc---磁盘管理实用程序
                61. dcomcnfg-------打开系统组件服务
                62. ddeshare-------打开DDE共享设置
                63. dvdplay--------DVD播放器
                64. net stop messenger-----停止信使服务
                65. net start messenger----开始信使服务
                66. notepad--------打开记事本
                67. nslookup-------网络管理的工具向导
                68. ntbackup-------系统备份和还原
                69. narrator-------屏幕“讲述人”
                70. ntmsmgr.msc----移动存储管理器
                71. ntmsoprq.msc---移动存储管理员操作请求
                72. netstat -an----(TC)命令检查接口
                73. syncapp--------创建一个公文包
                74. sysedit--------系统配置编辑器
                75. sigverif-------文件签名验证程序
                76. sndrec32-------录音机
                77. shrpubw--------创建共享文件夹
                78. secpol.msc-----本地安全策略
                79. syskey---------系统加密，一旦加密就不能解开，保护windows xp系统的双重密码
                80. services.msc---本地服务设置
                81. Sndvol32-------音量控制程序
                82. sfc.exe--------系统文件检查器
                83. sfc /scannow---windows文件保护
                84. tsshutdn-------60秒倒计时关机命令
                3. 84. tsshutdn-------60秒倒计时关机命令
                85. tourstart------xp简介（安装完成后出现的漫游xp程序）
                86. taskmgr--------任务管理器
                87. eventvwr-------事件查看器
                88. eudcedit-------造字程序
                89. explorer-------打开资源管理器
                90. packager-------对象包装程序
                91. perfmon.msc----计算机性能监测程序
                92. progman--------程序管理器
                93. regedit.exe----注册表
                94. rsop.msc-------组策略结果集
                95. regedt32-------注册表编辑器
                96. rononce -p ----15秒关机
                97. regsvr32 /u *.dll----停止dll文件运行
                98. regsvr32 /u zipfldr.dll------取消ZIP支持
                99. cmd.exe--------CMD命令提示符
                100. chkdsk.exe-----Chkdsk磁盘检查
                101. certmgr.msc----证书管理实用程序
                102. calc-----------启动计算器
                103. charmap--------启动字符映射表
                104. cliconfg-------SQL SERVER 客户端网络实用程序
                105. Clipbrd--------剪贴板查看器
                106. conf-----------启动netmeeting
                107. compmgmt.msc---计算机管理
                108. cleanmgr-------垃圾整理
                109. ciadv.msc------索引服务程序
                110. osk------------打开屏幕键盘
                111. odbcad32-------ODBC数据源管理器
                112. oobe/msoobe /a----检查XP是否激活
                113. lusrmgr.msc----本机用户和组
                114. logoff---------注销命令
                115. iexpress-------木马捆绑工具，系统自带
                116. Nslookup-------IP地址侦测器
                117. fsmgmt.msc-----共享文件夹管理器
                118. utilman--------辅助工具管理器
                119. gpedit.msc-----组策略
                120. explorer-------打开资源管理器
                其它
                        arp -a                # 显示当前局域网ip与物理地址
                        net view        # 显示局域网用户
                        nbtstat                # 详细局域网用户
                        sfc /scannow                # windows 文件检查器（修复系统）
                        shutdonw                        # 关机等一系列指令
    # 注册表
        使用UTC时间(兼容linux)
                cmd> Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
    # 工具
        端口映射器
                远程vpn代理到ssh
        everything
                文件快速搜索工具
                远程访问电脑文件的服务器
        花生壳
                动态域名软件，已申请域名，ip经常变换时使用
        xmanager
                ssh工具
        端口映射
                portmap
        xshell
        secureCRT
        Xmanager                # 可运行图形界面如vnc
        teamViewer                # 可图形界面
        cmder          # windows命令行工具

# 网络
## teamviewer
    # 远程桌面
## wireshark
    # 抓包
## charlet
    # 抓包
## chrome
    介绍
        webkit: chrome firefox safari的内核，来源于kde的khtml与kjs
    快捷键
        ctrl + f5 无缓存刷新
        f12 调试模式
    调试模式
        js调试
            sources-> js文件打断点调试
                    # “{}”按钮是格式化代码，右边按钮单步调试，依次为执行， 跳过进入方法，进入方法，跳出方法，开启／停止调试，暂停
            //# sourceURL=base.js
        console
            可以查看js常量，如THREE.VERSION
    设置页
        about:about                                 # 进入查看所有设置页
        chrome:extensions
        chrome:flags                                # 可以开启硬件加速解码
    集成抓包工具
        chrome://net-internals/#events
    插件
        ARC Welder  # android模拟器
## firefox
    代理设置
        “编辑”→“首选项”→“高级”→“网络”→“设置”→“手动配置代理”
    mozvr
        介绍
            mozilla vr 虚拟现实
            购买Oculus Rift头盔来看它的网页


# 数据分析
## paraview
    # 数据可视化
## finreport
    # 数据可视化
# 设计
## sketch
    # mac下轻量ui设计工具
## rose
        # ibm uml工具

# 开发
## vim
## intellij idea
    注意
        Project 相当于workspace, module 相当于工程
    注册
        服务器
            # 发布网站 http://idea.lanyus.com
            http://idea.qinxi1992.cn
            http://idea.lianghongbo.com/licens
            http://im.js.cn:8888
    javaagent
        https://zhile.io/

    快捷键
        alt + enter     # 改错
        shift shift     # 搜索跳转

    编码
        file -> settings -> appearence里use custom font设置中文字体
        file -> settings -> editor -> file encodings 三处utf-8
        idea安装目录/bin/idea.vmoptions和idea64.vmoptions,最后添加
            -Dfile.encoding=UTF-8
        .idea/encodings.xml里删除除了UTF-8的项

## webstorm
## pycharm
## goland
## clion
## phpCharm
## sublime
    功能
        显示风格好
        缩略图
        热加载(不改变原文件)
        插件
        多文件夹查找
        多视窗
        命令模糊搜索下拉菜单
        柜形选择
        V8插件，js运行控制台
        js校验
        vi 操作设置
        修改配色方案
    快捷键
        批量修改
## idle
    # python tkinter开发的python ide
## lighttable
    # clojure
## hbuilder
        # h5
## komodo edit
    # 免费跨平台，多pl
## vscode
## source insight
## gerrit
        # 查看代码

# 客户端
## datastudio
        # ibm数据库连接工具
## plsql
## oracle sql developer
## navicat
        # ios的数据库操作gui
## robo3t
    # 原robomongo, 免费
## studio3t
    # mongodb, 收费


