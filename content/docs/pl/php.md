---
Categories: ["语言"]
title: "Php"
date: 2018-10-09T16:24:33+08:00
---

# 安装
        php, php-cgi
    编译安装
        yum install libxml2-devel  openssl-devel  bzip2-devel libmcrypt-devel  -y
        ./configure --prefix=/opt/zly/php --with-mysql=mysqlnd --with-openssl --with-mysqli=mysqlnd --enable-mbstring --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml  --enable-sockets --enable-fpm --with-mcrypt  --with-config-file-path=/etc --with-config-file-scan-dir=/etc/php.d --with-bz2
        make
        make install
        cp php.ini-production /etc/php.ini
        cp sapi/fpm/init.d.php-fpm /etc/rc.d/init.d/php-fpm
        chmod +x /etc/rc.d/init.d/php-fpm 
        cp /opt/zly/php/etc/php-fpm.conf.default /opt/zly/php/etc/php-fpm.conf
        chkconfig --add php-fpm
        chkconfig php-fpm on
        /etc/init.d/php-fpm start
# 命令
        php -S localhost:8000 -t dir/
# 配置
        /etc/php/php.ini
        date.timezone = Europe/Berlin
                # 时区设置
        display_errors = On


# 框架
    zend opcache
            # php5.5集成，把php执行后的数据缓冲到内存中从而避免重复编译
# 工具
## fpm
    介绍
            php fastCGI 进程管理器