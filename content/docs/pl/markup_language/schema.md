---
Categories: ["语言"]
title: "Schema"
date: 2018-10-10T17:55:28+08:00
---

# Schema约束
    tld文件是Schema约束的
# 引入
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
# 语法
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
