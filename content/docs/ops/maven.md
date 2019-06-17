---
Categories: ["运维"]
title: "Maven"
date: 2018-10-11T18:25:38+08:00
---

# repository包依赖关系网站
        mvnrepository.com
# 命令
    pom.xml生成项目命令        
            mvn
            mvn compile                        # mvn compile exec:java
    eclipse插件
            m2e
    得到jar包
            mvn dependency:copy-dependencies
    生成eclipse工程
            mvn eclipse:eclipse 
    jetty-plugin下运行
            mvn jetty:run
    版本
            mvn -version
# 方案
    ojdbc14本地加载
                    ＃ oracle是收费的，所以不能直接下载到驱动
            o-> mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.4.0 -Dpackaging=jar -Dfile=ojdbc14-10.2.0.4.0.jar
            o-> 把ojdbc14-10.2.0.4.0.jar复制到目录下: /home/outrun/.m2/repository/com/oracle/ojdbc14/10.2.0.4.0/
            o-> /home/outrun/.m2/repository/com/oracle/ojdbc14/下会产生maven-metadata-local.xml文件存放maven引入依赖
            o-> 项目中引入本地依赖
                    <dependency>
                            <groupId>com.oracle</groupId>
                            <artifactId>ojdbc14</artifactId>
                            <version>10.2.0.4.0</version>
                            </dependency>
