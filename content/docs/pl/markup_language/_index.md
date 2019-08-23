
# xml
    介绍
        可扩展性标记语言，使用DTD和XML Schema标准化XML结构
        优点: 格式统一，符合标准，用于互不兼容系统
        缺点: 格式复杂，占流量大，解析占资源
        解析器
            DOM     # 树形结构
            SAX     # 事件模型
    标签头
        <?xml version="1.0" encoding="utf-8"?>
    命名空间
        <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            # xmlns:beans="http://www.springframework.org/schema/beans"  # 引用其它uri空间
            ## jar 包中的dtd/xsd文件直接用相对路径引用即可（相当于src/目录下的文件）
        <h:table xmlns:h="http://www.w3.org/TR/html4/">
           <h:tr>
           <h:td>Apples</h:td>
           <h:td>Bananas</h:td>
           </h:tr>
        </h:table>
            # 命名空间约束文件的查找
                    1.联网
                    2.myeclipse中的xml
                    3.同目录下
                    4.jar包中
            # xmlns:只能有一个没有别名
        注意
            命名空间不可以分层使用，如 <r:g:element> 是不允许的
        例子
            <?xml version="1.0" encoding="GB2312" ?>
            <c:customer xmlns:c="http://www.customer.com/">
                <c:name>ZhangSan</c:name>
                <c:phone>09098768</c:phone>
                <c:host xmlns:e="http://www.employee.com/">
                    <e:name>LiSi</e:name>
                    <e:phone>89675412</e:phone>
                </c:host>
            </c:customer>

            <?xml version="1.0" encoding="GB2312"?>
            <book xmlns="http://www.library.com/">
                <title>The C++ Standard Library</title>
                <author>Nicolai M.Josutis</author>
            </book>

            <?xml version="1.0" encoding="GB2312"?>
            <customer xmlns="http://www.customer.com/"
                            xmlns:e="http://www.employee.com/">
                <name>ZhangSan</name>
                <phone>09098768</phone>
                <host>
                    <e:name>LiSi</e:name>
                    <e:phone>89675412</e:phone>
                </host>
            </customer>
        语法
            xmlns:[prefix]=”[URI of namespace]”


    dtd文件路径解析
        system声明方式：根据给出URL寻找DTD?DTD通过URL显式地直接定位。
        public声明方式：查找众所周知词汇表，应用程序自行确定从数据库中定位dtd，或是从声明的网站中下载（存入数据库缓存中）。
                # myeclipse中通过xml Catalog选项来定位dtd约束

    schema文件路径解析
        xsd文件中：targetNamespace="http://www.w3school.com.cn"        # 定义自己的uri标识空间名
        xml文件中：xsi:schemaLocation="http://www.w3school.com.cn note.xsd"                # 指定约束文件的uri地址，一般是空间名加/文件名（目前只有cxf的jaxws约束文件例外【把路径换成了包名】）

# dtd
    注意
        同名元素只能用命名空间来区分定义

    例子
        <?xml version='1.0' encoding='utf-8'?>
        <!DOCTYPE poem[
        <!ELEMENT poem (author, title, content)>
        <!ELEMENT author (#PCDATA)>
        <!ELEMENT title (#PCDATA)>
        <!ELEMENT content (#PCDATA)>
        ]>

        <poem>
        <author>王维</author>
        <title>鹿柴</title>
        <content>空山不见人， 但闻人语声， 返景入深林，复照青苔上。</content>
        </poem>
        外部引用
                <?xml version='1.0' encoding='utf-8'?>
                <!DOCTYPE poem SYSTEM "outer.dtd">

                // outer.dtd
                <?xml version="1.0" encoding="utf-8"?>
                <!ELEMENT poem (author, title, content)>
                <!ELEMENT author (#PCDATA)>
                <!ELEMENT title (#PCDATA)>
                <!ELEMENT content (#PCDATA)>
    语法
        <!ELEMENT author (#PCDATA)> 之中的两个空格必须要有

    元素类型
        EMPTY                        # 可以有属性
        ANY                                # 根元素设为ANY类型后，元素出现的次数和顺序不受限制
        #PCDATA
        纯元素类型
        混合类型                        # 可以是元素与内容的混合
            例子
                    <!ELEMENT 家庭 (人+, 家电*)>
            修饰符说明
                    ()                # 用来给元素分组
                            如
                                    (古龙|金庸|梁羽生), (王朔|余杰), 毛毛
                    ｜                # 选择一个
                            如
                                    (男人|女人)
                    +                # 出现一或多次
                            如
                                    (成员+)
                    *                # 出现零或多次
                    ?                # 出现零或一次
                    ,                # 对象必须按指定的顺序出现
                            如
                                    (西瓜, 苹果, 香蕉)
    属性类型

# schema
    Schema约束
        tld文件是Schema约束的
    引入
        根元素添加
                文件books.xsd
                <xs:schema        xmlns:xs="http://www.w3.org/2001/XMLSchema"                                // ns  是 namespace
                        targetNamespace="http://www.jnb.com"                        // 给当前约束文件起一个名字
                        elementFormDefault="qualified">                                        // 添加属性，qualified指所有都来自xs空间
                                可选attributeFormDefault="unqualified"                                // unqualified        默认来自的空间
                文件books.xml
                从根元素开始约束
                <jnb:书架 xmlns:jnb="http://www.jnb.com"                                        // 在被约束文件根元素添加属性，约束命名空间
                        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"        // 找到xsi
                        xsi:schemaLocation="http://www.jnb.com books.xsd">        // 指定对应约束文件的物理地址
                        <jnb:书>
                        </jnb:书>
                </jnb:书架>                                                                                                // 在被约束所有元素添加指定空间前缀
                // 保存并检验
    语法
        元素约束
        <xs:element name="xxx" type="yy" defaule="" />                                                        // name 元素名 type 类型
        元素类型
                xs:string                // 字符串
                xs:decimal                // big decimal 数字类型
                xs:integer                //
                xs:boolean
                xs:date                        // 日期
                xs:time                        // 时间
        属性约束，在元素标签体里
                <xs:attribute name="" type="" />                                                                        // name 属性名 type 类型
        属性类型和元素类型一样
        属性说明
                <xs:attribute use="required" />
        限定约束
                对值的限定
                枚举限定
                正则限定
                选择限定
                长度限定

        混合内容
                <xs:complexType mixed="true">                        // 只有文本和子元素，mixed可以不使用
                </xs:complexType>

        指示器
                All
                Choice                                                                // 选择出现
                Sequence                                                        // 按声明顺序出现
                maxOccurs
                minOccurs
                Group name
                attributeGroup name
                <xs:all>                                                        // 指定以下元素随意出现
                </xs:all>
# uml
    Unified Modeling Languag
    静态模型
        用例图(需求分析):客户看           # 项级图(突出重点)，一级图，二级图，三级图
            参与者(泛化)
            (关联)
            用例(包含，扩展【继承】)                # 是动词，表示功能模块
            注释
        类图：类结构、类关系（可以自动生成java类）
            继承
            实现
            关联（全局变量）【导航性：一对多关系等】【聚合(所有引用)，组合（生命周期相同，如int类型属性）】
                # spring 中的依赖注入是关联
            依赖（局部变量）
        实体关系图ER
    动态模型
        时序图：可以根据时序图写代码
            #　rose工具中时序图中加入参与者：用例图中创建参与者，拖入时序图中
# plantUML
    分类
        salt
                wireframe
        uml
                activity
                class
                component
                sequence
                state
                use case
# markdown
    标题
        # 到 ######开头    # 分别表示一号 到 六号 标题

    字体
        **a**或__a__   # 加粗
        *a*或_a_ # 斜体
        ***a***或___a___ # 加粗斜体
        ~~a~~   # 删除线
    格式
        换行 结尾两空格 或 <br/>

    引用
        >a
        >>b # 不断增加>来多层引用

    分割线
        --- # 三个及以上
        *** # 三个及以上，与---显示无分别

    图片
        ![alt内容](url "title内容") # alt显示在图片下，title在鼠标悬停时显示

    超链接
        [文本](url)
        <a href="url" target="_blank">文本</a>    # 可以用a标签指定target，在新页面显示

    列表
        -或+或*开头 # 无序列表-
        数字加点开头  # 有序列表，行数自动
        多空格（至少两个）加列表开头  # 嵌套列表

    表格
        标题1|标题2|标题3 # 默认居中对齐
        -|-|-   # -可以多个，:-控制标题和内容左对齐，:-:居中，-:右对齐
        1|2|3   ＃ 默认左对齐

    代码
        `a + b;`    # 单选代码
        ```
        function a(){
        }
        ``` # 多行代码
            # tab开头


    流程图
        略
# org-mode
# restructedText
# LaTex
