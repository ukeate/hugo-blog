# 趋向
    本地(app) -> 线上(browser)
# 采用
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
        项目
            OmniPlan, ganttProject, microsoftProject
    转换
        文件            # 学术 阅读 实践
            DEVONthink, siteSucker
        文字
            wps, word, pdfElement, LaTeX, iAWriter, 
            代码: cacher[github], lepton[github], dash, snippetsLap, textastic
            shortMenu
        影音
            permute3
            touchRetouch, auroraHDR, lensFlare, reflectStudio, superDenoising, Logoist, polarrPhoto, priimeStyles, tonality, QRFactory
            quickTime, gifox, gif brewery, gif maker, Hype3
            aurora3DMaker
        系统
            istatistica, wifiExplorer
            alfred, divvy, unclutter, workspaces, yoink, xscope, hazeOver, microSnitch
            浏览器: tampermonkey
            FEFileExplorer
    输出
        字
            drafts[iCloud], workflowy[workflowy], 幕布[幕布]
            expressions 
            jetbrains, vim, spacemacs
        图
            表: excel, marginNote[iCloud], xmind[oneDrive], liquidText[iCloud], mindNode, ithoughts, scapple
            结构: visio, wps, ppt, OmniGraffle, plantUML, graphviz
            数学: mathStudio, pocketCAS
            画: procreator
        库
            笔记: oneNote[oneDrive], blog[github], goodnotes
            记录: dayOne
    同步
        synergy, pushbullet
    依赖
        系统: 
            文件: tree, unzip, 7z, diff, du
            系统: ntfs-3g, os-prober, network-manager, wireless-tools, systemctl, service
            包: yaourt, yay, pkgfile, snap
                wps-office, ttf-wps-fonts
            界面: awesome, i3-wm, arandr, xscreensaver, tmux, synergy, ibus, synaptics, pepper-flash, virtualbox
            网络: chromium, firefox, thunderbird
        ops:
            shell: nohup, expect
            系统: sysdig, sysstat包(sar, sadf, mpstat, iostat, pidstat), ifconfig, top, htop, ps, df
            网络: wireshark, netstat, ss, ping, telnet, iptables, wget, git, openssh
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