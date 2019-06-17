---
Categories : ["前端"]
title: "Fis"
date: 2018-10-11T09:32:59+08:00
---
# 介绍
        npm的形式发布
        百度前端工具框架，为前端开发提供底层架构
        所有js文件都用模块书写，一个文件一个模块
                F.module(name, function(require, exports){}, deps);
        
# 安装
        npm install -g fis
# 命令
    fis install                        # 安装模块
    fis release                        # 编译和发布, -h 查看帮助
                            ## 默认会调整资源引用的相对路径到绝对路径
                            ### 不想对路径做调整，可以使用spt工具https://github.com/fouber/spt
                            ## --optimize 或 -o 压缩。--md5对不同静态资源生成版本，也可以配置时间戳
                            ## --dest 或 -d。指定项目发布配置，在执行编译后发布。可以远程发布、发布多个
                            ## --pack 开启打包处理
                            ## -omp 简化 --optimize --md5 --pack
                            ## --watch 或 -w 自动监听文件修改，自动编译
                            ### 该监视考虑了各种嵌入关系, a.css中嵌入了b.css, b修改时会重构这两个文件
                            ### --live 或 -L 。在-w基础上实现，监视到修改后自动刷新浏览器页面
    fis server start                # 启动本地调试服务器
                            ## -p [port] 指定新端口
                            ## --type node 如果没有java, php环境，指定用node环境启动
    fis server stop
    fis server open                # 查看默认产出目录
# 配置
    o->
    fis.config.set('pack', {
            'pkg/lib.js': [
                    '/lib/mod.js',
                    '/modules/underscore/**.js',
                    'modules/backbone/**.js'
            ]
    });                # 文件合并成lib.js，但是不替换页面中的静态资源引用
                    ## 为了替换引用，使用fis的后端静态资源管理来加载引用，或者用fis-postpackager-simple插件
    o->
    fis.config.set('roadmap.path', [{
            reg: '**.css',
            useSprite: true
    }]);                # 为所有样式资源开启csssprites, 该插件在fis中内置
    fis.config.set('settings.spriter.csssprites.margin', 20);                # 设置图片合并间距
                                                    ## 要在要合并的图片引用路径后面加?__sprite来标识
                                                    ## 被合并图片中的小图, background-position来分图的情况也支持
# 组件
## yogurt
    基于express 的nodejs框架 
## fis-plus
    fis + php + smarty
## gois
    fis + go + margini
## jello
    fis + java + velocity
## pure
    纯前端框架

# 插件
## fis-postpackager-simple
    介绍
            fis-plus和yogurt不需要
    安装
            npm install -g fis-postpackager-simple
    配置
            // fis-conf.js
            fis.config.set('modules.postpackager', 'simple');                        # 打包时自动更改静态资源引用
            fis.config.set('settings.postpackager.simple.autoCombine', true)        # 开启按页面自动合并css, js文件
## fis-parser-less
    介绍
            less模板
            npm install -g fis-parser-less
    配置
            fis.config.set('modules.parser.less', 'less');
                    # 'modules.parser.less'表示后缀名less的文件，'less'表示用fis-parser-less编译
            fis.config.set('roadmap.ext.less', css)
                    # 将less文件编译为css

