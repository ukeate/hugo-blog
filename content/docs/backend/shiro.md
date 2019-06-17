---
Categories : ["后端"]
title: "Shiro"
date: 2018-10-11T15:12:44+08:00
---
# 功能
    Authenticator                        # SecurityManager继承Authenticator
            public AuthenticationInfo authenticate(AuthenticationToken authenticationToken)  throws AuthenticationException;   
    permission
        概念
                subject
                resource
                permission
                role
                        隐式角色
                        显示角色
        配置
                shiro.ini
                        [users]
                        zhang=123, role1, role2                # 用户名=密码, 角色1, 角色2
        判断角色
                o->
                        subject.hasRole("admin");
                o->
                        @RequiresRoles("admin")
                        @RequiresRoles(value={“admin”, “user”}, logical= Logical.AND)  
                                # 表示当前Subject需要角色admin和user。
                o->
                        <shiro:hasRole name="admin"></shiro:hasRole>
        权限注解
                @RequiresAuthentication  
                        # 表示当前Subject已经通过login进行了身份验证；即Subject. isAuthenticated()返回true。
                @RequiresUser  
                        # 表示当前Subject已经身份验证或者通过记住我登录的。
                @RequiresGuest  
                        # 表示当前Subject没有身份验证或通过记住我登录过，即是游客身份。 
                @RequiresPermissions (value={“user:a”, “user:b”}, logical= Logical.OR)  
                        # 表示当前Subject需要权限user:a或user:b。
    credential
        散列
                String str = "hello";  
                String salt = "123";  
                //内部使用MessageDigest  
                String simpleHash 
        密码生成工具
                //输入明文密码得到密文密码
                String encryptPassword(Object plaintextPassword) throws IllegalArgumentException;  
                //匹配用户输入的token的凭证（未加密）与系统提供的凭证（已加密）  
                boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info);  
    filter
        NameableFilter                        ＃根据名字找到相应的拦截器实例
        OncePerRequestFilter                # 控制开启、关闭拦截器实例
        ShiroFilter                        # 安全控制
        AdviceFilter                        # aop
                preHandle                        # 前置增强
                postHandle                        # 后置增强
                afterCompletion                # 后置最终增强(异常也执行，相当于finally的概念)
        PathMatchingFilter                # 匹配请求路径
        AccessControlFilter                # 允许或拒绝访问，拒绝时如何处理
    jsp标签
        <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

        <shiro:guest>  
        欢迎游客访问，<a href="${pageContext.request.contextPath}/login.jsp">登录</a>  
        </shiro:guest>   

        <shiro:user>  
        欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>  
        </shiro:user> 
                        # 用户已经身份验证/记住我登录后显示相应的信息。

        <shiro:authenticated>  
            用户[<shiro:principal/>]已身份验证通过  
        </shiro:authenticated> 
                        # 用户已经身份验证通过，即Subject.login登录成功，不是记住我登录的。

        <shiro:notAuthenticated>
            未身份验证（包括记住我）
        </shiro:notAuthenticated> 
                        # 用户已经身份验证通过，即没有调用Subject.login进行登录，包括记住我自动登录的也属于未进行身份验证。

        <shiro: principal/>
                        # 显示用户身份信息，默认调用Subject.getPrincipal()获取
                <shiro:principal type="java.lang.String"/>
                <shiro:principal property="username"/>  

        <shiro:hasRole name="admin">  
            用户[<shiro:principal/>]拥有角色admin<br/>  
        </shiro:hasRole> 

        <shiro:hasAnyRoles name="admin,user">  
            用户[<shiro:principal/>]拥有角色admin或user<br/>  
        </shiro:hasAnyRoles>   

        <shiro:lacksRole name="abc">  
            用户[<shiro:principal/>]没有角色abc<br/>  
        </shiro:lacksRole> 
                        # 如果当前Subject没有角色将显示body体内容。

        <shiro:hasPermission name="user:create">  
            用户[<shiro:principal/>]拥有权限user:create<br/>  
        </shiro:hasPermission>

        <shiro:lacksPermission name="org:create">  
            用户[<shiro:principal/>]没有权限org:create<br/>  
        </shiro:lacksPermission>  
    session
        得到会话
                login("classpath:shiro.ini", "zhang", "123");  
                Subject subject = SecurityUtils.getSubject();  
                Session session = subject.getSession(); 
        api
                Session
                        getId()                        
                        getHost()                # 调用HostAuthenticationToken.getHost(), 得到主机地址
                        getTimeout()
                        setTimeout(1000)
                        getStartTimestamp()
                        setLastAccessTime()
                        touch()                        # 更新会话最后访问时间
                        stop()                        # 销毁会话, Subject.logout()与HttpSession.invalidate()会自动调用该api
                        setAttribute("key", "123")
                        getAttribute("key")
                        removeAttribute("key")
                SecurityManager
                        Session start(SessionContext context)
                        Session getSession(SessionKey key) throws SessionException
                WebSessionManager
                        boolean isServletContainerSessions();                # 是否使用Servlet容器的会话
                ValidatingSessionManager
                        void validateSessions();                                # 验证所有会话是否过期 
    cache
        接口
                Cach<K, V>
                CacheManager
                CacheManagerAware
        ini配置
                userRealm.cachingEnabled                        # 启用缓存，默认false
                userRealm.authenticationCachingEnabled        # 启用身份验证缓存，即缓存AuthenticationInfo信息，默认false
                userRealm.authenticationCacheName                # 缓存AuthenticationInfo信息的缓存名称
                userRealm. authorizationCachingEnabled        # 启用授权缓存，即缓存AuthorizationInfo信息，默认false
                userRealm. authorizationCacheName                # 缓存AuthorizationInfo信息的缓存名称
                securityManager.realms=$userRealm  
        
                cacheManager=org.apache.shiro.cache.ehcache.EhCacheManager  
                cacheManager.cacheManagerConfigFile=classpath:shiro-ehcache.xml  
                securityManager.cacheManager=$cacheManager 

                sessionManager=org.apache.shiro.session.mgt.DefaultSessionManager  
                securityManager.sessionManager=$sessionManager 
    rememberme
    ssl
        o-> keytool -genkey -keystore "D:\localhost.keystore" -alias localhost -keyalg RSA
                # jdk自带的生成证书工具(包含证书/公钥/私钥）
        o-> 设置tomcat server.xml
                <Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"  
                maxThreads="150" scheme="https" secure="true"  
                clientAuth="false" sslProtocol="TLS"   
                keystoreFile="D:\localhost.keystore" keystorePass="123456"/> 
        o-> 
    jasig cas
# api
    Subject: 主体, 如用户
    SecurityManager: 安全管理器, 管理subject
    Realm: 权限数据域

    授权
            对象流程
                    Subject.isPermitted -> SecurityManager -> Authorizer
            对象
                    ModularRealmAuthorizer        # 多realm授权
                    PermissionResolver                # 解析权限字符串到Permission实例
                    RolePermissionResolver                # 从角色得到权限集合
# 配置
## 参数
    filterChainDefinitions
            rest：比如/admins/user/**=rest[user],根据请求的方法，相当于/admins/user/**=perms[user：method] ,其中method为post，get，delete等。

            port：比如/admins/user/**=port[8081],当请求的url的端口不是8081是跳转到schemal：//serverName：8081?queryString,其中schmal是协议http或https等，serverName是你访问的host,8081是url配置里port的端口，queryString是你访问的url里的？后面的参数。

            perms：比如/admins/user/**=perms[user：add：*],perms参数可以写多个，多个时必须加上引号，并且参数之间用逗号分割，比如/admins/user/**=perms["user：add：*,user：modify：*"]，当有多个参数时必须每个参数都通过才通过，想当于isPermitedAll()方法。

            roles：比如/admins/user/**=roles[admin],参数可以写多个，多个时必须加上引号，并且参数之间用逗号分割，当有多个参数时，比如/admins/user/**=roles["admin,guest"],每个参数通过才算通过，相当于hasAllRoles()方法。

            anon：比如/admins/**=anon 没有参数，表示可以匿名使用。

            authc：比如/admins/user/**=authc表示需要认证才能使用，没有参数

            authcBasic：比如/admins/user/**=authcBasic没有参数表示httpBasic认证

            ssl：比如/admins/user/**=ssl没有参数，表示安全的url请求，协议为https

            user：比如/admins/user/**=user没有参数表示必须存在用户，当登入操作时不做检查
                    # remember me可登录
