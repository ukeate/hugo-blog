---
Categories: ["语言"]
title: "Dtd"
date: 2018-10-10T17:54:44+08:00
---

# 注意
        同名元素只能用命名空间来区分定义

# 例子
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
# 语法
        <!ELEMENT author (#PCDATA)> 之中的两个空格必须要有
        
# 元素类型
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
# 属性类型
