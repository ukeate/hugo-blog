---
Categories : ["后端"]
title: "Cxf"
date: 2018-10-11T15:19:10+08:00
---

# 常识
        自己内部整合spring(但是不耦合)
# 支持的协议
        soap1.1/1.2 
        post/http 
        restful 
        http
# 使用
        导入cxf包
        方法1      # 不支持注解
            String address="http://localhost:8888/hello";
                ServerFactoryBean factoryBean=new ServerFactoryBean();
                factoryBean.setAddress(address);
                factoryBean.setServiceBean(new MyWS());
                factoryBean.create();
        方法2      # 支持注解,wsdl文件中类型不再单独schema文件
            ServerFactoryBean factoryBean = new JaxWsServerFactoryBean      # java and xml web service
        日志        # 记录握手信息(访问wsdl文件)
                    ## 看日志记录得到 soap
                serverFactoryBean.getInInterceptors().add(new LoggingInInterceptor());
                serverFactoryBean.getOutInterceptors().add(new LoggingOutInterceptor());
# 整合spring
        o-> cxf2.4.4.jar/schemas/jaxws.xsd中找到命名空间"http://cxf.apache.org/jaxws" 
        o-> 配置applicationContext.xml，加入cxf的命名空间http://cxf.apache.org/jaxws,schema地址为http://cxf.apache.org/schemas/jaxws.xsd。
                并且在eclipse中配置schema约束文件的路径
                                                # 该xsd约束文件的url地址用的是包地址,不规范
        o-> applicationContext.xml中配置
                <bean id="studentService" class="test.spring.StudentServiceImpl"/>
                        # 用于：自身调用，被spring引用
                <jaxws:server serviceClass="test.spring.StudentService" address="/student">
                        # address配置服务的名称即可(web.xml的servlet中配置了服务的实际访问地址)
                        ## serviceClass配置的才是真正的服务，既然它是接口，那么webService注解也应该写在接口上
                        <jaxws:serviceBean>
                                <ref bean="studentService"/>
                        <jaxws:inInterceptors>
                                <bean class="org.apache.cxf.interceptor.LoggingInInterceptor" />
                        <jaxws:outInterceptors>
                                <bean class="org.apache.cxf.interceptor.LoggingOutInterceptor" />
        o-> web.xml中配置servlet
                 <servlet>
                          <servlet-name>springWS
                          <servlet-class>org.apache.cxf.transport.servlet.CXFServlet        # 在cxf-2.4.4.jar包中
                          <load-on-startup>1
                 <servlet-mapping>
                          <servlet-name>springWS
                          <url-pattern>/ws/*
        o-> web.xml中配置spring监听器

