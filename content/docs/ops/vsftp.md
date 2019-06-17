---
Categories: ["运维"]
title: "Vsftp"
date: 2018-10-11T18:14:47+08:00
---

# 介绍
        默认端口21
        匿名用户登陆名为ftp或anonymous, 目录在/var/ftp, 只能下载不能上传
        本地用户用户名和密码与本地用户相同，目录为该用户的登录目录
# 文件
        /usr/sbin/vsftpd
                # VSFTPD的主程序
        /etc/rc.d/init.d/vsftpd
                # initd启动脚本
        /etc/vsftpd/vsftpd.conf
                # 主配置文件
        /etc/pam.d/vsftpd
                # PAM认证文件
        /etc/vsftpd.ftpusers
                # 禁止使用VSFTPD的用户列表文件
        /etc/vsftpd.user_list
                # 禁止或允许使用VSFTPD的用户列表文件
        /var/ftp
                # 匿名用户主目录
        /var/ftp/pub
                # 匿名用户的下载目录
# 默认用户与组
        用户
                adduser -d /var/ftp -g ftp -s /sbin/nologin ftp
        组
                ftp
# 命令
        systemctl start vsftpd
# 配置
    /etc/vsftpd/vsftpd.conf文件中
            anonymous_enable=YES
            local_enable=YES
            write_enable=YES
            chroot_local_user=YES
            allow_writeable_chroot=YES
            local_root=/
                    # local_root表示使用本地用户登录到ftp时的默认目录
            anon_root=/
                    # anon_root表示匿名用户登录到ftp时的默认目录
            chroot_list_file=/etc/vsftpd/chroot_list

    编辑/etc/vsftpd/chroot_list
            在这里面输入用户名字，一行写一个用户名。

    重启vsftpd
    打开tcp, udp端口21, 20

    root 登录
            /etc/vsftpd/vsftpd.conf
                    userlist_enable=YES
                    pam_service_name=vsftpd
            /etc/vsftpd/ftpusers与/etc/vsftpd/user_list
                    注释root

