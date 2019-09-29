---
Categories : ["前端"]
title: "Angular"
date: 2018-10-11T07:47:51+08:00
---

# 介绍
    google发布
    提倡SPA(Single Page Apps), 运行快，一次加载
    mvvm
# 特点
    前端mvc
    双向数据绑定
    指令和语义化标签
    模块化工具
    依赖注入
    html模板
    常用工具封装，如$http $cookies $location
# directive
    内置
        ng-app                      # 声明app名, 在最外层
        ng-submit                   # <form ng-submit="submit()">
        ng-controller
        ng-repeat                   # $index返回当前引用的元素序号，$first, $middle, $last 返回布尔值
        ng-model                    # 绑定当前元素的值
        ng-click
            ng-eventhandler="expression"类的指令可以在所有浏览器中有相同的行为，angular将会屏蔽差异性
            不会在全局命名空间中进行操作，指定的表达式只能访问元素控制器作用域范围内的函数和数据
        ng-bind
        ng-change
        <form ng-submit="aaFunc()"> # 会阻止浏览器默认的提交操作
        ng-dblclick
        ng-show
        ng-hide
        ng-class                    # 可以是类名字符串，空格分隔，可以是类名数组，可以是类名到布尔值的映射
            ng-class="{true: 'active', false: 'inactive'}[isActive]"
            ng-class="{'selected': isSelected, 'car': isCar}"
        ng-style                    # templete中写css不好维护
        ng-src="/images/cats/{{favoriteCat}}"       # src，href属性中简单使用templete,由于浏览器优先并行加载图片和其它内容,angular没有机会拦截到数据绑定请求，所以无法运行
        ng-href
        ng-options
            <select ng-model="x" ng-options="(m.a + ' - ' + m.b) group by m.c for (key, m) in opts">
    自定义
        angular.module('CAT.TryDrt', [])
        .directive('hello', function(){
            return {
                restrict: 'E',                          # E: element, A:attribute, C:class, M: comment
                template: '<div>Hello world</div>',     # 标签内容
                replace: true                           # 表示替换原标签
            }
        });

        <hello></hello>
# controller
    使用
        通过ng-controller
        router中绑定到动态加载的dom模板片段上
    作用
        初始化页面状态
        通过$scope对象暴露数据模型给视图
        监视模型变化，并采取相应动作
    嵌套
        原理是$scope的继承
# templete
    使用范围
        页面中
        value、class、style属性
    表达式                      # 自定义的解释器而非eval执行
        + - * / %
        == != > < >= <=
        && || !
        \^ & |
        $scope中暴露的函数
                # 但不是视图的职责，也不利于测试
        {} []
    filter
        使用
            expression | filterName : parameter1 : parameter2 : ...
            可以多次过滤, 11.2 | currency | number:0 会显示$11

        currency                # 数字过滤成美元
        date
        number
        uppercase

        自定义
            homeModule.filter('titleCase', function(){
                var titleCaseFilter = function (input){
                    var words = input.split(' ');
                    for(var i = 0; i < words.length; i++){
                        words[i] = words[i].charAt(0).toUpperCase() + words[i].slice(1);
                    }
                    return words.join(' ');
                };
                return titleCaseFilter;
            })

            {{pageHeading | titleCase}}
# module
    api
        angular
            module('todoApp', [])       # 数组中传入依赖的外部模块名
            controller('TodoListController', function(){
                var todoList = this;
                todoList.todos = [{a:'a1'},{a:'a2'}];
                todoList.addTode = function(){}
            });
            value()
            service()
            config()
            factory('globalInterceptor', GlobalInterceptor)
            run()
            angular.ent($('.container')).scope().fetchDept()    # 得到element的scope

        o-> 例子
        angular.module('project', ['ngRoute', 'firebase'])
        .value('fbURL', 'https://ng-projects-list.firebaseio.com/')
        .service('fbRef', function(fbURL){return new Firebase(fbURL)
        })
        .service('fbAuth', function...)
        .config(function($routeProvider){
            var resolveProjects = {
                projects: function(Projects){
                    return ...
                }
            };
        })

        o->
        xxxModule.config(function ($routeProvider) {
            $routeProvider
            .when('url', {controller: aController, templateUrl: '/path/to/template'})
            .when(..)
            .otherwise(..);
        })

        o->
        someModule.config(function($routeProvider){
            $routeProvider.
                when('url', {controller: aController, templateUrl: '/path/to/template'}).
                when(...) ...
                otherwise(...)
        })

    第三方module
        ngCookies
        ngAnimate
        'ngWebSocket'
        angularJwt
        ngclipboard
        react.name
        'flow'
            # 文件上传
        'flowchart'
            # 流程图
        ngTouch
        'angular-carousel'
            # 图片轮换, 可移动端

        FBAngular.name
            # 全屏
        ngMaterial
            # 响应式布局
        ngMdIcons
            # 图标
        angularSocialshare
            # 社交分享
        'pascalprecht.translate'
            # 国际化
        'mdColorPicker'
            # 颜色选择器
        'ngMaterialDateRangePicker'
            # 日期选择器
        mdPickers
            # 日期选择器
        ngSanitize
            # html过滤
        vAccordion
            # 折叠菜单
        'dndLists'
            # 拖拽
        mdDataTable
            # 表格
        fixedTableHeader
            # 表头固定
        'material.components.expansionPanels'
            # 可扩展panel
        'mdSteppers'
            # 步骤图
# 对象
    内置
        $rootScope          # 全局作用域
        $scope
        $scope.$watch
            监控属性或函数
            $watch(watchFn, watchAction, deepWatch)
                # angular的表达式(如$scope.xxx)或字符串，函数或表达式，布尔。返回一个函数，用来注销watcher
                # watch中的函数会翻倍执行，来检测模型中的变更已经被完整地进行了传播。会把所有被监控的属性都复制一份，再与当前值比较，看是否发生了变化。
                ## 最多运行10次，如果10次中watchFn的值都发生变化，则可能有循环依赖。
                ## Object.observe()会优化这一点，在支持此函数的地方自动使用它。
            $watch($scope.totalCart, calculate)
                # totalCart是函数
            $watch('items', calculate)
                # items是$scope.items数组
            $watch(function(){
                for($scope.items)
                $scope.bill.totalCartNum = total;
            })
            # 如果监控多个属性可以
            ## 监控这些属性连接起来的表达式
            ## deepWatch这些属性的数组
        $scope.$apply
            # 在所有绑定关系都获得刷新，所有变化都反映到了视图上时懒惰调用，angular定时提醒这个服务
            # 自主修改dom后，只是在$apply中注册并不调用，如果想马上得到angular双向绑定后的结果，要手动调用$apply
            # 触发完digest循环后执行回调
            $scope.$apply(function () {})
        $scope.$digest
            # 只是触发digest循环
            $scope.$digest()
# 服务
    内置
        $location
        $log
        $http
        $route
        $routeProvider
        $urlRouterProvider
        $stateProvider
        $locationProvider
        $timeout
        $parse
            var submitHandler = $parse(attrs.ngSubmit)(scope);
            submitHandler();
        $q                  # node q, 并发控制
        $injector           # get注入的模块
    创建服务
        provider
            # 创建可配置的服务
        factory
            # 创建不可配置的服务
        service
            # 创建不可配置的服务，比较简单
# 浏览器插件
    Batarang
        # 调试