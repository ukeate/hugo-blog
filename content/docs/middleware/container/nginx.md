---
Categories : ["后端"]
title: "Nginx"
date: 2018-10-11T10:33:48+08:00
---

# 基础
    结构
        一个主进程(root权限运行)和多个工作进程(普通权限运行)
    优点
        异步非阻塞
        非常稳定
        反向代理
            后端服务io能力不高，nginx buffer http请求直到完整，再发送到后端。同样buffer响应
        相对apache
            轻量
            apache阻塞
            占资源低
            模块化设计
            社区活跃, bug少
    多进程模型
        使用epoll
        多worker处理，业务阻塞时切换调度, 结束阻塞时分配
    模块
        handler
        filter
        upstream
        load-balance
    功能
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
    命令
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
    例子
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
    nginx
        server{
            resolver x.x.x.x;
            listen 82;
            location / {
                proxy_pass http://$http_host$request_uri;
            }
        }

        不能有hostname, 必须有resolver, 即DNS服务器ip
        $http_host和$request_uri是nginx系统变量
    用户机器
        export http_proxy=http://nginx-ip:82
## 反向代理
    upstream backend {
        hash $consistent_key consistent
        server 192.168.61.1:9080 weight=1
        server 192.168.61.1:9090 weight=2
    }
    location / {
        proxy_pass http://backend
        set $consistent_key $arg_cat;                       # 从cat参数取值
        if ($consistent_key = "") {
            set $consistent_key $request_uri;
        }
    }

    上游服务器, 权重越高分配越多
    请求/时，代理到backend配置的上游服务器
    负载均衡算法
        round-robin(轮询)
        ip-hash
            ip_hash
        hash key/hash key consistent        # hash和一致性hash
            hash $uri
        least_conn                          # 最小连接数服务器
        least_time                          # 最小平均响应时间, 商业版
## php
    conf/nginx.conf
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

    default.conf
        server {
            listen      80;
            server_name  epinkr.com www.epinkr.com;
            #server_name  localhost;
            if ( $host != 'www.epinkr.com' )
            {
                rewrite ^/(.*)$ http://www.epinkr.com/$1 permanent;
            }
            #root    /home/qipin/deploy;
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

    ssl.conf
        #HTTPS server
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
# 插件
    HttpLimitReqModul
        介绍
            限制单个ip一段时间的连接数
        http{
            limit_req_zone $binary_remote_addr zone=allips:10m rate=20r/s;
            server {
                location {
                    limit_req zone=allips burst=5 nodelay;
                }
            }
        }
    HttpLimitConnModul
        介绍
            限制单个ip的并发连接数
    HttpLimitZoneModul
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
