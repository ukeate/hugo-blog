---
Categories : ["架构"]
title: "Nginx"
date: 2018-10-11T16:18:58+08:00
---

# 结构
        一个主进程(root权限运行)和多个工作进程(普通权限运行)
# 模块
        handler
        filter
        upstream
        load-balance
# 功能
        http
               可以保持session， 相同的ip分配到同一个服务器上
               缓存静态页面到内存，建立索引与自动索引
                反向代理
                负载均衡
                模块化
                        过滤器
                                gzipping, byte ranges, chunked responses, SSI-filter
                支持SSL与TLS SNI
        imap/pop3代理
# 命令
    nginx -c /etc/nginx/nginx.conf
    nginx -s quit
    nginx -s stop
    nginx -s reload
            # 重载设置
            ## service nginx reload
    nginx -v
            # 查看版本
            ## -V
    nginx -t [-c nginx.conf]
            # 检查配置文件是否正确
    nginx -h
            # 查看帮助
            ## -?

    pkill -9 nginx
    kill -HUP `nginx.pid`
            # 平滑重启。尝试解析配置文件，成功时应用新配置(否则继续使用旧配置)，运行新的工作进程并从容关闭旧工作进程
            ## 继续为当前连接客户提供服务
            # 支持 QUIT TERM INT USR1(重新打开日志文件，切割日志时用) USR2(平滑升级可执行程序) WINCH(从容关闭工作进程)
# 配置
    http://nginx.org/en/docs/dirindex.html
    域
            main http server location

    worker_rlimit_nofile 51200;
            # worker最大打开文件数的限制, 不设时为系统限制
    pid        /var/run/nginx.pid;
            # nginx.pid文件中存储当前nginx主进程的pid
## HttpLimitReqModul
    介绍
            限制单个ip一段时间的连接数
    http{
            limit_req_zone $binary_remote_addr zone=allips:10m rate=20r/s;
                    # 
            server {
                    location {
                            limit_req zone=allips burst=5 nodelay;
                                    # 
                    }
            }
    }
## HttpLimitZoneModul
    介绍
            限制ip连接内存大小

    http {
            limit_conn_zone $binary_remote_addr zone=namea:10m;
                    # $binary_remote_addr 同一客户端ip地址
                    # 1.1.18前是limit_zone
            limit_conn_zone $server_name zone=nameb:10m;
                    # $server_name 同一server的名字
            server {
                    location {
                            limit_conn  namea 20;
                            limit_conn nameb 20;
                                    # 并发连接数
                            limit_rate 100k;
                                    # 下载速度
                    }
            }
    }
## HttpLimitConnModul
    介绍
            限制单个ip的并发连接数
# 例子
    user www-data;
    worker_processes 4;
    pid /run/nginx.pid;

    events {
            worker_connections 768;
            # multi_accept on;
    }

    http {

            ##
            # Basic Settings
            ##

            sendfile on;
            tcp_nopush on;
            tcp_nodelay on;
            keepalive_timeout 65;
            types_hash_max_size 2048;
            # server_tokens off;

            server_names_hash_bucket_size 64;
            # server_name_in_redirect off;

            include /etc/nginx/mime.types;
            default_type application/octet-stream;

            ##
            # Logging Settings
            ##

            access_log /var/log/nginx/access.log;
            error_log /var/log/nginx/error.log;

            ##
            # Gzip Settings
            ##
            gzip on;
            gzip_disable "msie6";

            # gzip_vary on;
            # gzip_proxied any;
            # gzip_comp_level 6;
            # gzip_buffers 16 8k;
            # gzip_http_version 1.1;
            # gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

            ##
            # nginx-naxsi config
            ##
            # Uncomment it if you installed nginx-naxsi
            ##

            #include /etc/nginx/naxsi_core.rules;

            ##
            # nginx-passenger config
            ##
            # Uncomment it if you installed nginx-passenger
            ##

            #passenger_root /usr;
            #passenger_ruby /usr/bin/ruby;

            ##
            # Virtual Host Configs
            ##
            include /etc/nginx/conf.d/*.conf;
            include /etc/nginx/sites-enabled/*;
    }

    #mail {
    #      # See sample authentication script at:
    #      # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
    #
    #      # auth_http localhost/auth.php;
    #      # pop3_capabilities "TOP" "USER";
    #      # imap_capabilities "IMAP4rev1" "UIDPLUS";
    #
    #      server {
    #              listen    localhost:110;
    #              protocol  pop3;
    #              proxy      on;
    #      }
    #
    #      server {
    #              listen    localhost:143;
    #              protocol  imap;
    #              proxy      on;
    #      }
    #}


    o-> app.zlycare.com
    server {
            listen 80; 
            listen [::]:80;

            server_name app-test.zlycare.com www.app-test.zlycare.com;
        
            # access log file
            access_log /home/zlycare/data/app-zlycare-com.log;
        
            location / { 
                    gzip on; 
                    default_type text/plain;
                    charset utf-8;
                    root /home/zlycare/app/zlydoc-cloud/public;
                    index index.html;
            }   

    }

    o-> web.zlycare.com
    server {
            listen 80; 
            listen [::]:80;

            server_name web-test.zlycare.com www.web-test.zlycare.com;
        
            # access log file
            access_log /home/zlycare/data/web.zlycare.log;
        
            location / { 
                    proxy_pass http://127.0.0.1:8082;    
                    #proxy_redirect off;
                    proxy_set_header Host $host;  
                    proxy_set_header X-Real-IP $remote_addr;  
                    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;  
            }   
    }

    o-> sdk.com
    server {
            listen 80; 

            server_name 10.162.201.58;
        
            # access log file
            access_log /home/zlycare/data/app-zlycare-com.log;
        
            location / { 
                    gzip on; 
                    default_type text/plain;
                    charset utf-8;
                    root /opt/sdk/nginx;
                    index index.html;
            }   

    }
## 代理
    配置
        server{
                resolver x.x.x.x;
                listen 82; 
                location / { 
                        proxy_pass http://$http_host$request_uri;
                }
        }   

        注意项：
        1. 不能有hostname
        2. 必须有resolver, 即dns，即上面的x.x.x.x，换成你们的DNS服务器ip即可
        3 . $http_host和$request_uri是nginx系统变量，不要想着替换他们，保持原样就OK。

        查看dns方法
        cat /etc/resolv.conf

    在需要访问外网的机器上执行以下操作之一即可：
        1. export http_proxy=http://yourproxyaddress：proxyport
        2. gedit ~/.bashrc  
            export http_proxy=http://yourproxyaddress：proxyport
        注  
            yourproxyaddress也就是你的Nginx服务器的ip了，proxyport就是上面配置中的82，可以根据自己的需要修改
## 反向代理
    o-> conf/nginx.conf
        server{
                location / {
                        proxy_pass http://127.0;
                        proxy_redirect default;
                        proxy_http_version 1.1;
                        proxy_set_header Upgrade $http_upgrade;
                        proxy_set_header Connection $http_connection;
                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                        proxy_set_header Host $http_host;
                }
        }

    o-> default.conf
        server {
            listen      80;
            #server_name  qipinmofang.com www.qipinmofang.com;
            server_name  epinkr.com www.epinkr.com;
            #server_name  localhost;
            if ( $host != 'www.epinkr.com' )
            {
                rewrite ^/(.*)$ http://www.epinkr.com/$1 permanent;
            }
            #root    /home/qipin/deploy;
            #index  index.html index.htm index.php;
            index  index.php index.html index.htm;

            #charset koi8-r;
            #access_log  /var/log/nginx/log/host.access.log  main;

            location = / {
                root  /home/qipin/deploy;
            #    index  index.html index.htm;
                fastcgi_pass  127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param SCRIPT_FILENAME $document_root/index.php;
                include        fastcgi_params;
            }

            location / {
                root  /home/qipin/deploy;
                index  index.html index.htm;
            }

            location /photo {
                root  /home/qipin/data;
            #    return 402;
            #    rewrite ^\/yuepin\/(.*) /$1 last;
            }

            location ~ ^\/(\w+)\/css\/ {
                root  /home/qipin/deploy;
                rewrite ^\/(\w+)\/css\/(.*)  /css/$2 last;
            }

            location ~ ^\/(\w+)\/img\/ {
                root  /home/qipin/deploy;
                rewrite ^\/(\w+)\/img\/(.*)  /img/$2 last;
            }

            location ~ ^\/(\w+)\/js\/ {
                root  /home/qipin/deploy;
                rewrite ^\/(\w+)\/js\/(.*)  /js/$2 last;
            }

            location ~ ^\/user\/(\w+)$ {
                root  /home/qipin/deploy;
            #    return 402;
                rewrite ^\/user\/(\w+)  /php/user/user_$1.php last;
            }

            location ~ ^\/company\/(\w+)$ {
                root  /home/qipin/deploy;
            #    return 402;
                rewrite ^\/company\/(\w+)  /php/company/company_$1.php last;
            }

            location ~ ^\/vendor\/(\w+)$ {
                root  /home/qipin/deploy;
            #    return 402;
                rewrite ^\/vendor\/(\w+)  /php/vendor/vendor_$1.php last;
            }

            location ~ ^\/person\/(\w+)$ {
                root  /home/qipin/deploy;
            #    return 402;
                rewrite ^\/person\/(\w+)  /php/person/person_$1.php last;
            }

            location ~ ^\/get\/(\w+)$ {
                root  /home/qipin/deploy;
            #    return 402;
                rewrite ^\/get\/(\w+)  /php/yp_$1.php last;
            }

            location ~ ^\/(\w+)$ {
                root  /home/qipin/deploy;
            #  return 402;
                rewrite ^\/(\w+)$  /php/$1.php last;
            }

            location ~ ^\/php\/(\w*\.php)$ {
                root  /home/qipin/deploy;
            #    return 403;
                fastcgi_pass  127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param SCRIPT_FILENAME $document_root/php/$1;
                include        fastcgi_params;
            }

            location ~ ^\/php\/(\w+)\/(\w*\.php)$ {
                root  /home/qipin/deploy;
            #    return 403;
            #    try_files $uri =404;
                fastcgi_pass  127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param SCRIPT_FILENAME $document_root/php/$1/$2;
                include        fastcgi_params;
            }

            #location /qipin/ {
            #    root  /home/qipin/deploy;
            #    return 402;
            #    index  index.html;
            #    rewrite ^\/qipin\/(.*) /$1 last;
            #}

            #error_page  404              /404.html;

            # redirect server error pages to the static page /50x.html
            #
            error_page  500 502 503 504  /50x.html;
            location = /50x.html {
                root  /usr/share/nginx/html;
            }

            # proxy the PHP scripts to Apache listening on 127.0.0.1:80
            #
            #location ~ \.php$ {
            #    proxy_pass  http://127.0.0.1;
            #}

            # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
            #
            #location ~ \.php$ {
            #    root          html;
            #    fastcgi_pass  127.0.0.1:9000;
            #    fastcgi_index  index.php;
            #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
            #    include        fastcgi_params;
            #}

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            #location ~ /\.ht {
            #    deny  all;
            #}
        }

    o-> ssl.conf
        # HTTPS server
        #
        #server {
        #    listen      443 ssl;
        #    server_name  localhost;

        #    ssl_certificate      /etc/nginx/cert.pem;
        #    ssl_certificate_key  /etc/nginx/cert.key;

        #    ssl_session_cache shared:SSL:1m;
        #    ssl_session_timeout  5m;

        #    ssl_ciphers  HIGH:!aNULL:!MD5;
        #    ssl_prefer_server_ciphers  on;

        #    location / {
        #        root  /usr/share/nginx/html;
        #        index  index.html index.htm;
        #    }
        #}
# openresty
    安装
            yum install -y gcc gcc-c++ kernel-devel readline-devel pcre-devel openssl-devel openssl zlib zlib-devel pcre-devel
            wget openresty-1.9.15.1.tar.gz
            ./configure --prefix=/opt/openresty --with-pcre-jit --with-ipv6 --without-http_redis2_module --with-http_iconv_module -j2
            make && make install
            ln -s /opt/openresty/nginx/sbin/nginx /usr/sbin
            /opt/openresty/nginx/conf/nginx.conf