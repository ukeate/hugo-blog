---
Categories : ["后端"]
title: "Nodejs"
date: 2018-10-11T10:33:48+08:00
---

# 特点
    commonJs规范                                        # 用于构建模块
    javascript书写(v8引擎)                                # 关键字1
                                                    # 原因1: 成熟的事件驱动模式
                                                    ## 原因2: 没有i/o库, 没有历史包袱
                                                    ## 原因3: v8性能好
                                                    # js设计之初就可以运行在后端
    单线程                                                # 关键字2
    非阻塞io(non-blocking i/o model)                # 关键字3
                                                    ## io与数据处理分离（所以必须异步）
                                                    ## 线程池结合event-driven实现
    事件驱动(event-driven)                                # 关键字4
                                                    ## event loop[while(true)] -> watcher -> handles
                                                    ### event loop每一周询问多个watcher是否有事件
                                                    ### http模块就是启动了一个watcher,所以执行后进程不结束
                                                            # 注: event loop中没有watcher时进程退出
                                                    ### 其它watcher有 timer, fs, udp/req, process
                                                    ### watcher产生事件后, event loop取到并执行其handle(回调函数)
                                                    ## 不同操作系统中event driven的实现:
                                                    ### windows: IOCP, Linux: epoll, Mac:kqueue
    异步操作                                        # 书写难度的解决
                                                    ## go语言有协程(coroutine)而node.js没有，协程可以同步式编程
                                                    ### 已有开发中的实现模块
                                                    ## promise(commonJs的规范, 其实现有whenJs, Q)
                                                    ## eventProxy alibaba朴灵写
                                                    ## async/step
# 层次
    javascript
    v8
    node
    libuv
    *nix/ windows                # 分别编译
# 技术
    libev的windows与linux接口实现
    c++扩展

# 工具
    node --v8-options | grep harmony
            # 查看支持的es6特性
    npm
        介绍
                cnpm是一个alibaba开发维护的，提供私有npm注册服务

        搭建cnpm服务器
                git clone https://github.com/cnpm/cnpmjs.org.git
                cd cnpmjs.org
                npm install npm -g
                        # 升级npm的版本
                npm install
                创建mysql数据库，并在config/index.js中修改mysql数据库的用户名和密码
                config/index.js中注释bindingHost来对外网开放
                node --harmony_generators dispatch.js
                        # 启动了两个端口, 7001用于npm注册服务, 7002用于web访问
        使用私有库
                npm install ape-algorithm --registry=http://192.168.1.20:7001
                        # 如果私有库中没有，cnpm会到npm中同步一个到cnpm, 再传给客户端一份

        项目设置私有库
                npm config list
                        # 查看项目的默认设置。registry属性指向npm官方资源位置
                npm config set registry http://192.168.1.20:7001

        用户设置私有库
                // ~/.npmrc
                registry=http://192.168.1.20:7001
                        # 另外，淘宝翻墙库 https://registry.npm.taobao.org/

        cnpm客户端
                npm install cnpm
                        # 可以像使用npm一样使用
                cnpm sync gulp
                        # npm 中发布的包在cnpm中有延时，可以用这个命令来手动同步

                调试
                        o-> 代码中插入断点
                                debugger;
                        o-> 以debug模式运行
                                # debug模式运行时, help查看可用命令
                                node debug app.js
        package.json
            {
                    "name": "test",
                    "version": "0.1.0",
                    "keywords": ["a", "b"],
                            # npm search时用
                    "description": "A testing package",
                    "os": ["linux", "darwin"],
                    "author": "outrun<outrun@mail.com>",
                    "dependencies": {
                            "express": "^1.0.0",
                            "redis": ">= 0.6.7"
                    },
                    "devDependencies": {
                            "grunt": "^0.4.5"
                    },
                    "main": "index",
                    "bin": {
                            "test": "./bin/test.js"
                    },
                    "scripts": {
                            "start": "node server.js",
                            "test": "vows test/*.js",
                                    # "grunt test" "mocha test" "make test" "make test-all"
                            "preinstall": "./configure",
                            "install": "make && make install",
                            "uninstall": ""
                    },
                    "engines": {
                            "node": "5.0.0"
                    }
            }

                    contributors
                    bugs
                    licenses
                    repositories
                    homepage
                    cpu
                    builtin
                            # 内建在底层系统的哪些组件上
                    directories
                    implements
                    bin
                            # 全局安装bin命令的位置
    n
    node-gyp
    nvm
    cnpm
        介绍
                cnpm是一个alibaba开发维护的，提供私有npm注册服务

        搭建cnpm服务器
                git clone https://github.com/cnpm/cnpmjs.org.git
                cd cnpmjs.org
                npm install npm -g
                        # 升级npm的版本
                npm install
                创建mysql数据库，并在config/index.js中修改mysql数据库的用户名和密码
                config/index.js中注释bindingHost来对外网开放
                node --harmony_generators dispatch.js
                        # 启动了两个端口, 7001用于npm注册服务, 7002用于web访问
        使用私有库
                npm install ape-algorithm --registry=http://192.168.1.20:7001
                        # 如果私有库中没有，cnpm会到npm中同步一个到cnpm, 再传给客户端一份

        项目设置私有库
                npm config list
                        # 查看项目的默认设置。registry属性指向npm官方资源位置
                npm config set registry http://192.168.1.20:7001

        用户设置私有库
                // ~/.npmrc
                registry=http://192.168.1.20:7001
                        # 另外，淘宝翻墙库 https://registry.npm.taobao.org/

        cnpm客户端
                npm install cnpm
                        # 可以像使用npm一样使用
                cnpm sync gulp
                        # npm 中发布的包在cnpm中有延时，可以用这个命令来手动同步
            
# api     
## 宿主对象
    global
        介绍
                全局对象
                global.root, global.BLOBAL 都指向自己
        方法
                setTimeout
                setInterval
                clearTimeout
                clearInterval
    process
        介绍
                当前进程
        属性
            argv                        # 获得命令行参数数组
                title                                # node
                version                            # v0.12.2
        事件
                process.on("uncaughtException",function(e){
                    console.log("error:"+e);
            });                        # 用于捕猎未处理异常
    buffer
        介绍
                node中buffer不属于v8, 使用c++扩展编写。所以可以使用高于1.4g的内存
                一个元素一字节
                8kb之内为小对象，slab机制分配内存, 先申请后分配。大于8kb的创建SlowBuffer对象
                pool的实现方式

        字符编码类型
                # 默认编码UTF-8
                # 一个buffer只能有一个编码
                ascii
                utf-8
                utf-16le/ucs-2
                base64
                binary
                hex
        属性
                length
        方法
                write
                        # write(str, [offset], [length], [encoding])
                toString
                        # toString([encoding], [start], [end])
                isEncoding
                        # 指定编码是否支持转换
                copy
                        # 复制自身到另一个buffer的某位置
                        buf.copy(buffer, 0)
        静态方法
                concat
                        concat(chunks, size)
                                # chunks中为buffer数组, size为总大小
        使用
                new Buffer(100)
                new Buffer('a', 'UTF-8')
    console
        介绍
                控制台
        方法
                        log('',obj)
                        #-> console.log('[%s] listening on http://127.0.0.1:%d', app.setting.env, port)
                                                                # 格式化输出
    module
        Module.exports真正的接口，导出的是一个类型
        exports是Module.exports的包装，导出的是Object类型的对象
    promise
        介绍
                0.11.x后加入的全局对象
        使用（复制）
        var jadeTemplate = new Promise(function(resolve, reject) {
        fs.readFile(path.join(__dirname, 'views/article.jade'), function(err, data) {
            if (err) {
            reject(err.message);
            } else {
            resolve(data.toString());
            }
        });
        });

        var localData = new Promise(function(resolve, reject) {
        fs.readFile(path.join(__dirname, 'static/shuffle.json'), function(err, data) {
            if (err) {
            reject(err.message);
            } else {
            resolve(JSON.parse(data.toString()));
            }
        });
        });

        Promise
        .all([jadeTemplate, localData])
        .then(function(value) {
            console.log(jade.compile(value[0])(value[1]));
        });
## 内置lib
### http
    介绍
            继承自net模块
            EventEmitter实例
    事件
            服务端
                    connection
                    request
                    close
                    checkContinue
                            # 发送较大数据时，先发送Expect: 100-continue请求头，此时触发
                    connect
                    upgrade
                            # 要求升级连接协议时
                    clientError
                            # 客户端触发error事件时触发
            客户端
                    response
                    socket
                            # 建立连接时触发
                    connect
                            # 响应200时触发
                    upgrade
                    continue

    属性
            globalAgent
                    # 重用http长连接，实际是个连接池，默认有5个并发
                    sockets
                            # 连接数
                    requests
                            # 处于等待状态的请求数

    方法
    http.createServer(onRequest).listen(8888, func);                # 创建服务器并启动
    http.createServer
            request
                    req.setEncoding("utf8")
                    var postData = "";
                    req.addListener("data", function(postDataChunk){
                            postData += postDataChunk;
                    });
                    req.addListener("end", function(){
                            route(handle, pathname, res, postData);
                    });                                # 拼接post请求数据
                    req.rawBody
                            # post来的原生数据
                    req.destroy()
                            # 放弃请求，停止招收

            response
                    res.setHeader('WWW-Authenticate', 'Basic realm=\"Tomcat Manager Application\"')
                    res.writeHead(200, {"Content-Type": "text/html"});
                            # 调用setHeader多次，调用writeHead后才写入
                    res.write("");
                    res.write(file,?"binary");?
                    res.end();
    http.request
                    # request(options, fn)
                    # options中有 host, hostname, port, localAddress(使用本地的哪个网卡), socketPath(本地套接字文件路径), method, path, headers, auth(被计算成请求头的Authorization部分), agent(并发连接数，默认5)
                    # 发起客户端请求
### https
    介绍
        nodejs
        申请ca证书
        访问端口为443
    使用
        express -e nodejs-https
        cd nodejs-https && npm install
        git --version
        openssl version -a
        openssl genrsa -out privatekey.pem 1024
                # 生成证书文件
        openssl req -new -key privatekey.pem -out certrequest.csr
                # 通过私钥生成CSR证书签名
        openssl x509 -req -in certrequest.csr -signkey privatekey.pem -out certificate.pem
                # 通过私钥和证书签名生成证书文件
                ## 这时生成了三个文件: certificate.pem, certrequest.csr, privatekey.pem
                ### 分别是: 证书文件, CSR证书签名, 私钥
                ## 由于证书是自己创建的，没有经过第三方机构验证，用户访问时会出现警告提示
        服务器
            var https = require('https')
                    , fs = require('fs');
            var options = {
                    key: fs.readFileSync('./privatekey.pem'),
                    cert: fs.readFileSync('./certificate.pem')
            };
            https.createServer(options, app).listen(3011, function(){
                    console.log('Https server listening on port: ' + 3011);
            });
        客户端
            var options = {
                    hostname: 'localhost',
                    port: 8000,
                    path: '/',
                    method: 'GET',
                    key: fs.readFileSync('./keys/client.key'),
                    cert: fs.readFileSync('./keys/client.crt'),
                    ca: [fs.readFileSync('./keys/ca.crt')]
                            # 设置rejectUnauthorized: false 来忽略ca验证
            }
            options.agent = new https.Agent(options)

            var req = https.request(options, function (res) {
                    res.setEncoding('utf-8')
                    res.on('data', function (d) {
                            console.log(d)
                    })
            })
            req.end()

            req.on('error', function(e){
                    console.log(e)
            })
### net
    介绍
            处理tcp请求
            socket是EventEmitter的Stream实例
    注意
            默认开启Nagle, 会合并小数据成一个数据包延迟发送
                    socket.setNoDelay(true)关闭Nagle
            并不是每次write都触发data事件, 关掉Nagle后，可能接收到多个小数据包后触发一次data

    服务器事件
            listening
            connection
            close
            error
    连接事件
            data
            end
            connect
            drain
                    # 任意一端调用write时触发
            error
            close
            timeout

    o-> 基本服务
            # telnet来测试
    var net = require('net')

    var server = net.createServer(function (socket) {
            socket.on('data', function (data) {
                    socket.write('a')
            })

            socket.on('end', function () {
                    console.log('disconnected.')
            })

            socket.write('welcome')
    }) 

    server.listen(8124, function () {
            console.log('server bound')
    })

    o-> 基本服务2
    var server = net.createServer()
    server.on('connection', function (socket) {})
    server.listen(8124)

    o-> 监听
    server.listen('/tmp/echo.sock')
            # nc -U /tmp/echo.sock 来测试

    o-> 客户端
    var client = net.connect({port: 8124}, function () {
            console.log('client connected')
            client.write('a')
    })

    client.on('data', function (data) {
            console.log(data.toString())
            client.end()
    })

    client.on('end', function() {
            console.log('disconnected.')
    })

    o-> 客户端
    var client = net.connect({path: '/tmp/echo.sock'})

    o-> 管道
    var server = net.createServer(function (socket) {
            socket.write('a')
            socket.pipe(socket)
    })
### dgram
    介绍
            处理udp
            socket是EventEmitter实例

    o-> 服务
    var dgram = require('dgram')

    var server = dgram.createSocket('udp4')

    server.on('message', function (msg, rinfo) {
            console.log(msg + 'from' + rinfo.address + ':' +)
    })

    server.on('listening', function () {
            var address = server.address()
            console.log('listening ' + address.address + ':' + address.port)
    })

    server.bind(41234)

    o-> 客户端
    var message = new Buffer('a')
    var client = dgram.createSocket('udp4')
    client.send(message, 0, message.length, 41234, 'localhost', function (err, bytes) {
            client.close()
    })
### events
    介绍
            几乎所有对象的父类
    使用

    var events = require('events')
            , util = require('util');
    function Obj(){events.EventEmitter.cal(this);}
    util.inherits(Obj, events.EventEmitter);
            # Obj.prototype.__proto__ = events.EventEmitter.prototype;
    Obj.prototype.write = function (data) {this.emit('data', data);};

    var obj = new Obj();
    obj.on('data', function (data) {console.log('Received data', data);})
            # obj.once
    obj.write('hello');

    方法
            setMaxListeners(0)
                    # 侦听器过多不警告
### path
### os
    方法
            totalmem
            freemem
### fs
    fs.readFile("tmp/test.png", "binary", function(error, file){
    });
    fs.writeFile('target.png', 'binary', function(err){
    })
    fs.exists(filePath, function(exists){
            if(exists){}
    })
    fs.unlink(filePath, function(err){
    })
    fs.renameSync(files.upload.path,?"/tmp/test.png");                # 写入文件(阻塞)

    o-> 流读写
    var reader = fs.createReadStream('in.txt')
            # 第二个参数为设置, highWaterMark: 每次读取的size, encoding: 编码
    var writer = fs.createWriteStream('out.txt')
    reader.on('data', function (chunk) {
            writer.write(chunk)
    })
    reader.on('end', function() {
            writer.end()
    })

    var reader = fs.createReadStream('in.txt')
    var writer = fs.createWriteStream('out.txt')
    reader.pipe(writer)
### sys
### process
    方法
            once
                    once('SIGINT', function () {})
                            # ctrl + c
            memoryUsage
                    # 查看v8内存使用量
                    # 其中rrs是resident set size, 是常驻内存的部分，其他在swap或文件系统中
            kill
                    # process.kill(pid[, signal])
            on
                    # 事件触发
    属性
            argv
                    # 启动时参数
            pid
                    # 当前进程的pid

    o->
    process.on('SIGTERM', function () {
            console.log('Got a SIGTERM, exiting...')
            process.exit(1)
    })

    o->
    process.on('uncaughtException', function () {
            logger.error(err)
            process.send({act: 'suicide'})
                    # 向主进程发送信号
            worker.close(function () {
                    process.exit(1)
            })

            setTimeout(function () {
                    # 长连接断开需要时间较久, 超时自动退出
                    process.exit(1)
            }, 5000)
    })
### module
    属性
            exports
            parent
### stream                
    介绍
            继承EventEmitter, 处理文件之类的流
### tls
    介绍
            建立在tls/ssl上的加密tcp
            使用openssl来构建证书和测试

    o-> 服务器
    var tls = require('tls')
    var fs = require('fs')

    var options = {
            key: fs.readFileSync('./keys/server.key'),
            cert: fs.readFileSync('./keys/server.crt'),
            requestCert: true,
            ca: [fs.readFileSync('./keys/ca.crt')]
    }

    var server = tls.createServer(options, function (stream) {
            console.log('server connected', stream.authorized ? 'authorized' : 'unauthorized')
            stream.write('welcome!\n')
            stream.setEncoding('utf8')
            stream.pipe(stream)
    })
    server.listen(8000, function () {
            console.log('server bound')
    })

    o-> 客户端
    var options = {
            key: fs.readFileSync('./keys/client.key'),
            cert: fs.readFileSync('./keys/client.crt'),
            ca: [fs.readFileSync('./keys/ca.crt')]
    }

    var stream = tls.connect(8000, options, function () {
            console.log('client connected', stream.authorized ? 'authorized' : 'unauthorized')
                    # 证书是否通过
            process.stdin.pipe(stream)
    })

    stream.setEncoding('utf8')
    stream.on('data', function (data) {
            console.log(data)
    })
    stream.on('end', function () {
            server.close()
    })
### child_process
    介绍
            可以创建新的node进程

    方法
            spawn(command[, args][a options])
                    # command执行的命令
                    # args参数列表
                    # options 环境变量对象
                    ## 包括7个属性 
                    ### cwd 子进程当前工作目录
                    ### env 环境变量键值对
                    ### stdio 子进程stdio配置
                    ### customFds 子进程stdio使用的文件标示符
                    ### detached 进程组的主控制
                    ### uid 用户进程id
                    ### 进程组id
                    var du = child.spawn('du', ['-sh', '/disk1']);
                    du.stdout.on('data', function(data){})
                    du.stderr.on('data', function(data){})
                    du.on('exit', function(code){})
            exec('')
                    # 对spawn的友好封装, 增加了shell命令解析
                    child.exec('cat *.js | ws', function(error, stdout, stderr){})
            execFile(command[, args])
                    # 执行可执行文件，不解析args,防止了exec参数注入的风险
                    child.execFile('/bin/ls', ['-l', '.'], function(err, result){})
            fork
                    # 同spawn, 但建立父进程与子进程之间的通信管道
                    var n = child.fork('./son.js');
                    n.on('message', function(){
                            console.log('Main listen: ', m);
                    });
                    n.send({hello: 'i am parent'});
                    // son.js
                    process.on('message', function(m){
                            console.log('Son listen: ', m);
                    });
                    process.send({hello: 'i am child'});
    子进程对象方法
            send
                    # 发送消息和句柄，句柄可以是
                    ## net.Socket, net.Server, net.Native(c++层面的tcp套接字或IPC管道), dgram.Socket, dgram.Native
            kill
                    # 向子进程发送SIGTERM信号
    子进程事件
            message
            error
            exit
            close
            disconnect

    o-> spawn
    var spawn = require('child_process').spawn
    free = spawn('free', ['-m'])
    free.stdout.on('data', function (data) {})
    free.stderr.on('data', function (data) {})
    free.on('exit', function (code, signal) {})

    o-> fork
            # 需要至少30ms, 10M启动一个v8实例
    var fork = require('child_process').fork
    var cpus = require('os').cpus()
    for (var i = 0; i < cpus.length; i++) {
            fork('./worker.js')
    }

    o-> 通信
            # 只有子进程是node进程时才可以通信
    var cp = require('child_process')
    var n = cp.fork(__dirname + '/sub.js')

    n.on('message', function (m) {
            console.log('PARENT got message: ', m)
    })
    n.send({a: 1})

    process.on('message', function (m) {
            console.log('CHILD got message:', m)
    })
    process.send({b: 2})

    o-> 句柄通信
            # 节省了代理建立socket浪费的文件描述符
    var child = require('child_process').fork('child.js')
    var server = require('net').createServer()
    server.on('connection', function (socket) {
            socket.end('handled by parent \n')
    })
    server.listen(1337, function () {
            child.send('server', server)
    })
    // child.js
    process.on('message', function (m, server) {
            if (m === 'server') {
                    server.on('connection', function (socket) {
                            socket.end('handled by child \n')
                    })
            }
    })

    o-> 句柄负载http
            # 对描述符是抢占式的
    var cp = require('child_process')
    var child1 = cp.fork('child.js')
    var child2 = cp.fork('child.js')

    var server = require('net').createServer()
    server.listen(1337, function () {
            child1.send('server', server)
            child2.send('server', server)
            server.close()
    })
    // child.js
    var http = require('http')
    var server = http.createServer(function (req, res) {
            res.writeHead(200, {'Content-Type': 'text/plain'})
            res.end('handled by child, pid is ' + process.pid + '\n')
    })
    process.on('message', function (m, tcp) {
            if (m === 'server') {
                    tcp.on('connection', function (socket) {
                            server.emit('connection', socket)
                    })
            }
    })
### domain
    介绍
            用于异步异常捕获
            绑定方式
                    隐式绑定: 把domain上下文中定义的变量，自动绑定到domain对象
                    显式绑定: 把不是domain上下文中定义的变量，以代码的方式绑定到domain对象
    使用
            var domain = require('domain');
            function async_error(){
                    setTimeout(function(){
                            var r = Math.random() * 10;
                            console.log('random num is ' + r);
                            if(r > 5)
                                    throw new Error('Error: random num ' + r + ' > 5');
                    }, 10);
            }
            var d = domain.create();
            d.on('error', function(err){
                    console.log(err);
            });
            setInterval(function(){
                    d.run(async_err);
            }, 1000);
    方法
            create                                            # 返回一个domain对象
            run(fn)                                            # 在domain上下文中执行一个函数，并隐式绑定所有事件、定时器和低级请求
            add(emitter)                                # 显式的增加事件
            remove(emitter)                            # 删除事件
            bind(callback)                                # 以return为封闭callback函数　
            intercept(callback)                        # 同bind, 但返回第一个参数
            enter()                                            # 进入一个异步调用的上下文，绑定到domain
            exit()                                                # 退出当前的domain, 切换到不同的链的异步调用的上下文中，对应domain.enter()
            dispose()                                        # 释放一个domain对象，让node进程回收这部分资源
    属性
            members                                        # 已加入domain对象的域定时器和事件发射器的数组
    未绑定不捕获 
        说明
                以下的例子中，domain将捕捉不到异步异常
        代码
                var domain = require('domain');
                var EventEmitter = require('events').EventEmitter;

                var e = new EventEmitter();

                var timer = setTimeout(function(){
                        e.emit('data');
                }, 10);

                function next(){
                        e.once('data', function(){
                                throw new Error('Receive data error!');
                        });
                }

                var d = domain.create();
                d.on('error', function(err){
                        console.log(err);
                });
                d.run(next);
        原因
                timer和e两个关键对象在初始化时都没有在domain范围内。当next函数中抛出异常时, 没有处于domain的包裹中

        修改
                ...
                d.add(e);
                d.add(timer);
                d.run(next);
## 外部lib
### url
    方法
            parse
                    # url.parse(req.url)
                    # url.parse(req.url, true) 会parse出query对象
                    pathname
### querystring
    方法
            parse
                    # querystring.parse(url.parse(req.url).query)
### crypto
    介绍
            加密并生成各种散列
            利用openssl库来实现，提供openssl中一系列哈希方法，包括hmac, cipher, decipher, 签名和验证等方法的封装
    使用
            var crypto = require('crypto');
            console.log(crypto.getHashes());                                    # 打印支持的所有hasp算法
### node-gyp
    编译C++模块的编译工具
### util
    使用
            var util = require('util');
    方法
            inherits(Sub, Base)                # 对象间原型继承，Sub 仅继承Base原型中定义 的函数
            inspect(obj)                # 任意对象转换为字符串
            log(string)                        # 带时间戳的log
            format('%s:%s', 'a', 'b', 'c')                // 'a:b c'
                    # format('%s:%s', 'a')                // 'a:%s'
                    # format(1, 2, 3)                        // '1 2 3'
            is系列
                    isArray(obj)
                    isRegExp(obj)
                    isDate(obj)
                    isError(obj)
                    isBoolean(obj)
                    isNull(obj)
                    isNullOrUndefined(obj)
                    isNumber(obj)
                    isString(obj)
                    isSymbol(obj)
                    isUndefined(obj)
                    isObject(obj)
                    isFunction(obj)
                    isPrimitive(obj)
                            # 是否基本类型
                    isBuffer(obj)
                    deprecate(foo, 'foo() is deprecated, use bar() instead');
                            # 标记为过时, 调用foo()时显示后面的话
### zlib
    介绍
            提供压缩方法，如gzip
## 全局属性
    介绍
            并非挂在global下的属性，但可以直接使用

    属性
            __dirname
                    # 在任何模块内获取当前模块文件的绝对路径
            __filename
                    # 当前在执行的js文件路径
# 方案
    异常捕获
            process.on("uncaughtException",function(e){
                    logger.error("error:"+e);
            });
            process.on('unhandledRejection', function (err, p) {
            console.error(err.stack)
            });
# 框架
## connect
    介绍
            nodejs处理http中req、res的中间件框架
            中间件分类
                    pre-request用来改写request原始数据
                    request/response功能各异
                    post-response全局异常处理，改写response数据等
    内置中间件介绍
            logger
            csrf
            compress                                        # gzip压缩
            basicAuth                                        # basic认证
            body parser                                    # 请求内容解析
            json
            urlencoded                                        # application/x-www-form-urlencode请求解析
            multipart                                            # multipart/form-data请求解析
            timeout
            cookieParser
            session
            cookieSession
            methodOverride                            # http伪造
            responseTime                                # 计算响应时间
            staticCache                                        # 缓存
            directory                                            # 目录列表
            vhost                                                # 虚拟二级域名映射
            favicon
            limit                                                    # 请求内容大小限制
            query                                                # url解析
            errorHandler                                    # 错误处理
    使用
            var connect = require('connect');
            var app = connect()
                    .use(connect.logger('dev'))
                    .use(function(req, res){
                            res.end('hello world\n');
                    })
                    .listen(3000);
## express
    是node.js的包管理器，用它的结构管理自己 的项目
    安装
            npm install -g express-generator
            npm install express -d                        # g代表安装到NODE_PATH的lib里面, d代表关联套件一起安装
    cookie-parser
        使用
                var cookieParser = require('cookie-parser');
                app.use(cookieParser());

                JSON.stringify(req.cookies);
                req.cookies.yourCookie
    cookie-session
            使用
                    var cookieSession = require('cookie-session');
                    app.use(cookieSession())
                    req.session = null

    express-session
        使用
                var session = require('express-session');
                app.use(session(options));

        options中可选参数
                name                        # 表示cookie中保存session的字段名称，默认为connect.sid
                store                        # session的存储方式，默认存放在内存中，也有redis、mongodb、等模块支持
                secret                        # 设置secrect来计算hash放在cookie中产生signedCookie，来防篡改
                genid                        # 规定产生一个新的session_id时所用的函数，默认用uid2这个包
                rolling                        # 每个请求都重新设置一个cookie，默认为false
                resave                        # 即使session没有被修改，也保存session的值
    connect-redis
        使用
                var express = require('express');
                var session = require('express-session');
                var redisStore = require('connect-redis')(session);

                app.use(session({
                        store: new redisStore(),
                        secret: 'somesecrettoken'
                }));
    serve-static
        静态文件
    passport
        介绍
                登录验证中间件
                支持connect express sails等web框架
                支持Basic, Digest, OAuth(1.0和2.0的三种实现), Bearer等
        安装
                npm i passport
                npm i passport-local
        o-> 配置
        var express = require('express');
        var cookieParser = require('cookie-parser');
        var session = require('express-session');
        var flash = require('express-flash');
        var passport = require('passport');

        ...

        app.use(cookieParser());
        app.use(session({...}));
        app.use(passport.initialize());
        app.use(passport.session());
        app.use(flash())

        passport.serializeUser(function (user, done) {
                done(null, user.id)
        })
        passport.deserializeUser(function (id, done) {
                User.findById(id, function (err, user) {
                        done(err, user)
                })
        })

        app.post('/login', passport.authenticate('local', {
                # passport.authenticate是个登录中间件，通过就走后面回调，否则返回401
                # local是自定义的名称
                successRedirect: '/',
                failureRedirect: '/login',
                failureFlash: true,
        }, function (req, res) {
                res.redirect('/users/' + req.user.username)
        }))

        app.post('/login', passport.authenticate('local', function(err, user, info) {
                if (err) return next(err)
                if (!user) {
                        req.flash('errors', {msg: info.message})
                        return res.redirect('/login')
                }
                req.logIn(user, function (err) {})
        })(req, res, next))
        app.get('/logout', function(req, res) {
                req.logout()
                res.redirect('/')
        })
        app.get('/user', isAuthenticated, getUser)
        var isAuthenticated = function (req, res, next) {
                if (req.isAuthenticated()) {
                        return next()
                }
                res.redirect('/login')
        }


        o-> local验证
        var LocalStrategy = require('passport-local').Strategy
        passport.use(new LocalStrategy(
                function(username, password, done) {
                        User.findOne({username: username}, function(err, user) {
                                if (err) {return done (err)}
                                if (!user) {return done(null, false, {message: 'no user'})}
                                if (!user.validPassword(password)) {...}
                                return done(null, user)
                        })
                }
        ))

        o-> usernameField
        passport.use(new LocalStrategy({
                usernameField: 'email',
                passwordField: 'passwd'
        }, function (username, password, done) {...}
        ))

        o-> OAuth
        介绍
                第三方登录协议
                三个步骤
                        1. 获取未授权的request token
                        2. 获取用户授权的request token
                        3. 用授权的request token换取access token
        使用
                网页上申请开发github应用
                npm install passport-github
                        # 安装passport的github扩展
                // app.js
                passport.use(new GithubStrategy({        // 增加github认证策略
                        clientID: 'XXXX',
                        clientSecret: 'YYYY',        // 已从github上申请
                        callbackURL: 'http://localhost:3000/auth/github/callback'
                }, function(accessToken, refreshToken, profile, done){
                        done(null, profile);
                }));
                // 定义路由
                app.all('/github', isLoggedIn);
                app.get('/github', user.github);
                app.get('/auth/github', passport.authenticate('github', {scope: 'email'}));
                app.get('/auth/github/callback', passport.authenticate('github', {
                        successRedirect: '/github',
                        failureRedirect: '/'
                }));
    kraken
        介绍
                基于express之上的基于设置结构化代码工具
        功能
                post请求_csrf验证 
                        
        基本用法
                'use strict'
                var express = require('express'),
                        kraken = require('kraken-js');
                var app = express();
                app.use(kraken());
                app.listen(8000);
## koa
    介绍
            express原班人马打造的，更小，更健壮，更有表现力的web框架
            免除重复繁琐的回调函数嵌套，提高错误处理效率
            不绑定任何中间件，只是提供一个轻量优雅的函数库
            >=node0.11.16
    配置
        app.name                                    # 应用名称
        app.env                                        # 执行环境，默认是NODE_ENV 或 'development'
        app.proxy                                    # 决定哪些proxy header被加到信任列表中
        app.subdomainOffset              # 被忽略的.subdomains列表
        app.jsonSpaces                          # 输出json时是否填充空格
        app.outputErrors                        # 是否输出错误堆栈(err.stack)到stderr(app.env是'test'时，此值为false)

    使用
            $ npm install koa
            $ node --harmony app.js                        # 必需使用harmony模式运行程序
            var koa = require('koa');
            var app = koa();
            app.use(function *(){
                    this.body = 'Hello World';
            });                # function*  声明的generator function支持yield
                                ## yield是ES6定义的新语法
            app.listen(3000);
    使用(downstream & upstream)
        var koa = require('koa');
        var app = koa();

        // x-response-time
        app.use(function *(next){
        // (1) 进入路由
        var start = new Date;
        yield next;
        // (5) 再次进入 x-response-time 中间件，记录2次通过此中间件「穿越」的时间
        var ms = new Date - start;
        this.set('X-Response-Time', ms + 'ms');
        // (6) 返回 this.body
        });

        // logger
        app.use(function *(next){
        // (2) 进入 logger 中间件
        var start = new Date;
        yield next;
        // (4) 再次进入 logger 中间件，记录2次通过此中间件「穿越」的时间
        var ms = new Date - start;
        console.log('%s %s - %s', this.method, this.url, ms);
        });

        // response
        app.use(function *(){
        // (3) 进入 response 中间件，没有捕获到下一个符合条件的中间件，传递到 upstream
        this.body = 'Hello World';
        });

        app.listen(3000);

        this
                request
                        header
                        headers
                        url
                        accepts
                response
                        header
                        headers
                        status
                cookies
                        set('name', 'tobi', {signed: true})
                                signed
                                expires
                                path
                                domain
                                secure
                                httpOnly
                        get
                type
                length
                path
                method
                state
                throw
                assert
        app
                use
                listen
                callback
                keys
                context
                        db
    中间件
        koa-router
        trie-router
        route
        basic-auth
        etag
        compose
        static
        static-cache
        session
        compress
        csrf
        logger
        mount
        send
        error
## assert
    测试
## 