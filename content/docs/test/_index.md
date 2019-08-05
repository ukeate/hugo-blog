---
title: 测试
type: docs
---

# 基础
    分类
        功能测试
            黑盒
            灰盒              # 集成测试阶段，黑盒但关注程序内部
            白盒
        性能测试
            压力测试
            负载测试
            基准测试
                # 统计多少时间内执行了多少次某个方法
        回归测试
            # 改旧代码后，保证旧代码可用
        冒烟测试
            # 功能验证，不一定是改旧代码
    前端测试
        structure/behavior(数据结构/行为)问题
            # 判断是否有此耦合，用一个测试验证: 是否为应用逻辑编写一个单元测试而不需要dom结构存在
            ## angular中没有这种问题，因为所有定位元素和处理事件的工作都是在angular内部完成的
            ## 在测试时创建dom，就增加了测试的复杂性。而且页面变化时有更多维护要做。访问dom的操作很慢，测试反馈时间长

# cpu
    graph-frames
    subsecond offset

# 数据库
    sysbench
        # mysql 压测
        --db-driver=mysql --mysql-host=visitor-bench.ctysoosgzk4k.rds.cn-north-1.amazonaws.com.cn --mysql-user=root --mysql-password=12345678 --threads=512 --events=1000000 --time=0 --report-interval=15 ./bench_visit_page_insert.lua run
# 接口
## loadrunner
        脚本参数
            get
                web_url("login",
                    "URL=http://192.168.0.14:9081/ryx-login/sso/login",
                    "Resource=0",
                    "RecContentType=text/html",
                    "Referer=",
                    "Snapshot=t1.inf",
                    "Mode=HTML",
                    EXTRARES,
                    "Url=../ycls/img/banner1.jpg", ENDITEM,
                    "Url=../ycls/img/banner2.jpg", ENDITEM,
                    "Url=../ycls/img/banner3.jpg", ENDITEM,
                    "Url=../ycls/img/userinput.png", ENDITEM,
                    "Url=../ycls/img/sawtooth.png", ENDITEM,
                    "Url=../ycls/img/tip2.png", ENDITEM,
                    "Url=../ycls/img/pwdinput.png", ENDITEM,
                    "Url=../ycls/img/login_back.png", ENDITEM,
                    "Url=../ycls/img/tip1.png", ENDITEM,
                    "Url=../ycls/img/codeinput.png", ENDITEM,
                    "Url=../ycls/img/loading-small2.gif", ENDITEM,
                    "Url=/favicon.ico", "Referer=", ENDITEM,
                    LAST);

            post参数
                web_submit_data("getActivityParameter",
                    "Action=http://192.168.0.14:9081/tobacco/retail/lottery/getActivityParameter?jsonp=jQuery19109862107675272699_1401335732777",
                    "Method=POST",
                    "RecContentType=text/html",
                    "Referer=http://192.168.0.14:9081/tobacco/retail/index;jsessionid=7BBAFC6DE481FBCB1CB88D738BD7EE71",
                    "Snapshot=t6.inf",
                    "Mode=HTML",
                    ITEMDATA,
                    "Name=requestType", "Value=ajax", ENDITEM,
                    LAST);

            post直接传数据
                web_custom_request("dataservice",
                    "URL=http://202.110.222.207:7080/rtserver/rest/resource/tobacco/dataservice",
                    "Method=POST",
                    "Resource=0",
                    "RecContentType=text/plain",
                    "Referer=",
                    "Snapshot=t1.inf",
                    "Mode=HTML",
                    "Body= {\"trans_code\":\"1006\",\"end_date\":\"20140701\",\"source\":\"appkey\",\"data\":\"eyJiZWdpbl9kYXRlIjoiMjAxNDA2MDEiLCJlbmRfZGF0ZSI6IjIwMTQwNzAxIiwicG9zX2lkIjoiODg1MDAzMTAiLCJzb3VyY2UiOiJhcHBrZXkiLCJjdXN0b21lcl9pZCI6IjM3MDExMjEwNzQ2NyIsImFjY2Vzc190b2tlbiI6IiJ9\",\"begin_date\":\"20140601\",\"mac\":\"123\",\"pos_id\":\"88500310\",\"customer_id\":\"370112107467\",\"access_token\":\"\"}",
                    LAST);
## phoenix
        介绍
                web自动化测试工具
        特点
                分布式执行
                无脚本模式执行
                无人值守模式执行
                自定模式执行
        模块
                数据维护模块
        部署模式
                server-client
                        仅windows下可用
                        socket通信
                web部署
                        server与client放到tomcat或webLogic下部署
                        http通信
                        web页面控制与监控client端执行

    wireshark
    siege
            siege -c 200 -r 100 http://www.google.com
                    # 200并发，发送100次请求
    tcpcopy
            # 基于tcp packets的请求复制工具, 在线流量导入到测试系统中
    ab
            内网测试, apache自带的压力测试工具, 安装apache后在bin目录中找到
            ab -n1000 -c100 http://www.google.com/a.html
                    # 100并发, 发送1000次请求
    locust
            # 外网性能测试　
    http_load
            # 压测
            http_load -rate 5 -seconds 10 http://www.baidu.com
                    # -p 并发
                    # -f 总计访问数
                    # -r 每秒访问频率
                    # -s 总计访问时间
    yslow
            # firefox插件，网页性能测试工具
    jmeter
            # apache性能测试
    gatling
            # dsl脚本, 生成报表
    wrk
            # 压测
            wrk -R5000 -d10s "http://internal-rope-api-1875734411.cn-north-1.elb.amazonaws.com.cn/online_agents/1"
    swagger
            # 文档与测试用例
    fortio
            # istio压测工具
    hey
            # http压测
## js
    heapdump
            # 堆内存快照
    jslint
    supertest
            # 测http接口
    sinon.js
            # 非运行测试，延时测试等
    vows
            # asynchronous BDD(behaviour drven development) for Node
    chai
            # js断言
    mock.js
            # 模拟生成接口假数据
### benchmark
    介绍
            测试代码执行性能
    使用
            var Benchmark = require('benchmark');
            var suite = new Benchmark.Suite;

            var int1 = function(str){
                    return +str;
            };
            var int2 = function(str){
                    return parseInt(str, 10);
            };
            var int3 = function(str){
                    return Number(str);
            };
            // 开始测试
            var number = '100';
            suite
            .add('+', function(){
                    int1(number);
            });
            .add('parseInt', function(){
                    int2(number);
            });
            .add('Number', function(){
                    int3(number);
            });
            .on('cycle', function(event){        // 每个测试跑完后输出信息
                    console.log(String(event.target));
            })
            .on('complete', function(){
                    console.log('Fastest is' + this.filter('fastest').pluck('name'));
            })
            .run({'async': true});                    // 这里async与时间计算有关，默认为true
### travis
    介绍
        项目node版本测试，在基本依赖下跑
    使用
        在travis上授权仓库，每当push代码到github, 会自动跑测试
        配置根目录下的.travis.yml文件来配置测试内容，如
            language: node_js
            node_js:
            -'0.8'
            -'0.10'
            -'0.11'
            script: make test
            services:
                mongodb
                # 一个使用了mongodb的nodejs应用，用0.8、0.10、0.11三个版本来跑，跑测试的命令是make test
        travis测试的项目，可以得到一个图片地址，显示项目当前的测试通过状态，把这个图片添加到项目的README中
### jasmine
    介绍
        编写单元测试
    使用
        describe("A suite", function(){
            var foo;
            beforeEach(function(){
                    foo = 0;
                    foo += 1;
            });
            afterEach(function(){
                    foo = 0;
            });
            it("contains spec with an expectation", function(){
                    expect(true).toBe(true);
            });
        });
### should
    介绍
        兼容性测试
    安装
        npm install should --save-dev
    使用
    var should = require('should');

    user.should.have.property('name', 'jack')
        # should(user).have.property('name','jack');
    user.should.have.property('pets').with.lengthOf(4);
        # 判断数组
    should.not.exist(err);
    should.exist(result);
    result.bar.should.equal(foo);
    (5).should.be.exactly(5).and.be.a.Number();
    user.should.be.an.instanceOf(Object).and.have.property('name', 'jack');
    this.obj.should.have.property('id').which.is.a.Number();
### memwatch
    介绍
        监控内存leak, stats,leak在连续5次垃圾回收后内存没释放时触发, stats事件在垃圾回收时触发

    o-> 堆内存比较
    var memwatch = require('memwatch')
    var leakArray = []
    var leak = function () {
        leakArray.push('leak' + Math.random())
    }
    var hd = new memwatch.HeapDiff()
    for (var i = 0; i < 10000; i++) {
        leak()
    }

    var diff = hd.end()
    console.log(JSON.stringify(diff, null, 2))
### muk
    var muk = require('muk')
    before(function () {
        muk(fs, 'readFileSync', function (path, encoding) {
            throw new Error('mock readFileSync error')
        })
        muk(fs, 'readFile', function (path, encoding, callback) {
            process.nextTick(function () {
                # 模拟异步
                callback(new Error('mock readFile error'))
            })
        })
    })

    after(function () {
        muk.restore()
    })
### rewire
    介绍
        测试私有方法

    o->
    it('limit should return success', function () {
        var lib = rewire('../lib/index.js')
        var litmit = lib.__get__('limit')
        litmit(10).should.be.equal(10)
    })
### mocha
    介绍
        单元测试框架
    命令
        mocha
            # --reporters 查看所有报告样式, 默认dot, 常用spec, json, html-cov
            # -R <reporter>采用某报告样式
            # -t <ms>设置超时时间
    使用
        npm install -g mocha
        // package.json
        {
            "scripts": {
                "test": "mocha test"
                "blanket": {
                    "pattern": "//^((?!(node_modules|test)).)*$/",
                    "data-cover-flags": {
                        "debug": false
                    }
                }
            }
        }
        mocha test

    o-> bdd风格
    describe('Array', function() {
        before(function() {})
            # 钩子函数还有after, beforeEach, afterEach
        it('should return -1 when not present', function (done) {
            [1,2,3].indexOf(4).should.equal(-1)
            this.timeout(500)
                # 500ms后超时
            done()
                # 用done来测试异步
        })
    })

    o-> bdd风格
    suite('Array', function() {
        setup(function () {})
            # 钩子函数还有teardown
        suite('$indexOf()', function () {
            test('should return -1 when not present', function() {
                assert.equal(-1, [1,2,3].indexOf(4))
            })
        })
    })
### istanbul
    介绍
        名字是依斯坦布尔，用来白盒覆盖用例测试
        支持的use cases有unit tests, browser tests, server side code embedding
    使用
        instanbul cover test.js
### phantomjs
    介绍
        前端测试工具
        webkit js测试工具，支持多web标准, dom, css, json, canvas和svg
    o-> 使用1
        npm install mocha-phantomjs
        mocha-phantomjs index.html

    o-> 使用2
        phantomjs hello.js

        // hello.js
        console.log('Hello, world');
        phantom.exit();
### browserstack
    介绍
        前端测试工具
        内建webdriver的api
    使用
        npm install browserstack-runner --save-dev
        ./node_modules/.bin/browserstack-runner init
        // browserstack.json
            "test_framework": "mocha",
            "timeout": 60,
            "test_path": "public/index.html"
        https://www.browserstack.com/accounts/automate
            得到username 和 access key
            复制到browserstack.json中的username和key
        browserstack-runner
        https://www.browserstack.com/automate 查看结果
### karma
    介绍
        是google Testacular的新名字，自动化完成单元测试
    使用
        npm install -g karma
        karma start
        karma init
            # 初始化karma配置文件
        npm install karma-jasmine
### jscover
    介绍
        覆盖率测试
    使用
        npm install jscover -g
        jscover lib lib-cov
            # 把lib下的源码编译到lib-cov下，新代码在每一行加上了执行次数统计
        index.js中
            module.exports = process.env.LIB_COV ? require('./lib-cov/index') : require('./lib/index')
        export LIB_COV=1
        mocha -R html-cov > coverage.html
            # 生成结果
### blanket
    介绍
        比jscover更好的测试工具
    使用
        package.json中
            "scripts": {
                "blanket": {
                    "pattern": "eventproxy/lib"
                        # 要测试的源码目录
                }
            }
        mocha --require blanket -R html-cov > coverage.html
## python
    nose
        # 注解测试
    selenium
        # 自动化测试
# 页面
    jsperf
        # js性能分析
    jasmine
        # js单元测试
# 移动
    robotium
        # android自动化测试

