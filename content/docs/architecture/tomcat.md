---
Categories : ["架构"]
title: "Tomcat"
date: 2018-10-11T16:27:32+08:00
---

# 介绍
        tomcat从7开始默认就是nio的
# 配置
    bin/startup.bat
            set JAVA_HOME=
                            # 设置tomcat运行jdk
    context.xml
        <Loader delegate="true"/>
                # true表示使用java加载器的代理模式
                ## false代表永远先在Web应用程序中寻找
    web.xml
        Content-Type: text/x-zim-wiki
        Wiki-Format: zim 0.4
        Creation-Date: 2013-08-04T19:40:08+08:00

        ====== web.xml文件 ======
        Created Sunday 04 August 2013

        <servlet>
                <servlet-name>
                <servlet-class>
                <load-on-startup>1
                <init-param>
                        <param-name>
                        <param-value>
        <servlet-mapping>
                <servlet-name>
                <url-pattern>
                
        <welcome-file-list>
                <welcome-file>

        <filter>
                <filter-name>
                <filter-class>
                <init-param>
        <filter-mapping>
                <filter-name>
                <url-pattern>

        <mime-mapping>
                <extension>bmp
                <mime-type>image/bmp

        <error-page>
                <exception-type>异常类的完全限定名 /<error-code>错误码
                <location>以“/”开头的错误处理页面路径
                
# 启动顺序
    web.xml中配置的启动顺序
            监听器
            过滤器
            servlet
                    load-on-startup属性值越小越先启动

    tomcat的加载过程：        # 分析启动日志得到
            启动http协议
            启动catalina
            启动servlet引擎
            加载xml配置文件
            初始化日志配置
            初始化ContextListener
            初始化SessionListener
            部署web项目
                    spring监听器，加载xml配置(开始spring自己的日志记录)
                            实例化bean                
                                    初始化c3p0连接池的记录显示
                                    初始化LocalSessionFactoryBean的记录显示
                    application监听器(监听器按配置顺序启动)
                    struts过滤器，加载xml配置(开始struts自己的日志记录)
                            struts-default.xml
                                    根据其中配置的bean属性加载类，并记录了日志
                            struts-plugin.xml                # 里面有加载spring-struts-plugin包
                                    初始化struts-spring 集成
                            struts.xml
# 目录
    LICENSE
    NOTICE
    RELEASE-NOTES
    RUNNING.txt
    bin
            bootstrap.jar
            commons-daemon.jar
            tomcat-juli.jar
            tomcat-native.tar.gz
            commons-daemon-native.tar.gz
            catalina.bat
            shutdown.bat
            startup.bat
            cpappend.bat
            digest.bat
            setclasspath.bat
            tool-wrapper.bat
            version.bat
            catalina.sh
            shutdown.sh
            startup.sh
            digest.sh
            setclasspath.sh
            tool-wrapper.sh
            version.sh
            catalina-tasks.xml
    conf
            catalina.policy
            catalina.properties
            logging.properties
            context.xml
            server.xml
            tomcat-users.xml
            web.xml
            Catalina
                    localhost
                            host-manager.xml
                            manager.xml
    lib
            annotations-api.jar
            catalina.jar
            catalina-ant.jar
            catalina-ha.jar
            catalina-tribes.jar
            el-api.jar
            jasper.jar
            jasper-el.jar
            jasper-jdt.jar
            jsp-api.jar
            servlet-api.jar
            tomcat-coyote.jar
            tomcat-dbcp.jar
            tomcat-i18n-es.jar
            tomcat-i18n-fr.jar
            tomcat-i18n-ja.jar
    log
            catalina.2013-07-28.log等等
    webapps
            ROOT
                    WEB-INF
                            web.xml
            docs
            examples
            manager
            host-manager
    tmp
    work

    发布
            conf/server.xml 中8080端口 位置
            <Context path="/bbs" reloadable="true" docBase="E:\workspace\bbs" workDir="E:\workspace\bbs\work" />
            
    发布war文件：
            localhost:8080 -> tomcat manager -> WAR file to deploy
