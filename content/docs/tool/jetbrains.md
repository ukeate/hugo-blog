---
title: Jetbrains
type: docs
---


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
        settings -> Keymap 设置eclipse
            alt + enter     # 改错
            shift shift     # 搜索跳转
    类注释
        settings -> Editor -> File and Code Templates -> Includes -> File Header
           /**  
            *
            * @Description: ${Description}
            * @author: ShenWenqing
            * @date: Created on ${DATE} ${TIME}
            *
            */
    alt + enter 可生成 serialVersionUID
        settings -> Inspections
            勾选 Serializable class without 'serialVersionUID'
    JDK
        Project Settings -> Project
        settings -> Build Tools
        settings -> Compilers
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