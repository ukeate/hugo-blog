---

Description: ""
Categories : ["后端"]
Tags : ["golang"]
menu : "hugo"
title: "Hugo简易"
date: 2018-10-07T09:24:16+08:00
---

# 简介

    hugo由go编写，开源，特点为编译快
    本文基于hugo0.49

# help

    hugo help
    hugo help server    # server代表任何子命令

# 生成站点

    hugo new site blog1 # 站点命令在blog1中执行

# 生成文章

    hugo new about.md
    hugo new post/first.md
      
# 主题
    
    git clone https://github.com/spf13/hyde.git themes/hyde # 更多主题在https://themes.gohugo.io


# 本地服务器

    hugo server --theme=hyde --buildDrafts  # 默认端口1313, 自带watch

# 发布

    hugo --theme=hyde --baseUrl="https://outrunJ.github.io"

# 文章内容

* 开头

        ---
        用YAML写内容
        --- # +++标记可写TOML

        Description = ""
        Categories = ["a1", "a2"]
        Tags = ["b1","b2"]
        draft = true    # 文章隐藏
        menu = ""
        title = "a" # 文章标题
 
# 配置

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

