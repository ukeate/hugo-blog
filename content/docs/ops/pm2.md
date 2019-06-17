---
Categories: ["运维"]
title: "PM2"
date: 2018-10-11T18:31:16+08:00
---

# 介绍
        带有负载均衡功能的node应用进程管理器
        内建负载均衡(使用node cluster模块)
        后台运行
        热重载
        停止不稳定进程，如无限循环
# 安装
        npm install -g pm2
# 命令
        pm2 start app.js
        pm2 stop
        pm2 restart
        pm2 status
        pm2 info 1
        pm2 logs 1