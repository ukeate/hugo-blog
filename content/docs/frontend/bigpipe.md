---
Categories : ["前端"]
title: "Bigpipe"
date: 2018-10-11T07:54:00+08:00
---

# 介绍
    facebook的页面异步加载框架
    不同于ajax的http调用，需要更多的网线连接。bigpipe与当前页面共用http连接

# 使用
    前端
        <script src="jquery.js"></script>
        <script src="underscore.js"></script>
        <script src="bigpipe.js"></script>
        <div id="body"></div>
        <script type="text/template" id="tpl_body">
                <div><%=articles%></div>
        </script>
        <script>
        var bigpipe = new Bigpipe()
        bigpipe.ready('articles', function(data) {
                $('#body').html(_.render($('#tpl_body').html(), {articles: data}))
        })
        </script>

    服务器端
        app.get('/profile', function (req, res) {
                if (!cache[layout]) {
                        cache[layout] = fs.readFileSync(path.join(VIEW_FOLDER, layout), 'utf8')
                }
                res.writeHead(200, {'Content-Type': 'text/html'})
                res.write(render(complie(cache[layout])))
                ep.all('users', 'articles', function () {
                        res.end()
                })
                ep.fail(function(err) {
                        res.end()
                })
                db.getData('sql1', function (err, data) {
                        data = err ? {} : data
                        res.write('<script>bigpipe.set("articles", ' + JSON.stringify(data) + ');</script>')
                })
        })

    nodejs使用
        'use strict'
        var BigPipe = require('bigpipe');
        var bigpipe = BigPipe.createServer(8080, {
                pagelets: __dirname + '/pagelets',
                        # 页面路径
                dist: __dirname + '/dist'
                        # 静态资源路径
        });        
        o-> 开启https
        var bigpipe = BigPipe.createServer(443, {
                key: fs.readFileSync(__dirname + '/ssl.key', 'utf-8'),
                cert: fs.readFileSync(__dirname + '/ssl.cert', 'utf-8')
        });
        o-> 嫁接
        var server = require('http').createServer(),
                BigPipe = require('bigpipe');
        var bigpipe = new BIgPipe(server, {options});
        bigpipe.listen(8080, function listening(){
                console.log('listening on port 8080.');
        });

        bigpipe.define('../pagelets', function done(err){
        });        # 合并pagelets, 结束后调用done
        o-> AMD 方式define，与链式编程
        bigpipe.define([Pagelet1, Pagelet2, Pagelet3], function done(err){
        }).define('../more/pagelets', function done(err){});
        # bigpipe.before来添加中间件, remove来删除中间件, disable、enable来跳过和重新启用中间件
        # bigpipe.use来引用插件
# api
    BigPipe所有组件继承EventEmitter interface
# 功能
    pagelets
        var Pagelet = require('bigpipe').Pagelet;
                # var Pagelet = require('pagelet');
        Pagelet.extend({
                js: 'client.js',
                css: 'sidebar.styl',
                view: 'templ.jade',
                name: 'sidebar‘,            // 唯一路由路径
                get: function get(){
                        // 接收get请求时的业务逻辑
                }
        }).on(module);
                # 自动写 module.export部分来导出
        # traverse方法自动调用来递归找additional child pagelets, 要手动指定名称时手动调用
        