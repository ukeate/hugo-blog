---
Categories : ["后端"]
title: "Hexo"
date: 2018-10-11T15:20:06+08:00
---

# 介绍
        简单轻量，基于node的静态博客框架
        可以部署在自己node服务器上，也可以部署在github上
# 目录结构
        scaffolds                                        # 脚手架
        scripts                                            # 写文件的js, 扩展hexo功能
        source                                            # 存放博客正文内容 
                _drafts                                    # 草稿箱
                _posts                                        # 文件箱
        themes                                            # 皮肤
        _config.yml                                        # 全局配置文件
        db.json                                            # 静态常量
# 使用
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