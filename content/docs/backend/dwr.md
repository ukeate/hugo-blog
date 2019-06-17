---
Categories : ["后端"]
title: "Dwr"
date: 2018-10-11T15:18:33+08:00
---

# 介绍
        java函数通过ajax映射到前端js调用
# 使用
    ajax框架
    1.导入jar包 dwr.jar
    2.web-inf/下的配置文件
            web.xml文件 
                    <servlet>
                            <servlet-name>dwr-invoker</servlet-name>
                            <servlet-class>org.directwebremoting.servlet.DwrServlet</servlet-class>
                                    # 固定写法
                            <init-param>
                                    <param-name>debug</param-name>
                                    <param-value>true</param-value>
                            </init-param>
                            <init-param>
                                    <param-name>scriptCompressed</param-name>        # 允许在javascript中执行
                                    <param-value>false</param-value>
                            </init-param>
                            <load-on-startup>1</load-on-startup>        # web工程启动时加载
                    </servlet>
                    <servlet-mapping>
                            <servlet-name>dwr-invoker</servlet-name>
                            <url-pattern>/dwr/*</url-pattern>
                    </servlet-mapping>
            dwr.xml文件
                    <dwr>
                            <allow>
                                    <create creator="new" javascript="DWRUserAccess">        # 生成js文件的名（页面中引用）
                                            <param name="class" value="outrun.dwr.DWRUserAccess" />                # 曝露的类
                                    </create>
                                    <convert converter="bean" match="outrun.dwr.User" />        # 注册实体类，可以在js中进行实例化
                            </allow>
                    </dwr>
    3.写outrun.dwr.DWRUserAccess中的方法

    4.页面调用
            test.html
                    <script src="/outrun/dwr/engine.js"></script>
                    <script src="/outrun/dwr/util.js"></script>
                    <script src="/outrun/dwr/interface/DWRUserAccess.js"></script> 
                    <SCRIPT LANGUAGE="JavaScript">
                            DWRUserAccess.方法(参数,执行完运行的js函数)                # 参数可以是一个map,如
                                                                                                                    var userMap = {};
                                                                                                                    userMap.id = regForm.id.value;
                                                                                                                    userMap.password = regForm.password.value;
                                                                                                                    userMap.name = regForm.name.value;
                                                                                                                    userMap.email = regForm.email.value;
                                                                                                                    DWRUserAccess.save(userMap, saveFun);
                                                                                                                            # 其中的regForm是页面中的表单（的name属性,dom支持直接使用名字引用表单） 
                    </SCRIPT>
