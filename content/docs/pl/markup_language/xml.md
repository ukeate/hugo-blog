---
Categories: ["语言"]
title: "Xml"
date: 2018-10-09T16:51:29+08:00
---

# 标签头
        <?xml version="1.0" encoding="utf-8"?>
# 命名空间
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
 
                        
# dtd文件路径解析
        system声明方式：根据给出URL寻找DTD?DTD通过URL显式地直接定位。
        public声明方式：查找众所周知词汇表，应用程序自行确定从数据库中定位dtd，或是从声明的网站中下载（存入数据库缓存中）。
                # myeclipse中通过xml Catalog选项来定位dtd约束

# schema文件路径解析
        xsd文件中：targetNamespace="http://www.w3school.com.cn"        # 定义自己的uri标识空间名
        xml文件中：xsi:schemaLocation="http://www.w3school.com.cn note.xsd"                # 指定约束文件的uri地址，一般是空间名加/文件名（目前只有cxf的jaxws约束文件例外【把路径换成了包名】）
