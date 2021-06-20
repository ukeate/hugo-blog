---
Categories : ["后端"]
title: "Spring Cloud"
date: 2018-10-11T10:33:48+08:00
---
# 亿级流量
## 流量接入层
    二级域名
        泛域名
        A记录
    dns解析
        udp
            向网关请求dns解析
        httpDNS
            用ip请求http服务, 返回域名解析的ip
            因为用ip请求，适合app，不适合网页
    lvs + keepalive             # 多lvs时用dns负载
    nginx
        openresty
            kong
    动静分离
        cdn
            dns动态域名解析
            cdn分发服务
                源服务拉取FastDFS
                CDN节点分发
## WEB服务层
    webflux
        不基于重量的servlet标准
        基于netty
# Eureka
    使用
        @EnableEurekaServer
        application.properties
            eureka.client.register-with-eureka=false                # 是否注册自己
            eureka.client.fetch-registry=false                      # 是否拉取eureka
            eureka.client.service-url.defaultZone=http://localhost:7900/eureka/         # 设置注册中心的URL
            eureka.instance.hostname=euk1.com
            spring.application.name=EurekeServer                    # eureka集群中各节点要同名
    行为
        register                    # 注册
        renew                       # 通过心跳, 默认30s。三次失败删除实例
        fetch registry              # 拉注册的信息
        cancel                      # 发取消请求，删除实例
        time lag                    # 同步时间延迟
        communication mechanism     # 通讯机制，默认jersey和jackson
    功能
        唯一标识                        # service id
            主机名:application.name:端口
        提供RestAPI, 可多终端接入
    问题
        一致性问题方案
            Eureka间不同步，client向多个Eureka提交
            Enreka间同步，Eureka强可用性弱一致性
# 基础
    介绍
        spring boot基础上构建，快速构建分布式系统, 全家桶
        面向云环境架构(云原生)    # 适合在docker和paas部署
    功能
        配置管理
        服务发现
        熔断
        智能路由
        微代理
        控制总线
        全局锁
        决策竞选
        分布式会话
        集群状态管理
    子项目
        spring cloud netflix    # 对netflix oss套件整合
            eureka     # 服务治理(注册、发现)
            hystrix    # 容错管理
            ribbon     # 软负载均衡(客户端)
            feign      # 基于hystrix和ribbon，服务调用组件
            zuul       # 网关，智能路由、访问过滤
            archaius   # 外部化配置
        基础
            spring cloud starters       # 基础依赖, 高版本取消
            spring cloud commons
        服务
            spring cloud consul         # 封装consul(服务发现与配置, 与docker无缝)
            spring cloud cluster        # 抽象zookeeper, redis, hazelcast, consul的选举算法和通用状态模式实现接口
            spring cloud cloudfoundry   # 与pivotal cloudfoundry整合
            spring cloud aws            # 整合aws
            spring cloud zookeeper      # 整合zookeeper
            spring cloud cli            # groovy中快速创建应用
            spring cloud task           # 任务
        配置
            spring cloud config         # 应用配置外部化, 推送客户端配置, 支持git存储
        消息
            spring cloud bus            # 消息总线，传播集群状态变化来触发动作，如刷新配置
            spring cloud stream         # 声明式发送、接收消息
        监控
            spring cloud sleuth         # 跟踪
        安全
            spring cloud security       # 应用安全控制, zuul代理中OAuth2中继器
        测试
            spring cloud contract       # 契约测试, 可用groovy和yaml定义
    版本
        用命名不用版本号，因为有多子项目版本，易混淆
        命名用伦敦地铁站用，字母表排序
    缺点
        难于追查框架问题
        非二进制通信协议
        适合中小团队
# 配置
    pom.xml
        <modules>
            <module>spring-cloud-common</module>
            <module>spring-cloud-provider-book</module>
            <module>spring-cloud-service-discovery</module>
            <module>spring-cloud-api-gateway</module>
            <module>spring-cloud-consumer-book</module>
            <module>spring-cloud-monitor-dashboard</module>
            <module>spring-cloud-aggregator</module>
            <module>spring-cloud-zipkin-server</module>
            <module>spring-cloud-admin-server</module>
            <module>spring-cloud-config-server</module>
        </modules>
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>
            <relativePath/>
        </parent>
        <dependencyManagement>
            <dependencies>
                <dependency>
                    <groupId>org.springframework.cloud</groupId>
                    <artifactId>spring-cloud-dependencies</artifactId>
                    <version>Edgware.SR3</version>
                    <type>pom</type>
                    <scope>import</scope>
                </dependency>
            </dependencies>
        </dependencyManagement>
        <repositories>
            <repository>
                <id>spring-releases</id>
                <url>https://repo.spring.io/libs-release</url>
            </repository>
        </repositories>
        <pluginRepositories>
            <pluginRepository>
                <id>spring-releases</id>
                <url>https://repo.spring.io/libs-release</url>
            </pluginRepository>
        </pluginRepositories>
    application.yml
        spring:
            profiles: peer1                         # bean的逻辑组
# 组件
    dependencyManagement
        spring-cloud-dependencies
# spring cloud spring boot
# spring cloud eureka
    原理
        生产者向eureka注册, 周期发送心跳(默认30s)
        eureka服务间同步注册信息
        消费者请求地址，缓存本地
        eurake接收生产者心跳超时, 设置为down, 推送状态到消费者
        eurake短期down过多生产者，进入自我保护不再down
    组件
        spring-cloud-starter-[netflix-]eureka-server

    application.yml
        eureka:
            instance:
                hostname: localhost                 # 实例主机名
            client:
                registerWithEureka: false           # 当前服务不注册
                fetchRegistry: false                # 不获取注册信息
                serviceUrl:                         # server地址
                    defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
    bootstrap.yml                                   # 基础配置, 待拉取config

    注解
        @EnableEurekaServer                         # 修饰Application类
# spring cloud ribbon
    application.yml
        ribbon:
            eureka:
                enabled: false                      # 禁止从eureka获得注册列表
# spring cloud hystrix
    # 单个服务监控
    hystrix dashboard
        路径
            /hystrix
            /hystrix.stream                         # 至少请求一次接口，才有数据
# spring cloud turbine
    # 多服务监控
    application.yml
        turbine:
            aggregator:
                clusterConfig: default                                  # 此监控器名
            appConfig: erp-consumer-metadb, erp-consumer                # 目标服务名
            clusterNameExpression: new String("default")                # 名称匹配表达式
    路径
        /turbine.stream
# spring cloud feign
    application.yml
        feign:
            hystrix:
                enabled: true
# spring cloud zuul
    # 默认会用ribbon负载均衡
    application.yml
        zuul:
            prefix: /v1
            routes:
                hiapi:
                    path: /hiapi/**
                    serviceId: erp-consumer-metadb
                    # url: http://localhost:8762  # 这样写不会做负载均衡
                    # serviceId: hiapi-v1

        ## 手动url负载均衡
        # ribbon: 
        #   eureka:
        #     enabled: false
        # hiapi-v1:
        #   ribbon:
        #     listOfServers: http://localhost:8762,http://localhost:8763
    案例
        过滤
            import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;
            @Component
            public class MyFilter extends ZuulFilter {

                private static Logger log = LoggerFactory.getLogger(MyFilter.class);

                @Override
                public String filterType() {
                    return PRE_TYPE;
                }

                @Override
                public int filterOrder() {
                    return 0;
                }

                @Override
                public boolean shouldFilter() {
                    return true;
                }

                @Override
                public Object run() {
                    RequestContext ctx = RequestContext.getCurrentContext();
                    HttpServletRequest request = ctx.getRequest();
                    log.info(String.format("%s >>> %s", request.getMethod(), request.getRequestURL().toString()));
                    Object accessToken = request.getParameter("token");
                    if (accessToken == null) {
                        log.warn("token is empty");
            //
            //            ctx.setSendZuulResponse(false);
            //            ctx.setResponseStatusCode(401);
            //            try {
            //                ctx.getResponse().getWriter().write("token is empty");
            //            }catch (Exception e){
            //
            //            }
                        return null;
                    }
                    log.info("ok");
                    return null;
                }
            }
        熔断
            @Component
            public class MyFallbackProvider implements ZuulFallbackProvider {
                @Override
                public String getRoute() {
                    return "*";
                }

                @Override
                public ClientHttpResponse fallbackResponse() {
                    return new ClientHttpResponse() {
                        @Override
                        public HttpStatus getStatusCode() throws IOException {
                            return HttpStatus.OK;
                        }

                        @Override
                        public int getRawStatusCode() throws IOException {
                            return 200;
                        }

                        @Override
                        public String getStatusText() throws IOException {
                            return "OK";
                        }

                        @Override
                        public void close() {

                        }

                        @Override
                        public InputStream getBody() throws IOException {
                            return new ByteArrayInputStream("error, I'm the fallback".getBytes());
                        }

                        @Override
                        public HttpHeaders getHeaders() {
                            HttpHeaders headers = new HttpHeaders();
                            headers.setContentType(MediaType.APPLICATION_JSON);
                            return headers;
                        }
                    };
                }
            }

# spring cloud config
    config-server
        application.yml
            server:
                port: 9012
            spring:
                application:
                    name: erp-config-server
                cloud:
                    config:
                    server:
                        native:
                            search-locations: classpath:/shared             # 读取路径
                profiles:
                    active: native                                          # 本地读取
        shared/config-client-dev.yml                                        # 文件名为 [客户端服务名]-[profile变量]
            server:
                port: 9013
            foo: foo version 1
        地址
            localhost:9012/config-client/dev                                # 查看分发给服务的配置
    config-client
        spring:
            application:
                name: erp-config-client
            cloud:
                config:
                    uri: http://localhost:9012
                    fail-fast: true
            profiles:
                active: dev
    注解
        @RefreshScope                           # 热更新
# spring cloud bus
    application.yml
        spring:
            rabbitmq:
                host: localhost
                port: 5672
                username: outrun
                password: asdf
                publisher-confirms: true
                virtual-host: /
        management:
            security:
                enabled: false
    路径
        POST /bus/refresh                       # 从新拉配置, 其它服务也触发同步
            ?destination=appName:*.*            # 指定刷新服务名下实例
# spring cloud stream
# spring cloud sleuth
    application.yml
        zipkin:
            base-url: http://localhost:9014
        sleuth:
            sampler:
                percentage: 1.0
