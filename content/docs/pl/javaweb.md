---
Categories: ["语言"]
title: "JavaWeb"
date: 2018-10-09T08:48:07+08:00
---
# 分层
    示意
    层    |视图层     -->    | 控制层（）     -->     |业务层     -->    |dao数据访问层对象    -->    |数据库
    技术      |jsp(c:forEach)   |servlet获取list域       |service过滤数据   |封装对象List           |
    对象      |bean销毁      |               |        |创建bean           |
    业务      |web服务器tomcat   |               |         |              |存储过程（银行）

    java web 13种技术
    JDBC        Java Database Connectivty
    JNDI        Java Name and Directory Interface
    EJB        Enterprise JavaBean
    RMI        Remote Method Invoke
    Java IDL/CORBA
    JSP        Java Server Pages
    Java Servlet    
    XML        Extensible Markup Language
    JMS        Java Message Service
    JTS        Java Transaction Service
    JTA        Java Transaction Architecture
    JavaMail
    JAF        JavaBeans Activation Framework
# 框架

    spring site
    # 整合框架
    tapestry
    # 基于servlet的mvc框架
    titles
    # apache的标签库
    jersey
    # restful服务
    guice
    # google的ioc轻量框架
    ehcache
    # 缓存
    httpclient
    httpComponents
    ejb
    # 会话bean, 实体bean, 消息驱动bean
    proguard
    # 混淆
    i18n

# 监听器

    启动顺序
    先启动监听器，再启动过滤器

    ServletContextListener
    ServletContextAttributeListener
    HttpSessionListener
    HttpSessionAttributeListener
    HttpSessionActivationListener

    web.xml 文件中在过滤器后面，servlet 前面
    <listener> 
    <listener-class>cn.listen.MyListener</listener-class>
    </listener> 
    
    编写类文件
    public class MyListener implements ServletContextListener {
        public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("die");
        }
        public void contextInitialized(ServletContextEvent sce) {
        System.out.println("init"); 
        }

    // 当过滤器被销毁时自动执行    
    public void destroy(){
        System.out.println("Filterdestroyed");
    }
    // 当拦截的时候
    public void doFilter(request,response,chain){
        System.out.println("doFilter");
        System.out.println("放行目标资源");
        chain.doFilter(request,response);
        System.out.println("目标已经放行");
    }
    // 初始化的时候
    public void init(FilterConfig config){
        System.out.println("FilterInited");
    }
    }

    web.xml
    <filter>
        <filter-name>testFilter
        <filter-class>cn.itcast.filter.text.TestFilter
    </filter>
    <filter-mapping>
        <filter-name>testFilter
        <url-pattern>/*
    
    Filter接口、FilterConfig和FilterChain类
    Filter接口  # 实现过滤器的接口方法,一个web项目中可以实现多个过滤器
        ## 先在web.xml中注册的过滤器先过滤，然后放行过滤器链。直到过滤器链执行完，再从后向前返回执行chain.doFilter之后的方法
    init()
    destroy()
    doFilter()
    FilterChain接口  # 代表可以里德过滤的过滤器的链对象。调用doFilter()方法时交给下一个满足该资源 的过滤器对象，如果没有过滤器了，直接放行资源
        ## 当多个过滤器都匹配资源时，不是按照优先级匹配，而是按照web.xml中的注册顺序匹配

    FilterConfig接口    # 该接口定义的是过滤器的配置对象，用于获取过滤器的配置参数
    使用
    web.xml 中
        <filter>
        <init-param>
        <param-name>
        <param-value>

        private FilterConfig config = null;
        ..
        public void init中
        this.config = config;

        doFilter 中
        String ip = this.config.getInitParameter("ip");

    过滤servlet
        1.拦截servlet映射的url
        2.直接写servlet的名字  # 过滤所有servlet <url-pattern>/servlet/*</url-pattern>，所以推荐servlet的路径写在/servlet 目录下
        3.由于拦截不了servlet转发的jsp页面，映射一个过滤器到某种传递方式
        <filter-mapping>
        <dispatcher>FORWARD # REQUEST  请求方式
            ## INCLUDE  包含方式 
            ## ERROR  错误页面
    案例
    # 乱码
        post 方式
        get 方式
        doFilter方法中 改进 # 把utf-8配置成Filter的配置参数,增强response
        # 设置get 中 提到参数的编码 方式
        // doFilter中的request response 是 父类，所以要转型
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // 处理post编码 ，也向下面的get包装方法传递了编码 方式
        httpRequest.setCharacterEncoding("utf-8")
        // 获取请求的方式
        String method = httpRequest.getMethod();
        // 增强原始的request 对象 的 getParameter 方法,继承或包装
        if("get".equalsIgnoreCase(method)){
        // 传递增强的request给目标资源 
        chain.doFilter(new MyWapperRequest(httpRequest),response);
        }else{
        request.setCharacterEncoding("utf-8");
        }
    
        // 传递增强的对象给目标资源
    
        class MyWapperRequest extends HttpServletRequestWrapper{
        private HttpServletRequest request = null;
        public MyWapperRequest (HttpServletRequest request){
            super(request);
            this.request = request;
        }
        @Override
        public String getParameter(String name){
            String value = request.getParameter(name);
            String method = request.getMethod();
            // 判断
            if(value != null &&"get".equalsIgnoreCase(method)){
            value = new String(value.getBytes("iso8859-1"),request.getCharacterEncoding())
            }
            return value;
        }
        
        }
    
    # 配置缓存的不缓存
    ##　页面有大量可变数据 的时候 ，不能缓存
        Expires:-1
        Cache-Control:no-cache
        Pragma:no-cache
    
        NoCacheFilter implements Filter # 设置不缓存
        doFilter 中
        HttpServletResponse httpResponse = response;
        // 设置响应头信息
        httpResponse.setHeader("Expires",-1 + "");
        //  setDataHeader("expires",-1);
        httpResponse.setHeader("cache-control","no-cache");
        httpResponse.setHeader("pragma","no-cache");
        // 放行资源
        chain.doFilter(request,httpResponse);
    
    
    
        CacheFilter # 缓存所有的静态资源 映射 *.jpg *.css  注意url-pattern 可以 映射多个 param-name=jpg param-value=2
        把资源分路径管理
        private FilterConfig config = null;
    
        doFilter 中
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletResponse httpRequest = (HttpServletRequest) request;
        
        // 获取用户的请求资源 
        String resource = request.getRequestURI();
        // 判断 
        String date  = null;
        if(resource.endsWith("jpg")){
        date =  config.getInitParameter("jpg");
        httpResponse.setDateHeader("expires",System.currentTimeMillis() + longDate * 60 * 60 * 1000);    // 换算成秒
        } else if(resource.endsWith("js")){
        String date  = config.getInitParameter("js");
        config.getInitParameter("js");
        httpResponse.setDateHeader("expires",System.currentTimeMillis() + longDate * 60 * 60 * 1000);
        }
    
        // 放行
        chain.doFilter(httpRequest,httpResponse);

    写css 文件
    写js 文件
    function showDialog(){
        alert("ok");
    }
    showDialog)();

    index.jsp 中
        <link href="css路径"/>
        <script type="text/javascript" src="js的路径"/>

    修改项目
    EncodingFilter implements Filter{

    doFilter(request,response){
        // 转型
        HttpServletRequest httpRequest = ()request;
        response;
        // 
        httpRequest.setCharacterEncoding("utf-8");

        // 包装
        chain.doFilter(httpRequest,httpResponse);

    }


    class EncodingRequest extends HttpServletRequestWrapper{
        private HttpServletRequest request;
        public EncodingRequest (HttpServletRequest request){
        super(request);
        this.request = request;
        
        }

        @Override
        public String getParameter(String name){
        String value = request.getParameter(name)
        if(value != null && "get".equalsIgnoreCase(request.getMethod)){
        value = new String(value.getBytes("iso8859"),"utf-8");
        }
        return value;
        }
    }
    }

    LoginFilter 
    init(){
    this.config  = config;
    }
    private FilterConfig config = null;
    doFilter(){
    String path = this.config.getInitParameter("loginPage");
    // 转型 

    // 获取 session 对象
    HttpSession session = httpRequest.getSession(false);
    // 判断用户请求的是否是UserServlet
    String servletName = httpRequest.getServletPath();
    servletName = substring(servletName.lastIndexOf("/")+1);
    if("UsersServlet".equals(servletName)){
        }else{ // 一般的servlet
    if(session != null){
    // 获取登录标记
    User user = null;
    user = (User)session.getAttribute("user");

    // 判断 
    if(user != null){
        // 放行资源
        chain.doFilter(httpRequest,httpResponse);
    }else{
        // 页面重定向到登录页面
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/" + path);
    }
    }

    <filter>
    <filter-name>loginFilter
    <filter-class>
    <init-param>
        <param-name>loginPage
        <param-value>
    <filter-mapping>
    <filter-name>
    <url-pattern>/jsps/*
    <url-pattern>/servlet/*
    <url-pattern>/publics/*
    <filter-name>
    <url-pattern>/publics/head.jsp
    <dispatcher>INCLUDE
    <dispatcher>FORWARD
    <dispatcher>ERROR
    <dispatcher>REQUEST        # 默认是request，当加上其它参数时（如include），request会没有，所以要加两个forward,request
                    ## 是指向里面以该方法请求的时候进行过滤

# jsp

## jsp-el表达式
    ${  }
    11个内置对象
        pageContext    // pageContext
        page        // map （相当于pageScope，不过写法上省略了Scope）
        requestScope    // map
        sessionScope    // map
        applicationScope    // map
        param        // map        ,用${param.name}的形式得到传递的参数
        paramValues    // map<String,String []>
        header        // map
        hearderValues    // map<String, String []>
        cookie        // map
        initParam        // map
        
    语法
    ${list[0]}<br>
        ${map.mapteststring}<br>
        ${map[mapkey]}<br>
        ${map['mapteststring']}<br>
        ${request }
        ${pageContext.request.contextPath }<br>        # el表达式中访问内置对象 
        ${requestScope.aaa }                # 访问内置对象requestScope，得到request作用域中的aaa元素
        ${pageContext.servletContext.contextPath }<br>
        ${param}<br>
        ${paramValues['a'] }<br>
        ${paramValues['a'][0] }
        ${paramValues['a'][1] }
        ${paramValues['a'][2] }<br>
        ${empty novalue}<br> 
        ${1>2?"yes" : "no"}<br>
        
            #  . 与 [] 可以替换使用，但有两点需要注意
            1  .1不行，但是[1]可以
            2    1> map["key"]    是取map中"key"对应的值
                2> map[key]是先从作用域中取得key的字符串如"aaa",再取map中"aaa"对应的值
                3> .key    相当于1>中的介绍，是取map中"key"对应的值
                4> .是不能相当于2>中的介绍那样使用的
    比较符${ }中使用
        empty
        not empty
        三元式（?:）
        简单的算术运算

## jsp-taglib标签库

    jstl标签库1.1 或1.2
        标签库1.1中需要    jstl.jar 与 standard.jar 库
    可放入域scope的类型
        page
        request
        session
        application
        functions
    el表达式级使用，其它都标签级使用
    functions
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
        ${fn:contains("gzitcast", "itcast") }  <br>
        ${fn:containsIgnoreCase("gzitcast", "ITCAST") }  <br>
        ${fn:endsWith("gzitcast", "st") } <br>
        ${fn:indexOf("gzitcsat", "cs") } <br>
        ${fn:join(arr, "-") } <br>
        ${fn:length("gzitcast") } <br>
        ${fn:replace("gzitcast", "gz", "广州") } <br>
        ${fn:split("gz,it,cast", ",") } <br>
        ${fn:startsWith("gzitcsat", "gz") } <br>
        ${fn:substring("gzitcsat", 3, 8) } <br>
        ${fn:substringAfter("gzitcsat", "cs") } <br>
        ${fn:substringBefore("gzitcsat", "cs") } <br>
        ${fn:toLowerCase("gziTCsat") } <br>
        ${fn:toUpperCase("gziTCsat") } <br>
        ${fn:trim("  gzitcsat  ") } <br>
        <%-- 对字符串中进行转义处理，如：会把"<"替换为"&lt;"，把">"替换为"&gt;" --%>
        ${fn:escapeXml("<h3>gzitcsat</h3>") } <br>
    core
        所有标签：
            out
            set
            remove
            catch
            if
            choose
            when
            otherwise
            forEach
            url
            param
            redirect
            forTokens
            import

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/cores"%>
        <c:out var=""    default=""    escapeXml="true">    <%--    放过xml过滤，让它显示，默认不显示    --%>
        -------------------------------------
        scope方式
        <c:set    var=""    value=""    scope="">
        target方式    <%--    这个放入page作用域中的map值    --%>
        <%  Map map = new HashMap();  %>
        <c:set    property="key1"    value="key1value"    target="<%=map%>"
        <%  pageContext.setAttribute("map", map);  %>
        <c:out    value="${map[key2]}"    
        
        -------------------------------------
        <c:catch var="e"></c:catch>
        <c:out value='<%= ((Exception)pageContext.getAttribute("e",PageContext.PAGE_SCOPE)).getMessage() %>'></c:out>
        -------------------------------------
        <c:remove    var=""    scope="">
        -------------------------------------    
        <c:if test="${not empty    }" scope=""    var="">
        -------------------------------------
        <%--    if...else标签    --%>
        <c:choose>
        <c:when test="">
        <c:otherwise>
        -------------------------------------
        <c:forEach  begin=""    end=""    step=""    items=""    var=""    varStatus="state">          <%--    varStatus中的函数有first last count begin end    --%>
        <tr bgcolor='${state.count%2 == 0? "red" : "pink"}' >
        </c:forEach>

        varStatus可用的函数
            current    // 当前这次迭代的项
            index    // 索引
            count    // 计数
            first        // 第一个
            last        // 最后一个
            begin    // begin属性值
            end        // end 属性值
            step        // step属性值
        -------------------------------------
        uri 代表所有协议路径
        
        <c:url    var="itcast"    value="http://www.itcast.cn"    scope="page"    context=""    >    <%--    context 是整个网站    --%>
        <c:param    name="name"    value="中文">    <%--    这样传参数有编码    --%>
        
        如果value值为"/" 则加入context属性提供上下文名称，如果context也被省略，就使用当前servlet的上下文名称
        -------------------------------------
        <c:redirect    url="${itcast}"    context=""    >
        -------------------------------------
        <c:set    var="name"    value="xx,xxx,xxx,xx"    scope="request"    >
        <c:forTokens    items="${name}"    delims=","    begin=""    end=""    step="1"    var="name"    varStatus=""    >    <%--切割字符串--%>
        -------------------------------------
        <c:import    url="/publics/head.jsp"    >    <%--动态包含，引入公共文件--%><%--网站publics文件夹--%>


    sql标签库
        # 以前没有mvc模式的时候，通过页面访问数据库时用的，现在不用
        引入
            <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
        设置数据源
            <sql:setDataSource dataSource=”dataSource”[var=”name”] 
                                [scope=”page|request|session|application”]/>
        jdbc连接
            <sql:setDataSource driver=”driverClass” url=”jdbcURL”
                    user=”username”
                    password=”pwd”    
                    [var=”name”]
                    [scope=”page|request|session|application”]/>
                    
        JSTL提供了<sql:query>、<sql:update>、<sql:param>、<sql:dateParam>和<sql:transaction>这5个标签
            1.query:
            query必需指定数据源
            <sql:query sql=”sqlQuery” var=”name” [scope=”page|request|session|application”]
            [dataSource=”dateSource”]
            [maxRow=”maxRow”]
            [startRow=”starRow”]/>
            或
            <sql:query var=”name” [scope=”page|request|session|application”]
            [dataSource=”dateSource”]
            [maxRow=”maxRow”]    # 设定最多可以暂存数据的长度
            [startRow=”starRow”]    # 设定从哪一行开始
                    > 
                    sqlQuery
                    </sql:query>
                    
            结果集的参数
                rowCount    # 结果集中的记录总数
                rowsByIndex    # 以数字为作索引的查询结果
                columnNames    # 字段名称数组
                Rows    # 以字段为索引查询的结果
                limitedByMaxRows    # 是否设置了maxRows属性来限制查询记录的数量
                    limitedByMaxRows用来判断程序是否收到maxRows属性的限制。
                    并不是说设定了maxRows属性，得到结果集的limitedByMaxRows的属性都为true，
                    当取出的结果集小于maxRows时，则maxRows没有对结果集起到作用此时也为false。
                    例如可以使用startRow属性限制结果集的数据量。
            
            2.update:
            </sql:update>    
            <sql:update sql=”SQL语句” [var=”name”] [scope=”page|request|session|application”]
                    [dateSource=”dateSource”]/>
            或
        <sql:update [var=”name”] [scope=”page|request|session|application”]
                    [dateSource=”dateSource”]
                        > 
                        SQL语句
            参数说明
                dataSource    # 数据源对象
                其它与query一样
            
            3.param 参数设置
            <sql:param value=”value”/>
            或
            <sql:param>
                Value
                </sql:param>
            
            4.dataParam 标签    # 用于为SQL标签填充日期类型的参数值
            
            参数说明
                value：java.util.Date类型的参数。
                type属性：指定填充日期的类型timestamp（全部日期和时间）、time（填充的参数为时间）、date（填充的参数为日期）。

            5.transaction 标签 
            
            <sql:transaction [dataSource=”dataSource”]
                [isolation=”read_committed|read_uncommitted|repeatable|serializable”]
                > 
                <sql:query>
                <sql:uptade>
            </sql:transation>

    xml标签库
        核心操作
        out    # 主要用来取出XML中的字符串。
            属性
            select    # XPath语句
            escapeXml    # 是否转换特殊字符
            
        parse    # 用来解析xml文件
            属性
            doc    # XML文件
            systemId    # XML文件的URL
            filter    # XMLFilter过滤器
            varDom    # 储存解析后的XML文件
            scopeDom    # varDom的范围
            
        set    # 将从XML文件取得的内容储存至属性范围中
            属性
            select    # XPath语句
            
        流程控制
        if
        choose when otherwise
            属性
            select    # XPath语句
        文件转换
        <x:transform doc=”xmldoc” xslt=”XSLTStytlesheet”[docSystemId=”xmlsystemid”]
            [result=”result”]
            [var=”name”]
            [scope=”scopeName”]
            [xsltSystemId=”xsltsystemid”]/>
        或
        <x:transform doc=”xmldoc” xslt=”XSLTStytlesheet”[docSystemId=”xmlsystemid”]
            [result=”result”]
            [var=”name”]
            [scope=”scopeName”]
            [xsltSystemId=”xsltsystemid”]
            > 
            <x:param/>
            </x:transform>
        或
        <x:transform doc=”xmldoc” xslt=”XSLTStytlesheet”[docSystemId=”xmlsystemid”]
            [result=”result”]
            [var=”name”]
            [scope=”scopeName”]
            [xsltSystemId=”xsltsystemid”]
            > 
            
            属性
            doc    # 指定xml文件来源
            xslt    # 转化xml的样式模板
            docSystemId    # xml文件的URI
            xsltSystemId    # xslt文件的URI
            result    # 用来存储转换后的结果对象
        
    国际化
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        国际化标签
        1.setLocale    # 设置一个全局的地区代码,设定的是本地的环境
            中文－大陆:<fmt:setLocale value="zh_CN"/> <fmt:formatDate value="${todayValue}"/><br>
        
        2.requestEncoding    # 设置统一的请求编码
            <fmt:requestEncoding value="GB2312"/>
        
        信息显示标签
        1.<fmt:bundle> 设置临时要读取的资源文件
        2.<fmt:message>  通过key取得value
        3.<fmt:setBundle>  设置一个要读取的全局的资源文件
            如
            <fmt:setBundle basename="applicationMessage" var="MyResourse"/>    # 绑定了名为applicationMessage_zh_CN.properties一类 的文件
            <fmt:bundle basename="MyResourse" prefix="label."> 
            <fmt:message key="backcolor" bundle="${applicationBundle}"/>
            <fmt:message key="fontcolor" />
        </fmt:bundle>
            
        
        数字及日期格式化标签
        1.<fmt:formatDate>  日期的格式化
            属性
            value:格式化的日期，该属性的内容应该是 java.util.Date 类型的实例
            type:格式化的类型
            pattern:格式化模式
            timeZone:指定格式化日期的时区 
        2.<fmt:parseDate>  解析日期
            属性
            value:将被解析的字符串 
            type:解析格式化的类型 
            pattern:解析格式化模式 
            parseLocale:以本地化的形式来解析字符串，该属性的内容为 String 或 java.util.Locale 类型的实例 
            timeZone:指定解析格式化日期的时区
        3.<fmt:formatNumber>  数字格式化
            属性
            value:格式化的数字,该数值可以是 String 类型或 java.lang.Number 类型的实例 
            type:格式化的类型,可能值包括:currency（货币）、number（数字）和percent（百分比）
            pattern:格式化模式 
            maxIntegerDigits:指定格式化结果的最大值 
            minIntegerDigits:指定格式化结果的最小值 
            maxFractionDigits:指定格式化结果的最大值，带小数 
            minFractionDigits:指定格式化结果的最小值，带小数 
            如
            <fmt:formatNumber value="1000.888" type="currency" var="money"/>
            
        4.<fmt:parseNumber>  解析数字
            属性
            value:将被解析的字符串 
            type:解析格式化的类型 
            pattern:解析格式化模式 
            如
            <fmt:parseNumber value="15%" type="percent" var="num"/> 
        5.<fmt:setTimeZone>  标签则允许将时区设置保存为一个变量，在之后的工作可以根据该变量来进行属性描述 
            属性
            value    # 时区的设置 
            var    # 用于保存时区为一个变量 
        6.<fmt:timeZone>  标签将使得在其标签体内的工作可以使用该时区设置
            属性
            value    # 时区的设置
        7.<fmt:param> 标签:用于参数传递
            如：在MyResourse.properties文件中,有一个索引值如下(其中,{0}代表占位符):
            Str2=Hi,{0} 
            则,使用<fmt:param>标签传入值如下:
            <fmt:bundle basename="MyResourse"> 
                <fmt:message key="Str2">
                <fmt:param value="张三" />
                </fmt:message>
            </fmt:bundle>
            也可以在资源文件中指定参数的类型:
            如:在MyResourse.properties文件中,有一个索引值如下:
            Str3={0,date}
            则,使用<fmt:param>标签传入值如下:
            <% request.setAttribute("now",new Date()); %>
            <fmt:bundle basename="MyResourse"> 
                <fmt:message key="Str3">
                <fmt:param value="${now}" />
                </fmt:message>
            </fmt:bundle>

## jsp动作标签

    在JSP中的动作行为包括：Include、 Forward、 UseBean、 GetProperty、 SetProperty、 Plugin。 

    一、Include行为 

        <jsp:include>标签表示动态包含一个静态的或者动态的文件。 
        
        语法： 
        <jsp:include page="path" flush="true" /> 
        or 
        <jsp:include page="path" flush="true"> 
        <jsp:param name="paramName" value="paramValue" /> 
        </jsp:include> 
        
        注： 
        1、page="path" 为相对路径，或者代表相对路径的表达式。 
        2、flush="true" 必须使用flush为true，它默认值是false。 
        3、<jsp:param>子句能让你传递一个或多个参数给动态文件，也可在一个页面中使用多个<jsp:param>来传递多个参数给动态文件。 
        4、<jsp:include page="" flush=""> 与<%@ include file=""%>的区别：
            <jsp:include >是动态包含<%@include%>是静态包含。
            # jsp页面是把include指令元素（<%@ include file=""%>）所指定的页面的实际内容（也就是代码段）加入到引入它的jsp页面中,合成一个文件后被jsp容器将它转化成servlet。
            ## 可以看到这时会产生一个临时class文件和一个servlet源文件。
            ## 而动作元素（<jsp:include page=""/>）是在请求处理阶段引入的，会被JSP容器生成两个临时class文件和两个servlet原文件。
            ## 而引入的只是servlet的输出结果，即JspWriter对象的输出结果，而不是jsp的源代码。 
        
    二、Forward行为 

        <jsp:forward>标签表示重定向一个静态html/jsp的文件，或者是一个程序段。 
        
        语法： 
        <jsp:forward page="path"} /> 
        or 
        <jsp:forward page="path"} > 
        <jsp:param name="paramName" value="paramValue" />…… 
        </jsp:forward> 
        
        注： 
        1、page="path" 为一个表达式，或者一个字符串。 
        2、<jsp:param> name 指定参数名，value指定参数值。参数被发送到一个动态文件，参数可以是一个或多个值，而这个文件却必须是动态文件。要传递多个参数，则可以在一个JSP文件中使用多个<jsp:param>将多个参数发送到一个动态文件中。 

    三、UseBean行为 

        <jsp:useBean>标签表示用来在JSP页面中创建一个BEAN实例并指定它的名字以及作用范围。 
        
        语法： 
        <jsp:useBean id="name" scope="page | request | session | application" typeSpec /> 
        其中typeSpec有以下几种可能的情况： 
        class="className" | class="className" type="typeName" | beanName="beanName" type="typeName" | type="typeName" | 
        
        注： 
        你必须使用class或type，而不能同时使用class和beanName。beanName表示Bean的名字，其形式为“a.b.c”。 
        
    四、GetProperty行为 

        <jsp:getProperty>标签表示获取BEAN的属性的值并将之转化为一个字符串，然后将其插入到输出的页面中。 
        
        语法： 
        <jsp:getProperty name="name" property="propertyName" /> 
        
        注： 
        1、在使用<jsp:getProperty>之前，必须用<jsp:useBean>来创建它。 
        2、不能使用<jsp:getProperty>来检索一个已经被索引了的属性。 
        3、能够和JavaBeans组件一起使用<jsp:getProperty>，但是不能与Enterprise Java Bean一起使用。 
    JavaScript通用库  Jsp语法
    JSP的动作标签  2008-04-01 11:47:49|  分类： JSP学习 |  标签： |字号大
    中
    小 订阅 
    在JSP中的动作行为包括：Include、 Forward、 UseBean、 GetProperty、 SetProperty、 Plugin。 

    一、Include行为 

    <jsp:include>标签表示包含一个静态的或者动态的文件。 

    语法： 
    <jsp:include page="path" flush="true" /> 
    or 
    <jsp:include page="path" flush="true"> 
    <jsp:param name="paramName" value="paramValue" /> 
    </jsp:include> 

    注： 
    1、page="path" 为相对路径，或者代表相对路径的表达式。 
    2、flush="true" 必须使用flush为true，它默认值是false。 
    3、<jsp:param>子句能让你传递一个或多个参数给动态文件，也可在一个页面中使用多个<jsp:param>来传递多个参数给动态文件。 

    二、Forward行为 

    <jsp:forward>标签表示重定向一个静态html/jsp的文件，或者是一个程序段。 

    语法： 
    <jsp:forward page="path"} /> 
    or 
    <jsp:forward page="path"} > 
    <jsp:param name="paramName" value="paramValue" />…… 
    </jsp:forward> 

    注： 
    1、page="path" 为一个表达式，或者一个字符串。 
    2、<jsp:param> name 指定参数名，value指定参数值。参数被发送到一个动态文件，参数可以是一个或多个值，而这个文件却必须是动态文件。要传递多个参数，则可以在一个JSP文件中使用多个<jsp:param>将多个参数发送到一个动态文件中。 

    三、UseBean行为 

    <jsp:useBean>标签表示用来在JSP页面中创建一个BEAN实例并指定它的名字以及作用范围。 

    语法： 
    <jsp:useBean id="name" scope="page | request | session | application" typeSpec /> 
    其中typeSpec有以下几种可能的情况： 
    class="className" | class="className" type="typeName" | beanName="beanName" type="typeName" | type="typeName" | 

    注： 
    你必须使用class或type，而不能同时使用class和beanName。beanName表示Bean的名字，其形式为“a.b.c”。 

    四、GetProperty行为 

    <jsp:getProperty>标签表示获取BEAN的属性的值并将之转化为一个字符串，然后将其插入到输出的页面中。 

    语法： 
    <jsp:getProperty name="name" property="propertyName" /> 

    注： 
    1、在使用<jsp:getProperty>之前，必须用<jsp:useBean>来创建它。 
    2、不能使用<jsp:getProperty>来检索一个已经被索引了的属性。 
    3、能够和JavaBeans组件一起使用<jsp:getProperty>，但是不能与Enterprise Java Bean一起使用。 

    五、SetProperty行为 

        <jsp:setProperty>标签表示用来设置Bean中的属性值。 
        
        语法： 
        <jsp:setProperty name="beanName" prop_expr /> 
        其中prop_expr有以下几种可能的情形： 
        property="*" | property="propertyName" | property="propertyName" param="parameterName" | property="propertyName" value="propertyValue" 
        
        注： 
        使用 jsp:setProperty 来为一个Bean的属性赋值；可以使用两种方式来实现。 
        1、在jsp:useBean后使用jsp:setProperty： 
        <jsp:useBean id="myUser" … /> 
        … 
        <jsp:setProperty name="user" property="user" … /> 
        在这种方式中，jsp:setProperty将被执行。 
        2、jsp:setProperty出现在jsp:useBean标签内： 
        <jsp:useBean id="myUser" … > 
        … 
        <jsp:setProperty name="user" property="user" … /> 
        </jsp:useBean> 
        在这种方式中，jsp:setProperty只会在新的对象被实例化时才将被执行。 
        
        * 在<jsp:setProperty>中的name值应当和<jsp:useBean>中的id值相同。    

    六、Plugin行为 

        <jsp:plugin>标签表示执行一个applet或Bean，有可能的话还要下载一个Java插件用于执行它。 
        
        语法： 
        <jsp:plugin 
        type="bean | applet" 
        code="classFileName" 
        codebase="classFileDirectoryName" 
        [ name="instanceName" ] 
        [ archive="URIToArchive, ..." ] 
        [ align="bottom | top | middle | left | right" ] 
        [ height="displayPixels" ] 
        [ width="displayPixels" ] 
        [ hspace="leftRightPixels" ] 
        [ vspace="topBottomPixels" ] 
        [ jreversion="JREVersionNumber | 1.1" ] 
        [ nspluginurl="URLToPlugin" ] 
        [ iepluginurl="URLToPlugin" ] > 
        [ <jsp:params> 
        [ <jsp:param name="parameterName" value="{parameterValue | <％= expression ％>}" /> ]+ 
        </jsp:params> ] 
        [ <jsp:fallback> text message for user </jsp:fallback> ] 
        </jsp:plugin> 
        
        注： 
        <jsp:plugin>元素用于在浏览器中播放或显示一个对象（典型的就是applet和Bean),而这种显示需要在浏览器的java插件。 
        当Jsp文件被编译，送往浏览器时，<jsp:plugin>元素将会根据浏览器的版本替换成<object>或者<embed>元素。注意，<object>用于HTML 4.0 ，<embed>用于HTML 3.2。 
        一般来说，<jsp:plugin>元素会指定对象是Applet还是Bean,同样也会指定class的名字，还有位置，另外还会指定将从哪里下载这个Java插件。

## jsp函数

    用response.getOutputStream返回数据（而非JspWriter）时，调用：
        # 如输出图片对象：ImageIO.write(image, "jpeg", response.getOutputStream());
        out.clear();        # 清空 out
        out = pageContext.pushBody()    # 将图片对象的流从out输出，直到整个输出结束（接收方网页加载全部完成时）后才断开

## jsp基本

    模板元素
    脚本
    <%    %>
    脚本表达式
    <%=    %>
    注释
    <%--    --%>
    指令
        <%@ page%>
        language="java" 
        import="java.util.*,java.io.*" 
        contentType="mineType [; charset=characterSet]" 
        pageEncoding="characterSet"
        session="true"
        buffer="none | 8kb | sizekb"
        autoFlush="true"
        isThreadSafe="true"
        info="text"
        errorPage="relative_url"
        isErrorPage="true"
        isELIgnored="true"
        <%@ include%>    # <%@ include file="in.jspf" %> 是静态包含（原代码中包含），一般包含名字为*.jspf的jsp文件
        <%@ taglib%>    # 标签库
    声明
        <%!    %>    # 全局声明（刷新页面仍然保存数据）
        <% %>    # 局部的声明（刷新页面不保存数据）
    标签
        <jsp:forward page=""></jsp:forward>
        <jsp:include page=""></jsp:include>
    内置对象 9个
        pageContext
        request
        response
        config
        session
        application
        page
        out
        exception
        
        全局变量
        static final JspFactory        _jspxFactory
        static java.util.List        _jspx_dependants
        javax.el.ExpressionFactory    _el_expressionfactory
        org.apache.AnnotationProcessor    _jsp_annotationprocessor
        在_jspService中的变量
        HttpServletRequest        request
        HttpServletResponse        response
        PageContext        pageContext = null;
                    pageContext = _jspxFactory.getPageContext(this,request,response,null,true,8192,ture);
        HttpSession        session = null;
                    session = pageContext.getSession();
        ServletContext        application = null;
                    application = pageContext.getServletContext();
        ServletConfig        config = null;
                    config = pageContext.getServletConfig();
        JspWriter            out = null;
                    out = pageContext.getOut();
        Object            page = this;
        JspWriter            _jspx_out = null;
                    _jspx_out = out;
        PageContext        _jspx_page_context = null;
                    _jspx_page_context = pageContext;    

## jsp验证码

    实例    # 在<img>标签的src属性中指定该jsp文件即可
        
        ## out.clear();out = pageContext.pushBody();两条语句的作用是
        ## 使该验证码jsp文件的传输不会默认地在返回数据后中断，而是在<img>标签调用该jsp的页面加载结束之后再中断数据的传输
        <%@ page language="java" pageEncoding="UTF-8"%>
    <%@ page contentType="image/jpeg" import="java.util.*,java.awt.*,java.awt.image.*,javax.imageio.*"%>
    <%!
        // 声明区，定义产生颜色和验证内容的全局方法
        public Color getColor(){
        
        Random random = new Random();
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);
        return new Color(r,g,b);
        }
        public String getNum(){
        String str = "";
        Random random = new Random();
        for(int i = 0; i < 4; i++){
            str += random.nextInt(10) + " ";
        }
        return str;
        }
    %>
    <%
        // 设置响应无缓存
        response.setHeader("pragma", "mo-cache");
        response.setHeader("cache-control", "no-cache");
        response.setDateHeader("expires", 0);
        // 图片对象,画笔对象
        BufferedImage image = new BufferedImage(80,30,BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        // 画背景
        g.setColor(new Color(200,200,200));
        g.fillRect(0, 0, 80, 30);
        // 画干扰线
        for(int i = 0; i < 30; i++){
        Random random = new Random();
        int x = random.nextInt(80);
        int y = random.nextInt(30);
        int xl = random.nextInt(x+10);
        int yl = random.nextInt(y+10);
        g.setColor(getColor());
        g.drawLine(x, y, x + xl, y + yl);
        }
        // 画内容
        g.setFont(new Font("serif", Font.BOLD,16));
        g.setColor(Color.BLACK);
        String checkNum = getNum();
        g.drawString(checkNum,15,20);
        // 放内容到session中，返回图片流
        session.setAttribute("validateCode", checkNum.replaceAll(" ", ""));
        ImageIO.write(image, "jpeg", response.getOutputStream());
        out.clear();
        out = pageContext.pushBody();    // 不按照jsp默认的getWriter()方法输出，用我们定义的流的方法进行输出
    %>

## 自定义标签

    1、JspTag 接口（标记接口，类以Serializable）
    2、Tag 接口（空标签，如<img/>）
        属性：
        static int EVAL_BODY_INCLUDE        通过流执行标签体    
        static int EVAL_PAGE              继续执行页面
        static int SKIP_BODY            忽略执行标签体 
        static int SKIP_PAGE            忽略后面的JSP页面
        方法：
        // 生命周期方法
        int doEndTag()            当遇到标签结束的时候自动执行
        int doStartTag()            当遇到标签开始的时候自动执行
        // 实现方法
        Tag getParent()            获取当前标签的父标签处理类对象
        void release()            当事件改变的时候自动执行
        void setPageContext(PageContext pc)    设置当前的JSP上下文环境
        void setParent(Tag t)        设置当前标签的父标签对象
    3、TagSupport 类（有属性的标签，如<img src=""/>）
        实现了Tag接口并且提供处理标签属性的方法(set和get)。而且内部定义了一个PageContext变量并且已经初始化开发者可以直接使用this或者super直接方法该属性。
    4、BodyTagSupport类（有属性有文本内容和标签，如<img src="">aaa</img>）
        新属性
        protected  BodyContent bodyContent 
        新方法
        void setBodyContent(BodyContent b)
        BodyContent getBodyContent()
        
        BodyContent类
            abstract String getString()    //获取标签体
        
        写Tag接口的标签库
        1、写Tag接口实现类
            写属性pageContext（getter 和setter），从setPageContext(PageContext pc)方法中获得该属性
            复写方法
        2、写tld文件，放到/META-INF文件夹中
            <?xml version="1.0" encoding="UTF-8"?>
            <taglib xmlns="http://java.sun.com/xml/ns/javaee"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-jsptaglibrary_2_1.xsd"
            version="2.1">
            
            <tlib-version>1.0</tlib-version>    
            <short-name>ouru</short-name>    # 简称
            <uri>/outrun-tags</uri>    # 自定义引入标签时写的路径
            
            <tag>
            <name>testDate</name>
            <tag-class>outrun.util.jsp.taglib.test.DataImplTag</tag-class>
            <body-content>empty</body-content>
            </tag>
            
            </taglib>
        3、jsp 中引用它
            <%@ taglib prefix="ouru" uri="/META-INF/myUtil.tld" %>
        写TagSupport接口的实现类
        pageContext已内置
        定义接收属性
        tld文件中加入attribute属性
            <attribute>        属性描述的开始
            <name>pattern</name>    描述属性名
            <required>true</required>    描述属性是否是必须的
            <rtexprvalue>true</rtexprvalue>  描述属性值是否可以是输出表达式
            </attribute>
        写BodyTagSupport接口的实现类
        BodyContent body = this.getBodyContent();
        String desc = body.getString();
        
        tld 文件中
        <body-content>JSP</body-content>    # 有标签体，可执行脚本表达式
                            ## scriptless，有标签体，不执委脚本表达式
                            ## empty,没有标签体

    Jsp2.0
        JspTag — SimpleTag — SimpleTagSupport
        
        SimpleTagSupport类
        该类可以直接进行操作标签的属性和标签体。
        void doTag()                遇到标签的时候自动指定
        protected  JspFragment getJspBody()          获取标签体对象
        protected  JspContext getJspContext()      获取JSP上下文环境对象
        JspTag getParent()            获取该标签的父标签处理类对象
            JspFragment类
            该类代表的标签的标签体。
            abstract  void invoke(Writer out)    输出数据到指定的流，null输出到JSP页面
        获得标签体的方法：
            Writer writer = new StringWriter();
            JspFragment jspFragment = getJspBody();
            jspFragment.invoke(writer);    
            String text = writer.toString();
        项目：实现 if else 判断
        Choose.java
            private boolean tag = true;
            
            public boolean isTag() {
                return tag;
            }
            
            public void setTag(boolean tag) {
                this.tag = tag;
            }
            
            @Override
            public void doTag() throws JspException, IOException {
                getJspBody().invoke(null);
                super.doTag();
            }
        when.java 文件
            private boolean test = false;
            public boolean isTest() {
                return test;
            }
            
            public void setTest(boolean test) {
                this.test = test;
            }
            @Override
            public void doTag() throws JspException, IOException {
                Choose parent = (Choose) getParent();
                if(isTest() && parent.isTag()){
                // 条件成立
                getJspBody().invoke(null);
                // 设置父的tag为false
                parent.setTag(false);
                }
                super.doTag();
            }
        Otherwise.java 文件
            @Override
            public void doTag() throws JspException, IOException {
                Choose parent = (Choose) getParent();
                if(parent.isTag()){
                // 条件成立
                getJspBody().invoke(null);
                parent.setTag(false);
                }
                super.doTag();
            }
        tld文件
            <tag>
            <name>choose</name>
            <tag-class>outrun.util.jsp.taglib.ifelse.Choose</tag-class>
            <body-content>scriptless</body-content>    # 有标签体，可执行脚本表达式
                                    ## scriptless，有标签体，不执委脚本表达式
                                    ## empty,没有标签体

            </tag>
            
            <tag>
            <name>when</name>
            <tag-class>outrun.util.jsp.taglib.ifelse.When</tag-class>
            <body-content>scriptless</body-content>
            <attribute>
            <name>test</name>
            <required>true</required>
            <rtexprvalue>true</rtexprvalue>
            </attribute>
            </tag>
            
            <tag>
            <name>otherwise</name>
            <tag-class>outrun.util.jsp.taglib.ifelse.Otherwise</tag-class>
            <body-content>scriptless</body-content>
            </tag>
            


    控件标签：
    自定义函数库
        1 创建函数库类
        public class MyFunctions {
        public static String formatMyName(String name) {
        return "your name is " + name;
        }
        public static int add(int a, int b) {
        return a+b;
        }
        }
        
        2 在TLD文件中配置 (引用于目标1中的tld文件)
        <function>
        <name>formatMyName</name>
        <function-class>com.taglib.MyFunctions</function-class>
        <function-signature>java.lang.String formatMyName(java.lang.String)</function-signature>
        </function>
        
        <function>
        <name>add</name>
        <function-class>com.taglib.MyFunctions</function-class>
        <function-signature>java.lang.String add(int, int)</function-signature>
        </function>

        3 JSP中调用

        ${cc:formatMyName("wangfei") }
        ${cc:add(12, 34) }

# i18n
    
    页面需要获取用户信息，从数据库中取数据显示
    
    java类中试用：
    cn.itcast.resource包中
        hello_en_US.properties
        hello=hello
        hello_zh_CN.properties
        hello=编码后的“你好”
        Test.java
        #  获取信息
        Locale locale = locale.CHINA;
        #  加载资源
        ResourceBundle bundler = ResourceBundle.getBundle("cn.itcast.resource.hello",locale);
        #  取出数据
        String str = bundler.getString("hello");

    jsp中
    <%
        ResourceBundle bundler = ResourceBundle.getBundle("lang.properties.hello", request.getLocale());
        out.write(bundler.getString("title"));
    %>
    <fmt>标签
        <fmt:setLocale value="${pageContext.request.locale }" scope="page"/>
        <fmt:setBundle basename="lang.properties.hello" var="bundler" scope="page"/>
        <fmt:message bundle="${bundler }" key="title"></fmt:message>
    资源转码
        native2ascii.exe
        myeclipse properties文件编辑器
    ie 中得到en_US
    Locale locale
        getLanguage();
        getCountry();
        getDefault();
    ResourceBundle
        读取文件cn.itcast.resource.hello省略_en_US.properties
        getString(String key)
    实例1：
        创建页面
        创建资源文件
        编辑页面
        request.getLocale();
        ResourceBundle.getBundle("",locale);
        getString("")
    实例2：
        编辑页面
        <%@ taglib%>
        <f:setLocale scope="" value="">
        <f:setBundle basename="" var="" scope="">
        <f:message bundle="" key="" >
    动态数据国际化
    日期国际化
        SimpleDateFormat    #  继承DateFormat
        getDateTimeInstance
        getDateInstance
        getTimeInstance

        static int FULL
        static int LONG
        static int MEDIUM
        static int SHORT
    实例3：
        cn.itcast.i18n.MyDateI18n
        DateFormat format = DateFormat.getDateTimeInstance(DateFormat.FULL,DateFormat.FULL,Locale.CHINA);
        String str = format.format(new Date());
        解析页面中的字符串
        FULL 和 LONG  和 MEDIUM 和 SHORT 的 区别    
        DataFomat
        String format(Date date)
        Date parse(String source)
        创建static string2Date(String str)
        #  分析区域
        Locale locale = Locale.CHINA;

        #  分析日期的风格
        int dateType = DateFormat.SHORT;
        int timeType = DateFormat.FULL;

        #  获取对象
        DateFormat format = DateFormat.getDateTimeInstance(dateType,timeType,locale);

        #  解析
        format.parse(str);
    动态数字国际化
        java.text.*;
        Number类
        NumberFormat(普通数字，货币，百分比)
        getIntegetInstance
        getCurrencyInstance
        getPercentInstance(Locale inLocale)

        format
        parse
        创建cn.itcast.i18n.MyNumberI18n
        #  获取对象
        #  getPercentInstance
        #  getCurrencyInstance
        NumberFormat format = NumberFormat.getIntegerInstance(Locale.CHINA);

        #  格式化 或解析
        long num = 10000000000L;
        #  Number num = format.parse(str);
        #  double price = num.doubleValue();
        format.format(num);
    动态文本国际化
        At 12:30 pm on jul 3,1998, a hurricance destroyed 99 houses and caused $1000000 of damage.
        MessageFormat
        MessageFormat(String pattern,Locale locale)
        format(String pattern,Object...arguments)
        format(Object)
        parse()
        占位
        At{0}  on {0}, a hurricance destroyed{1} houses and caused {2} of damage.

        实例1：
        MyMessageI18n.java
        #  定义模式字符串
        String pattern 
        #  定义locale对象
        MessageFormat format = new MessageFormat(pattern,Locale.CHINA);
        #  定义参数数组
        DateFormat datef = DateFormat.getDateTimeInstance(DateFormat.MEDIUM,DateFormat.SHORT,Locale.US);
        Date date = datef.parse("Jul 3,1998 12:30 PM");
        
        Integer num = new Integer(99);

        long currency = NumberFormat.getCurrencyInstance(Locale.US).parse("$1000000");
        String damage = NumberFormat.getCurrencyInstance(locale).format(currency); 

        Object [] values = {date,num,damage};
        #  格式化
        String str = format.format(values);

        分析：{索引，对象，类型}
        MessageFormat messf = new MessageFormat("{0,time,short} on {0,date}, a hurricance destroyed {1} houses and caused {2,number,currency} of damage.",Locale.CHINA);

        Object [] values = {new Date(),new Integer(100),1000};

        String str = messf.format(values);

