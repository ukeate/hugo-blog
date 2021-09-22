---
Categories : ["前端"]
title: "Bootstrap"
date: 2018-10-11T09:39:11+08:00
---

# 介绍
    在jquery基础上的组件框架

# 移动
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
# css
    全局
            container
                    # div, 唯一包裹容器
            container-fluid
                    # 占全部视口
    栅格
            # 必须放在row内
            col-xs-1
                    # 适用于大于等于分界点的屏幕
                    ## 大于12的最后那个col另起一行排列
                    # xs < 768px 宽度, container 最大宽度: 自动
                    # sm >= 768px, 750px
                    # md >= 992px, 970px
                    # lg >= 1200px, 1170px
            
            col-md-offset-4
                    # 向右偏移4
            col-md-pull-9
                    # 向后推9, 改变元素的顺序
            col-md-push-3
            
            o-> mixin
            make-row
                    如 .wrapper {.make-row();}
            make-xs-column
            make-sm-column-offset
            make-sm-column-push
            make-sm-column-pull
## 样式
    muted
            # 文本颜色
            text-warning
            text-error
            text-info
            text-success
    text-left
            # 文本左对齐
            text-center
            text-right
            text-justify
            text-nowrap
            text-lowercase
            text-uppercase
            text-capitalize

    bg-primary
            # p
            bg-success
            bg-info
            bg-warning
            bg-danger

    success
            # 状态类
            # table行颜色, control-group div
            error
            danger
            warning
            info
            active
    has-warning
            # div元素
            # 适用class: control-label, form-control, help-block
            has-error
            has-success
    has-feedback
            # div, 
    
    pull-right
            # 任意元素向右浮动
            pull-left
    navbar-right
            # 导航条中向右浮动
            navbar-left
    clearfix
            # 清除浮动

    initialism
            # 缩略语样式, abbr标签
    small
            # small标签的样式
    lead
            # p标签，突出显示
    blockquote-reverse
            # blockquote标签使用, 内容右对齐

    disabled
            # btn, input, 只disable样式
            o-> 适用的class
            radio
            radio-inline
            checkbox
            checkbox-inline
            o-> 适用的标签
            fieldset

    inline
            # 行内ul, checkbox

    center-block
            # 任意元素, 水平居中

    show
            # 任意元素显示
            hidden

    .sr-only
            # 任意元素, 辅助技术支持的文本, 隐藏当前元素
            sr-only-focusable
                    # 元素有焦点时显示出来

    visible-xs-block
            # 只对xs屏幕可见
            visible-xs-inline
            visible-xs-inline-block
    hidden-xs
            # 对xs屏隐藏
    visible-print-block
            # 对打印机可见
            visible-print-inline
            visible-print-inline-block
    hidden-print
## table
    table
            # table样式
    table-responsive
            # div元素，包裹table样式后，创建响应式表格，带有滚动条
    table-striped
            # 斑马纹样式
    table-bordered
            # 边框圆角
    table-hover
            # 行悬停样式
    table-condensed
            # 内补减半使更紧凑
## form
    form-search
            # form标签中添加，其中有input
            search-query
                    # search中的input的样式
    form-actions
            # div元素, 内部按钮自动缩进
    form-inline
            # 行内表单
    form-actions
            # div元素，按钮列表，和表单其它元素对齐
    form-horizontal
            # 元素右对齐左浮动的表单
    form-group
            # form中的div元素
            form-control
                    # input, textarea, select
                    o-> 支持的input类型
                    text
                    password
                    datetime
                    datetime-local
                    date
                    month
                    time
                    week
                    number
                    email
                    url        
                    search
                    tel        
                    color    
            form-control-static
                    # p标签，用来代input显示文本  
            control-group
                    control-label
                    controls
            input-group
                    input-group-addon
                            # span
                    form-control
                            # 同外
            glyphicon-ok
                    # input元素或input-group的div元素后的span, 添加input内的图标
                    # 联合使用 class: glyphicon, form-control-feedback; 
                    ## 属性 aria-hidden="true"
                    glyphicon-warning-sign
                    glyphicon-remove
                    
    checkbox
            # div, label
    radio
            # div, label
    checkbox-inline
            # div
    radio-inline
            # div

    controls
            # div元素，为input增加合适的间距, 浮动它们缩减空白，再清除浮动
            controls-row
                    # 排一行，增加合适间距

    input-mini
            input-small
            input-medium
            input-large
            input-xlarge
            input-xxlarge
    input-sm
            # input, select, 高度
            input-lg
    form-group-sm
            # class为form-group的div, 高度
            form-group-lg
            
    input-prepend
            # 前缀input, 可与input-append组合
            add-on
                    # span标签
            btn
            span2
                    # input标签
    input-append

    input-block-level
            # 块级input
    uneditable-input
            # span元素模拟不可编辑input
## 小件
    btn
            # a, button, input
    btn-group
            # div标签 按钮下拉菜单
            dropdown-toggle
                    # 要赋加自定义属性data-toggle="dropdown"来关联执行js
            dropdown-menu
                    # ul标签
    btn-primary
            # 按钮样式
            btn-info
            btn-success
            btn-warning
            btn-danger
            btn-inverse
            btn-link
            btn-default
    btn-lg
            btn-sm
            btn-xs
    btn-block
            # 块级按钮

    span1
            # input元素, select元素
            span2
            span3
            span4
            span5
    help-inline
            # span元素，帮助文本
    help-block
            # span元素, 块显示帮助

    img-rounded
            # img, 图片样式
            img-circle
            img-polaroid
    img-responsive
            # img, 图片响应式
    
    caret
            # span标签, 下箭头
    close
            # button, 关闭图


    list-unstyled
            # 无样式列表
    dl-horizontal
            # dl列表水平描述
    pre-scrollable
            # pre标签内容滚动
    text-overflow
            # 截断改写数据, 可能会垂直显示
    text-hide
            # h1, 将元素的文本内容替换为背景图
## 导航
    <div role="navigation"
            # 如果作为导航条, 父元素加属性，或者用nav标签
            <ul class="nav nav-tabs"
                    # nav-pills 改成胶囊样式
                    # nav-stacked 改成垂直
                    # nav-justified 自适应宽度
                    <li role="presentation" class="active"
                            # disabled
                    <li role="presentation" class="dropdown"
                            <a class="dropdown-toggle" role="button" 
                                    data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false" 
                            <ul class="dropdown-menu"

    <nav class="navbar navbar-default"
            # 添加navbar-fixed-top可以冻结到顶部
            ## 设置body{padding-top: 70px;}来使内容不被遮盖
            ## navbar-fixed-bottom, 同样要设置padding-bottom
            ## navbar-static-top 向下滚动就消失
            # navbar-inverse 反色
            <div class="container-fluid"
                    <div class="navbar-header"
                            <a class="navbar-brand"
                                    <img alt="Brand"
                                            # 图标
                            <button type="button" class="navbar-toggle collapsed"
                                    data-toggle="collapse" 
                                    data-target="#bs"
                                    aria-expanded="false"
                                    <span class="icon-bar"
                                            # 放隐藏菜单的
                                    <span class="icon-bar"
                                    <span class="icon-bar"
                            <a class="navbar-brand"
                    <button type="button" class="btn btn-default navbar-btn"
                            # navbar-btn可以上按钮垂直居中
                    <p class="navbar-text"
                    <div class="collapse navbar-collapse" id="bs"
                            <ul class="nav navbar-nav"
                                    <li><a
                            <form class="navbar-form navbar-left" role="search"
                                    # navbar-form自动垂直对齐，折叠
                                    # navbar-left 让正确对齐，由pull-left mixin而来
                                    <div class="form-group"
                                            <input class="form-control"
                                    <button class="btn btn-default"
                            <ul class="nav navbar-nav navbar-right"
                            <p class="navbar-text navbar-right"
                                    # 不支持多个navbar-right
                                    <a class="navbar-link"

    <ol class="breadcrumb"
            # 面包屑
            <li
            <li class="active"
## 图标
    icon-white
            # 反色为白色
    fa-dashboard
            # 配合fa使用                
            fa-fw
                    # 小左箭头
    fa-lg
## 默认渲染
    <h1> ... <h6>
    <small>
    <p>
    <mark>
    <del>
    <s>
    <ins>
    <u>
    <small>
    <strong>
    <em>
    <abbr>
    <address>
    <blockquote>
            <p>
            <footer>
                    <cite>
    <ul>
            <li>
    <ol>
            <li>
    <dl>
            <dt>
            <dd>
    <code>
    <kbd>
    <pre>
    <var>
    <samp>
            # 程序输出
    属性
            aria-label
                    # input元素, 替代label
            aria-labelledby
            title
                    # 辅助功能阅读
            aria-describedby
                    # input 辅助阅读
            disabled
            readonly
# less
    @baseFontSize
            @font-size-base
            # 全局font-size基准，计算出所有页面元素的margin, padding, line-height, 改变bootstrap默认样式
    @baseLineHeight
            @line-height-base
            # 同上, line-height基准
# 案例
    <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                    # table table-condensed 紧凑型表格
                    <thead>
                            <tr>
                                    <th>标题
                    <tbody>
                            <tr class="active">
                                    # success info warning danger
    </div>
# 插件
    scrollspy
        介绍
                监测滚动到目前页面锚点
# 工具
    bootInit
        介绍
                检测bootstrap标签语法，不支持扩展插件
