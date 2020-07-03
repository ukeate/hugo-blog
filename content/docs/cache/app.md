---
title: App
type: docs
---
# 趋向
    本地(app) -> 线上(browser)
# 采用
## 工具
    sidecar
        信息: oneNote[oneDrive]
        记录: todo, dayOne, 支付宝, moneyPro, 
    输入
        新
            搜索: DEVONagent, wolframAlpha
            渠道: pages, 知网, 博客, 知乎, 慕课, 网易公开课, 微信/qq, outlook
            发散: 百度指数, DEVONSphere
            盘: icloud, oneDrive x 2, 坚果云, 百度网盘 
            休闲: noizio, relaxMelodiesSeasions, earth3D
        会议
            notability[iCloud]
        GTD
            trello, microsoftToDo, things3
    转换
        文件
            DEVONthink, siteSucker
        字
            字: wps-word, word, pdfElement, LaTeX, iAWriter, 
            代码: cacher[github], lepton[github], dash, snippetsLap, textastic
            misc: shortMenu
        图
            marginNote[iCloud], liquidText[iCloud]
        影音
            音频: permute3
            图片: touchRetouch, auroraHDR, lensFlare, reflectStudio, superDenoising, Logoist, polarrPhoto, priimeStyles, tonality, QRFactory
            视频: quickTime, gifox, gif brewery, gif maker, Hype3
            3d: aurora3DMaker
        修补
            设备同步: synergy, pushbullet, sharemouse
            人机: alfred, divvy, unclutter, workspaces, yoink, xscope, hazeOver, microSnitch
            监视: istatistica, wifiExplorer
            文件: FEFileExplorer
            浏览器: tampermonkey
    输出
        字
            大纲: drafts[iCloud], workflowy[workflowy], 幕布[幕布]
            代码: jetbrains, vim, spacemacs
            表达式: expressions 
        图
            架构: visio, wps-ppt, ppt, OmniGraffle, 
            建模: plantUML, graphviz, 
            甘特图: OmniPlan, ganttProject, microsoftProject
            表: excel, xmind[oneDrive], mindNode, ithoughts, scapple
            数学: mathStudio, pocketCAS
            画: procreator
        库 
            结构: blog[github]
            书: goodnotes
## 依赖
    系统: 
        文件: tree, unrar, unzip, 7z, diff, du
        系统: ntfs-3g, os-prober, network-manager, wireless-tools, systemctl, service
        包: yaourt, yay, pkgfile, snap
            wps-office, ttf-wps-fonts
        界面: awesome, i3-wm, arandr, xscreensaver, tmux, synergy, ibus, synaptics, pepper-flash, virtualbox
        网络: chromium, firefox, thunderbird
    ops:
        shell: ^z, bg, fg, jobs, nohup, expect, 
        系统: sysdig, sysstat包(sar, sadf, mpstat, iostat, pidstat), ifconfig, top, htop, ps, df
        网络: wireshark, netstat, ss, ping, telnet, iptables, wget, git, openssh, nc, nmap, nslookup
        vpn: openvpn, shadowsocks, polipo, v2ray
        vm: docker, docker-compose
            db: mysql, mariadb, postgresql, redis, mongodb, cassandra, neo4j
                elasticsearch, elasticsearch-head, elasticsearch-analysis-hanlp, elasticsearch-ik, elasticsearch-pinyin
            mq: nsq, rabbitmq,  kafka,
            容器: nginx, nginx-php
            监控: zipkin, 
            应用: dokuwiki, tiddlywiki, wordpress, 
        服务: vsftpd, filezilla
        分布式: ansible
    程序:
        基本: make, cmake, g++, gcc, lua, ruby,
        java: openjdk8, jdk8, jdk12, maven, tomcat
        go: go1.9.3, go1.12.6, go1.13.5, probobuf, protoc
        python: python2.7, python3.8, pip2, pip3
        php: php-cgi, php-fpm
        js: node, mvn, babel-cli
        分析: flame-graph
    媒体: dia, convert, import, alsamixer, mplayer
    ide: vscode, sublime, emacs, vim 
        jetbrains: webstorm, goland, intellijIdea, phpstorm, pycharm, mps, android studio
        eclipse: eclipse-inst, eclipse-birt, eclipse-jee-neon
    数据库: datagrip, neoclipse, robo3t, studio-3t
    测试: postman
    工作: snapcast, mosquitto, sox, snapcastrd, websockify
### vim(简)
    命令
        vim
            --version   # 查看插件
    可视模式
        o   # 切换头尾
        gv  # 重选上次
        <C - v> 
        U/u # 转换大写/小写
    替换模式
        R
    思想
        {operator}{motion}
        {operator}{text-objects}
    operator
        ;
        ,
        3G
        */#
        %   # 括号
        ``  # 跳回
        ''  # 跳回非空白
        :marks
        ma/`a   # 标记跳转
        &   # 重复substitute
        cc/C    # 替换一行
        J   # 删除向下的空行 
        g~  # 转换大小写
            # g~~ 转换一行
    motion
        ^/$/0/<home>/g_/h/l/j/k/w/W/e/E/b/B/ge/gE/gg/G/[[/]]/(/)/{/}/nH/M/nL/点鼠标
        f/F/t/T
        .
        K   # man查询
        ga  # unicode码
        nzz/nz-
    q:  # 命令历史
    命令模式
        :3   # 跳转
        :'<,'>   # 选中内容
        :/<html>/,/<\html>/  # 模式匹配范围
        :h e    # e的帮助
        :%s///g  # substitute
        :! command     # 执行shell命令
                      # !! 执行前一命令
                      # r!command 结果插入当前
            # sh 打开sh
            # pwd
            # grep t *  当前文件匹配t
            # ls
        :normal  A;  # 普通模式下执行A,后写入分号
    shortcut key
        <C - d>/u   # 滚半屏
        <C - f>/b   # 滚一屏
        <C - i>/o   # 下个/上个跳动位置
        <C X>   # 当前单词大小写转换
    text-object
        i"  # 中间内容
            # ' ` ( ) [ ] < > { }
            # B 表示{}, t 表示 tag之间内容, w 表示word, s 表示句子, p 表示段落
        a"  # 包括外围
    registers
        :reg    # 查看所有
        :y a    # 复制到a寄存器
        分类
            ""  # 最后一次操作
            "0  # 最近一次复制, 排到9
            "-  # 行内删除
            "a  # a - z, A - Z
            "=  # 只读，用于执行表达式命令
            "*  # clipboard，针对选中部分(selection)
            "+  # clipboard, windows下与*同，linux X11下针对复制或剪切部分(cut buffer)
            "_  # black hole
            "/  # 最近的搜索模式
    宏
        qaq
        @a
    折叠
        # ide支持不好
    对比
        vim -d file1 file2
            [c  # 上一个不同
            ]c  # 下一个不同
            dp  # 合并增加另一个
            do  # 合并增加当前
    文件
        # ide支持不好
        <C - w> hljk
        <C - w> w
        <C - w> s
        <C - w> v
# intellij(简)
    shift shift     # 打开文件
    alt enter       # 补全, 快速修复
# alfred
    搜索
        指定网站搜索
        文件
    剪贴板
    计算器
    自定义脚本
        打字
        命令
        工作流
# fantastical
    个人总结
        名字 date 9th from 9.30p to 10.32p alert 30min
    对象
        Account - Calendar Sets - Cals(Subscription+Interesting) + Item(Events + Tasks)
    nlp
        语法
            事件 [with 人物] [at 地点] [at 日期时间] [on 日期] [from 日期时间] [to 日期时间] [of every 日期时间] 提醒 URL 日历
        日期
            特定
                日期
                    11月1日     11/1    11.1
                星期
                    周一        mon/tue/wed/tur/fri/sat/sun
            相对
                日期
                    15天后      after 15 days
                星期
                    下周一      next mon
            重复
                日期
                    每月2号     every 2
                星期
                    每周二      every tue
                    每隔两周的周三      on wed every 2 weeks
                复合
                    7月1日到8月1日之间的每个周一周二        on mons tues from 7/1 to 8/1
            区间
                12月17日到次年1月3日是寒假      寒假 12/17-1/3      12/17~1/3
        时间
            24小时制
                13
            12小时制
                下午一点        1p  1pm
            分钟
                下午一点半      13:30   1.30p
            默认
                早上8点         morning
                中午12点        noon
                下午5点         evening
                晚上8点         night
                半夜12点        midnight
            区间
                下午1点32到晚上7点47        1.32-7.47   1.32~7.47
        提醒
            提前2小时提醒       alert 2 hours
            提前5分钟提醒       alert 5 min
        URL
            在合适位置的url
        日历
            /Work       /w
            四个空格
        待办事项(reminder)
            开启
                todo、task、Remind、Remind me to开头
            独有语义
                11月27日晚上8点截止     due 11/27 8p        until 11/27 8p      by Thursday
                低 中 高        ! !! !!!
    快捷键
        新建                command + n
        切换日程/待办事项   command + k
        保存                command + s
        删除                command + d

        搜索                command + f
        详情                command + i
        显示事项            command + r
        定位到今天          command + t
        设置                command + ,
        切换全屏视图        command + shift + f

    操作
        新建页面滑动隐藏
        长按日期新建
        长按Item
            移动到Calendar
            颜色

            复制/重建/剪切/删除
            建模板
            隐藏

            邮件触发事件
        横划删除