---
Categories: ["运维"]
title: "Cron"
date: 2018-10-11T18:12:51+08:00
---

# 介绍
        crond服务在systemd中被timer取代

# 使用
    $ service crond start
    $ service crond stop
    $ service crond restart
    $ service crond reload                # 重载配置
    $ crontab crontest.cron # 添加定时任务。打印的文件在用户根目录下
    $ crontab -l                # 列出用户目前的crontab
    $ crontab -u                # 设定某个用户的cron服务
    $ crontab -r                # 删除某个用户的cron服务
    $ crontab -e                # 编辑某个用户的cron服务
            # crontab -u root -l   查看root的设置

    /etc/crontab                # 系统配置文件
    /etc/cron.hourly
    /etc/cron.daily
    /etc/cron.weekly
    /etc/cron.monthly        # 每小时、天、周、月执行的脚本

    定时格式
            M H D m d cmd                
                    M: 分钟（0-59）每分钟用*或者 */1表示 
                    H: 小时（0-23） 
                    D: 天（1-31） 
                    m: 月（1-12）
                    d: 一星期内的天（0~6，0为星期天）
                    cmd: 如 ~/a.sh
# 例子
    crontest.cron文件中
            15,30,45,59 * * * * echo "aa.........." >> aa.txt         
                    # 每15分钟执行一次打印
    0 */2 * * * date                # 每两个小时
