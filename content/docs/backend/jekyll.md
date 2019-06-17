---
Categories : ["后端"]
title: "Jekyll"
date: 2018-10-11T15:19:43+08:00
---

# 介绍
        ruby静态站点生成器，根据网页源码生成静态文档文件
        提供模板、变量、插件等功能
        生成的站点可以直接发布到github上
# 使用
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