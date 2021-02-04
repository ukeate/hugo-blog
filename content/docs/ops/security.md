---
Categories: ["运维"]
title: "Security"
date: 2018-10-11T18:47:57+08:00
---

# 基础
    自变异木马
        改变自身hash或将自身大量复制到不同目录, 后台运行，躲避清理
        自删除
        伪装成系统程序或绑定系统程序
    检查
        可疑进程
        定时任务
        启动项
            /etc/init.d或service --status-all
            systemctl list-unit-files | grep enabled
# 病毒
    libudev.so                      # 自变异，/bin/下生成随机名称命令, 启动后可远程执行命令，在/etc/init.d下创建自启动项，在/etc/crontab中添加定时任务
        chmod 0000 /lib/libudev.so && rm -rf /lib/libudev.so && chattr +i /lib/
        /etc/init.d下随机名称文件删除, /etc/rc{0,1,2,3,4,5,6,S}.d中的软链删除
        /etc/crontab/gcc.sh删除
        sed '/gcc.sh/d' /etc/crontab && chmod 0000 /etc/crontab && chattr +i /etc/crontab 删除定时任务
        重启
        chattr -i /lib /etc/crontab 恢复可写
