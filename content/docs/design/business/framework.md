
# 博客框架
## cleaver
    # 基于node幻灯片
## hexo
    介绍
        简单轻量，基于node的静态博客框架
        可以部署在自己node服务器上，也可以部署在github上
    目录结构
        scaffolds                                        # 脚手架
        scripts                                            # 写文件的js, 扩展hexo功能
        source                                            # 存放博客正文内容
                _drafts                                    # 草稿箱
                _posts                                        # 文件箱
        themes                                            # 皮肤
        _config.yml                                        # 全局配置文件
        db.json                                            # 静态常量
    使用
        npm install -g hexo
        hexo version
        hexo init nodejs-hexo
        cd nodejs-hexo && hexo server
        hexo new 新博客                            # 产生 source/_posts/新博客.md
        hexo server                                        # 启动server
        hexo generate                                    # 静态化处理
        github中创建一个项目nodejs-hexo, 在_config.yml中找到deploy部分，设置github项目地址
        hexo deploy
                # 部署以后，分支是gh-pages, 这是github为web项目特别设置的分支
        上github，点settings找到github pages, 找到自己发布的站点
        无法访问静态资源
                设置域名
                        申请域名
                        dnspod 中 绑定ip
## hugo
    简介

        hugo由go编写，开源，特点为编译快
        本文基于hugo0.49

    help
        hugo help
        hugo help server    # server代表任何子命令

     生成站点
        hugo new site blog1 # 站点命令在blog1中执行

     生成文章
        hugo new about.md
        hugo new post/first.md

     主题
        git clone https://github.com/spf13/hyde.git themes/hyde # 更多主题在https://themes.gohugo.io


     本地服务器
        hugo server
            # 自带watch
            -s /path/to/codes
            --theme=hyde
            --buildDrafts
            -p 1315
                # 默认端口1313

     发布
        hugo --theme=hyde --baseUrl="https://outrunJ.github.io"

     文章
        开头
            ---
            用YAML写内容
            --- # +++标记可写TOML

            Description = ""
            Categories = ["a1", "a2"]
            Tags = ["b1","b2"]
            draft = true    # 文章隐藏
            menu = ""
            title = "a" # 文章标题

     配置
        打开config.toml   # 可以是config.yaml、config.json
        baseURL = ""
        title = ""
        theme = ""
        [permalinks]
            post = "/:year/:month/:title/"  # 生成list页面

        [taxonomies]
            category = "categories"
            tag = "tags"

        [params]
            description = ""
            author = ""

        ignoreFiles = []

        [blackfriday]   # 设置markdown库

## jekyll
    介绍
        ruby静态站点生成器，根据网页源码生成静态文档文件
        提供模板、变量、插件等功能
        生成的站点可以直接发布到github上
    使用
        curl http://curl.haxx.se/ca/cacert.pem -o cacert.pem
            # 移动到ruby安装目录
        安装devkit
        gem install jekyll
        git clone https://github.com/plusjade/jekyll-bootstrap.git jekyll
            # 下载jekyll-bootstrap模版
        cd jekyll && jekyll serve
        rake post title = 'Hello'
            # 生成文章
            ## 编辑_posts下面生成的文章
        修改convertible.rb文件编码为utf-8
        jekyll serve
        发布到github
            github上创建新仓库
            git remote set-url origin git@新仓库
            git add .
            git commit -m 'new'
            git push origin master
            git branch gh-pages
                # 新建一个分支，用于发布项目
            git checkout gh-pages
            修改_config.yml
                production_url: http://outrun.github.io
                BASE_PATH: /jekyll-demo
# 在线服务
## webIDE
    codebox
# 游戏
    框架
        pomelo
            # node.js上网易开源的实时性好的游戏类服务器
    架构
        MySQL
            user_id_list
            club_id_list
        Redis
        Netty
            ProxyServer     # 交互客户端, 监听Redis Channel拿到BizServer列表， 代理请求到多个BizServer
                channelHandlerList
                    Encoder
                    Decoder
                    内容长度限制
                    WebSocket处理
                    msgHandler
                    客户端连接时动态添加handler
                msg带类型，区分handler, 据msg类型转发到bizServer
                每个用户存routerTable
            BizServer       
        Go + Protobuf + WebSocket
        Cocos Creator/白鹭/LayaBox
        Unity(C#)
# 三方服务
## web
    aws
    阿里云
    青云
    轻云
    digital ocean
    vultr
    Linode
    azure
        # 微软开放平台
    gce
        # google compute engine
    txCloud
        # 云柜，数据存储和计算
    首都在线
## paas
    gae
        # google app engine
    sae
        # sina app engine
    heroku
## dns
    godaddy
    万网
    dnspod
## cdn
    七牛
## pay
    支付宝
    易宝
    财付通
## idc
    # infomation data corporation, 互联网数据中心
## cti
    天润
    云之讯
    容联
## 报表/olap
    palo
## im
    环信
    云片
    jpush
    im
    sms.webchinese.cn
    个推
## safe
    1password
## 设备
    京东叮咚
        # 智能音箱
    萤石
        # 视频设备