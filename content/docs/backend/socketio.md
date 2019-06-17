---
Categories : ["后端"]
title: "Socketio"
date: 2018-10-11T11:42:33+08:00
---

# 介绍
        socket.io: 基于任何浏览器, mobile设备的"webSocket"
# 安装
        npm install socket.io
# 使用
        var socketIo = require('socket.io');
        socketIo.listen(app).on('connection', function (socket) {                # require('socket.io')(app);
                                                                        ## var io = require('socket.io')(80);
        socket.emit('news', { hello: 'world' });
        socket.on('my other event', function (data) {
                console.log(data);
        });
        });
# api
    server
            io.on('connection', function(socket){});
            io.on('disconnect', function(){});
            socket.on('message', function(msg){});
    client-js
            socket = io.connect(url);
            socket.on('', function(json){});
            socket.send(json);
    io
            on('connection', function(socket){});
                    # disconnect
    socket
            on('disconnect', function(){ });
            socket.on('say to someone', function(id, msg){
                    socket.broadcast.to(id).emit('my message', msg);
            });
                    # Socket#id为内部指定的
    遍历用户
            var roster = io.sockets.clients('chatroom');
            roster.forEach(function(client){
                    console.log('Username: ' + client.nickname);
            });                        // 1.0之前版本可用
# 方案
    namespace
            server
                    var nsp = io.of('/my-namespace');
                    nsp.emit('hi', 'everyone!');                # ns广播
            client
                    var socket = io('/my-namespace');
    room
            server
                    socket.join('some room');
                    io.to('some room').emit('some event'):        # room广播
                    socket.leave('some room');
# 子模块
    socket.io-redis
        介绍
                用于从外部发消息，与socket.io-emitter一起使用
        使用
                var io = require('socket.io')(3000);
                var redis = require('socket.io-redis');
                io.adapter(redis({ host: 'localhost', port: 6379 }));
    socket.io-emitter
        介绍
                用于从外部发消息，与socket.io-redis一起使用
        使用
                var io = require('socket.io-emitter')();
                io.emit('time', new Date);
    socket.io-client
        介绍
                用于创建客户端来连接socket.io
        使用
                var iocl = require('socket.io-client');
                var socket = iocl.connect('127.0.0.1:5555');
                socket.on('connect', function(){
                
                });
