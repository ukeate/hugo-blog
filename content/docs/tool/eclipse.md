---
Categories: ["工具"]
title: "Eclipse"
date: 2018-10-11T18:33:08+08:00
---

# 方案
    user library发布
            项目右键 -> properties -> Deployment Assembly -> add -> javaBuild Path Entries中选择发布包
    tomcat设置发布到外部
            new server -> 直接finish
            右键server -> open        
                    修改server location -> use Tomcat installation
                    修改server location -> deploy path为webapps
                    修改TimeOuts ->所有时间为1200
    java版本
            window -> preferences -> java -> compiler
            window -> preferences -> java -> installed JREs
    编码
            general -> workspace
                    Text file encoding
            general -> content types
                    Text -> java source file 
                            defalt encoding输入UTF-8并点击update
    快捷键
            general -> editors -> keys
                    content assist                # 代码提示
                    word comletion                # 代码补全
# 插件
    market place
            http://www.eclipse.org/mpc/
            在线网页
                    http://www.eclipse.org/mpc/archive.php
            在线安装(luna)
                    http://download.eclipse.org/mpc/releases/1.3.0/
            yum
                    eclipse-mpc
    subclipse
            yum
                    eclipse-subclipse
    jdt java8 support
            help -> market place -> find: java 8
                    java 8 support for eclipse 
            在线安装(kepler)
                    http://download.eclipse.org/eclipse/updates/4.3-P-builds/
                    网站
                            http://wiki.eclipse.org/JDT/Eclipse_Java_8_Support_For_Kepler
    m2e
            在线
                    http://download.eclipse.org/technology/m2e/releases 
# mvn项目
    创建web 项目
            maven project 
                    catalog: internal
                    filter:webapp
                            org.apache.maven.archetypes
            项目右键 - new -> source folder
                    src/main/java
                    src/main/resources
                    src/test/java
                    src/test/resources
                            # 可以在navigator中创建, 再:
                            ## 项目右键 -> buildpath -> configure... -> source -> add folder添加以上4个source folder
            修改 configure build path -> source 中2个source folder中的output folder
                    src/main/java                target/classes
                    src/main/resources        target/classes
                    src/test/java                target/test-classes
                    src/test/resources        target/test-classes
            修改 configure build path -> libraries -> jre system library -> edit
            右键 -> properties ->java compiler -> 1.8
            

            项目右键 -> run as -> maven install                #下载依赖包
            右键 -> properties -> project facets -> convert to faceted from
                    选中 dynamic web module
                    选中 java
                    右边选择runtime
                    下面further configuration available
                            content directory: src/main/webapp
                            勾选generate web.xml
            右键 -> properties -> deployment assembly中配置文件发布路径
                    去掉test的目录
                    添加发布包maven dependencies
    方案
        修改项目名
                o-> 修改project名
                o-> 修改包名与test包名
                o-> 修改配置文件, 类中的常量, (workspace配置文件[maven项目没有这些文件])                # ctrl + h 全局搜索(替换)
                o-> mvn clean
                o-> mvn install
                o-> preferences -> web project settings -> context root中修改项目名称
        集成spring
            pom.xml中添加spring依赖

# myEclipse
    假错误（problem view中删掉）

    目录结构
            /Common/中存储的是jar包与配置
                    plugins/存放插件
                    features/存放外观
            /MyEclipse 10/中
                    dropins/配置自定义插件

    调整format一行最大字符数        Java — Code Style — Formatter — Active profile — Edit — Line Wrapping — Maximum line width
    修改，自定义alt + / 模板        包括@anthor 等等        Java — Editor — Templates
    修改编码:window --> General --> Workspace
                    Myeclipse --> files and editors
    忽略校验:右键 --> myeclipse --> exclude from validation
    package Explor 中可以go into  和 up 缩小和扩大显示范围

    鼠标右键 -->Run As --> Run Configuration --> Arguments --> Program Arguments 设置运行传入的参数 

    new 中可以生成测试文件

    window --> preferences --> MyEclipse --> validation --> disableAll 取消验证

    Package Explorer中什么也不显示（进入了已经关闭的包时） --> navigator --> open project
                                                                                            或者{workspaces}\.metadata\.plugins\org.eclipse.ui.workbench\workbench.xml文件中
                                                                                            搜索<input factoryID="org.eclipse.ui.internal.model.ResourceFactory"，把path的值改为"/"
            其它原因：window --> reset perspective
                            Package Explorer 上的倒三角中：deselect working set
    struts2配置myeclipse编写xml文件时的提示
            ## 约束文件的相对路径：struts-2.3.15.1\src\core\src\main\resources\struts2.0.dtd
            ## xml文件中声明的url：http://struts.apache.org/dtds/struts-2.0.dtd
            ## myeclipse中：window        --> Preferences --> MyEclipse --> XML --> XML Catalog --> XML Catalog Entries 选中User Specified Entries --> 点击add
            ## Location中关联源码路径,Key Type 选择 URI,Key中写xml文件中声明的url 
    改变Package Explorer Vier中包的为分层显示方式：
            Package Explorer 视窗中 --> 点击倒三角 --> Package Presentation --> hierarchical ：
            
    导入war文件：
            新建webPorject --> File===》import==》General中选择Archive File --> Form archive file中选择要导入的项目.war -> 导入

    ctrl + shift + t 关联源码快捷键
                                                    
    设置字体：eclipse preference-->Colors and Fonts-->basic-->Text Font-->edit

    导入dtd/xsd约束文件:window -> preferences -> XmlCatalog -> add
            dtd直接导入文件就可以了,xsd要在添加时key的选项中补上文件名
            
    自定义jar包library目录
            项目 右键:building path -> addLiber->user liber配置userLibery右键:building path -> addLiber->user liber配置userLibery
                    只是作了外部的引用,workspace中没有包，但是别人导入时会搜索同名的userLibery自动进行配置
    改javaee版本    
            1.修改项目中的javaee包
            2.项目工程目录/settings/org.eclipse.wst.common.project.facet.core.xml/中修改javaee版本

    在线安装svn
            Help -> install from site(Myeclipse2013) -> add -> url=http://subclipse.tigris.org/update_1.6.x
            不选择 Subclipse -> Subclipse Integration for Mylyn 3.x , 其它全选

    在线安装mylyn
            同上，url(Myeclipse2013):http://download.eclipse.org/mylyn/snapshots/weekly
## 插件
    myeclipse 2013 安装svn
            help -> Install from Site ->add
                    name : Svn
                    Location : http://subclipse.tigris.org/update_1.6.x
                            或
                            http://subclipse.tigris.org/update
            下一步
                    不要选择Subclipse选项下的Subclipse Integration for Mylyn 3.x(Optional)
            一直下一步

    本地安装svn插件
## 快捷键
    alt /
    ctrl shift f
        # 代码格式化
    alt enter
        # 补全提示
    f3
        # 跳转到声明
    f2 显示类或方法的全限定名
    ctrl + h 多文件搜索        
    alt shift s
    alt shift z :surround with 
    ctrl /
    ctrl shift /
    F5 F6 F7
    ctrl alt 上下
    alt 上下
    alt shift x j ：运行
    ctrl 1 显示错误红线的处理方法
    ctrl t 显示继承关系
    ctrl 左右 跳过单词
    ctrl 上下滚屏
    ctrl l 定位
    输入时直接点分号就可以跳到最后
    ctrl alt / 写过内容补全
    字符串最后敲回车可以自动加入 + '\n' ""
    ctrl shift T  openType 查找类关系
    ctrl shift R  查找资源文件
    alt shift A 矩形操作
    alt 左右 返回代码上一层，进入代码下一层
    ctrl o 获得outline
    // TODO 标签
    alt + shift + R 重构中的重命名
    ctrl + shift + o 全局导包
    ctrl + shift + m 局部导包
    ctrl + shift + X  改为大写
    ctrl + shift + g  查看方法被谁调用
    ctrl + shift + h  输入类名，查看类继承关系
    命令补全：syso main        alt + /
    代码抽取:        alt + shift + M
    代码自动生成get set                alt + shift +s
    代码自动生成 — 重写equals hashCode  alt + shift + s
        

    Ctrl+1 快速修复(最经典的快捷键,就不用多说了)
    Ctrl+D: 删除当前行 
    Ctrl+Alt+↓ 复制当前行到下一行(复制增加)
    Ctrl+Alt+↑ 复制当前行到上一行(复制增加)
    Alt+↓ 当前行和下面一行交互位置(特别实用,可以省去先剪切,再粘贴了)
    Alt+↑ 当前行和上面一行交互位置(同上)
    Alt+← 前一个编辑的页面
    Alt+→ 下一个编辑的页面(当然是针对上面那条来说了)
    Alt+Enter 显示当前选择资源(工程,or 文件 or文件)的属性
    Shift+Enter 在当前行的下一行插入空行(这时鼠标可以在当前行的任一位置,不一定是最后)
    Shift+Ctrl+Enter 在当前行插入空行(原理同上条)
    Ctrl+Q 定位到最后编辑的地方
    Ctrl+L 定位在某行 (对于程序超过100的人就有福音了)
    Ctrl+M 最大化当前的Edit或View (再按则反之)
    Ctrl+/ 注释当前行,再按则取消注释
    Ctrl+O 快速显示 OutLine
    Ctrl+T 快速显示当前类的继承结构
    Ctrl+W 关闭当前Editer
    Ctrl+K 参照选中的Word快速定位到下一个
    Ctrl+E 快速显示当前Editer的下拉列表(如果当前页面没有显示的用黑体表示)
    Ctrl+/(小键盘) 折叠当前类中的所有代码
    Ctrl+×(小键盘) 展开当前类中的所有代码
    Ctrl+Space 代码助手完成一些代码的插入(但一般和输入法有冲突,可以修改输入法的热键,也可以暂用

    Alt+/来代替)
    Ctrl+Shift+E 显示管理当前打开的所有的View的管理器(可以选择关闭,激活等操作)
    Ctrl+J 正向增量查找(按下Ctrl+J后,你所输入的每个字母编辑器都提供快速匹配定位到某个单词,如果没

    有,则在stutes line中显示没有找到了,查一个单词时,特别实用,这个功能Idea两年前就有了)
    Ctrl+Shift+J 反向增量查找(和上条相同,只不过是从后往前查)
    Ctrl+Shift+F4 关闭所有打开的Editer
    Ctrl+Shift+X 把当前选中的文本全部变味小写
    Ctrl+Shift+Y 把当前选中的文本全部变为小写
    Ctrl+Shift+F 格式化当前代码
    Ctrl+Shift+P 定位到对于的匹配符(譬如{}) (从前面定位后面时,光标要在匹配符里面,后面到前面,则反

    之)
    下面的快捷键是重构里面常用的,本人就自己喜欢且常用的整理一下(注:一般重构的快捷键都是Alt+Shift

    开头的了)
    Alt+Shift+R 重命名 (是我自己最爱用的一个了,尤其是变量和类的Rename,比手工方法能节省很多劳动力

    )
    Alt+Shift+M 抽取方法 (这是重构里面最常用的方法之一了,尤其是对一大堆泥团代码有用)
    Alt+Shift+C 修改函数结构(比较实用,有N个函数调用了这个方法,修改一次搞定)
    Alt+Shift+L 抽取本地变量( 可以直接把一些魔法数字和字符串抽取成一个变量,尤其是多处调用的时候)
    Alt+Shift+F 把Class中的local变量变为field变量 (比较实用的功能)
    Alt+Shift+I 合并变量(可能这样说有点不妥Inline)
    Alt+Shift+V 移动函数和变量(不怎么常用)
    Alt+Shift+Z 重构的后悔药(Undo)
    编辑
    作用域 功能 快捷键 
    全局 查找并替换 Ctrl+F 
    文本编辑器 查找上一个 Ctrl+Shift+K 
    文本编辑器 查找下一个 Ctrl+K 
    全局 撤销 Ctrl+Z 
    全局 复制 Ctrl+C 
    全局 恢复上一个选择 Alt+Shift+↓ 
    全局 剪切 Ctrl+X 
    全局 快速修正 Ctrl1+1 
    全局 内容辅助 Alt+/ 
    全局 全部选中 Ctrl+A 
    全局 删除 Delete 
    全局 上下文信息 Alt+？
    Alt+Shift+?
    Ctrl+Shift+Space 
    java编辑器 显示工具提示描述 F2
    java编辑器 选择封装元素 Alt+Shift+↑
    java编辑器 选择上一个元素 Alt+Shift+←
    java编辑器 选择下一个元素 Alt+Shift+→
    文本编辑器 增量查找 Ctrl+J 
    文本编辑器 增量逆向查找 Ctrl+Shift+J 
    全局 粘贴 Ctrl+V 
    全局 重做 Ctrl+Y 

    查看
    作用域 功能 快捷键 
    全局 放大 Ctrl+= 
    全局 缩小 Ctrl+- 

    窗口
    作用域 功能 快捷键 
    全局 激活编辑器 F12 
    全局 切换编辑器 Ctrl+Shift+W 
    全局 上一个编辑器 Ctrl+Shift+F6 
    全局 上一个视图 Ctrl+Shift+F7 
    全局 上一个透视图 Ctrl+Shift+F8 
    全局 下一个编辑器 Ctrl+F6 
    全局 下一个视图 Ctrl+F7 
    全局 下一个透视图 Ctrl+F8 
    文本编辑器 显示标尺上下文菜单 Ctrl+W 
    全局 显示视图菜单 Ctrl+F10 
    全局 显示系统菜单 Alt+- 

    导航
    作用域 功能 快捷键 
    ｊａｖａ编辑器 打开结构 Ctrl+F3 
    全局 打开类型 Ctrl+Shift+T 
    全局 打开类型层次结构 F4 
    全局 打开外部ｊａｖａdoc Shift+F2
    全局 打开资源 Ctrl+Shift+R 
    全局 后退历史记录 Alt+← 
    全局 前进历史记录 Alt+→ 
    全局 上一个 Ctrl+, 
    全局 下一个 Ctrl+. 
    ｊａｖａ编辑器 显示大纲 Ctrl+O 
    全局 在层次结构中打开类型 Ctrl+Shift+H 
    全局 转至匹配的括号 Ctrl+Shift+P 
    全局 转至上一个编辑位置 Ctrl+Q 
    ｊａｖａ编辑器 转至上一个成员 Ctrl+Shift+↑ 
    ｊａｖａ编辑器 转至下一个成员 Ctrl+Shift+↓ 
    文本编辑器 转至行 Ctrl+L 

    搜索
    作用域 功能 快捷键 
    全局 出现在文件中 Ctrl+Shift+U 
    全局 打开搜索对话框 Ctrl+H 
    全局 工作区中的声明 Ctrl+G 
    全局 工作区中的引用 Ctrl+Shift+G 

    文本编辑
    作用域 功能 快捷键 
    文本编辑器 改写切换 Insert 
    文本编辑器 上滚行 Ctrl+↑ 
    文本编辑器 下滚行 Ctrl+↓ 

    文件
    作用域 功能 快捷键 
    全局 保存 Ctrl+X 
    Ctrl+S 
    全局 打印 Ctrl+P 
    全局 关闭 Ctrl+F4 
    全局 全部保存 Ctrl+Shift+S 
    全局 全部关闭 Ctrl+Shift+F4 
    全局 属性 Alt+Enter 
    全局 新建 Ctrl+N 

    项目
    作用域 功能 快捷键 
    全局 全部构建 Ctrl+B 

    源代码
    作用域 功能 快捷键 
    java编辑器 格式化 Ctrl+Shift+F
    java编辑器 取消注释 Ctrl+\
    java编辑器 注释 Ctrl+/
    java编辑器 添加导入 Ctrl+Shift+M
    java编辑器 组织导入 Ctrl+Shift+O
    java编辑器 使用try/catch块来包围 未设置，太常用了，所以在这里列出,建议自己设置。
    也可以使用Ctrl+1自动修正。 

    运行
    作用域 功能 快捷键 
    全局 单步返回 F7 
    全局 单步跳过 F6 
    全局 单步跳入 F5 
    全局 单步跳入选择 Ctrl+F5 
    全局 调试上次启动 F11 
    全局 继续 F8 
    全局 使用过滤器单步执行 Shift+F5 
    全局 添加/去除断点 Ctrl+Shift+B 
    全局 显示 Ctrl+D 
    全局 运行上次启动 Ctrl+F11 
    全局 运行至行 Ctrl+R 
    全局 执行 Ctrl+U 

    重构
    作用域 功能 快捷键 
    全局 撤销重构 Alt+Shift+Z 
    全局 抽取方法 Alt+Shift+M 
    全局 抽取局部变量 Alt+Shift+L 
    全局 内联 Alt+Shift+I 
    全局 移动 Alt+Shift+V 
    全局 重命名 Alt+Shift+R 
    全局 重做 Alt+Shift+Y 
# jrebel
    介绍
            热加载
    使用:
            myeclipse根目录下配置自定义 插件
            window -> preferences -> JRebel中关联jar包，设定自动部署时间
        window -> preferences -> services -> tomcat -> tomcat6(可以配置是否启用jrebel和打印jrebel的日志)->jdk 加上资源分配参数与tomcat要加载的jar包:
                            -noverify -javaagent:D:\(修改为自己的目录)\jrebel.jar -Xmx512M -Xms512M -XX:MaxPermSize=1024m
            项目右键jrebel生成reble.xml,其中配置rebel要管理的项目在tomcat中的路径