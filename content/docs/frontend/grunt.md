---
Categories : ["前端"]
title: "Grunt"
date: 2018-10-11T09:37:01+08:00
---

# 介绍
        压缩js代码
        合并js文件
        单元测试
        js代码检查
        监控文件修改重启任务
# 命令
        grunt dist
                # 重新生成dist目录，将编译后的css,js放入
        grunt watch
                # 监测less源码文件改动，自动重新编译为css
        grunt test
                # 运行测试用例
        grunt docs
                # 编译并测试
        grunt 重新构建所有内容并运行测试用例
# 安装
        # grunt模块以grunt-contrib-开头
        npm i -g grunt grunt-init grunt-cli
        
# 例子
    o->
    // Gruntfile.js
    module.exports = function (grunt) {
            grunt.loadNpmTasks('grunt-contrib-clean')
            grunt.loadNpmTasks('grunt-contrib-concat')
            grunt.loadNpmTasks('grunt-contrib-jshint')
            grunt.loadNpmTasks('grunt-contrib-uglify')
            grunt.loadNpmTasks('grunt-replace')

            grunt.initConfig({
                    pkg: grunt.file.readJSON('package.json'),
                    jshint: {
                            all: {
                                    src: ['Gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
                                    options: {
                                            jshintrc: 'jshint.json'
                                    }
                            }
                    },
                    clean: ['lib'],
                    concat: {
                            htmlhint: {
                                    src: ['src/core.js', 'src/reporter.js', 'src/htmlparser.js', 'src/rules/*.js'],
                                    dest: 'lib/htmlhint.js'
                            }
                    },
                    uglify: {
                            htmlhint: {
                                    options: {
                                            banner: 'a',
                                            beautify: {
                                                    ascii_only: true
                                            }
                                    },
                                    files: {
                                            'lib/<%= pkg.name %>.js': ['<%= concat.htmlhint.dest %>']
                                    }
                            }
                    },
                    relace: {
                            htmlhint: {
                                    files: {'lib/htmlhint.js': 'lib/htmlhint.js'},
                                    options: {
                                            prefix: '@',
                                            variables: {
                                                    'VERSION': '<%= pkg.version %>'
                                            }
                                    }
                            }
                    }
            })
            grunt.registerTask('dev', ['jshint', 'concat'])
            grunt.registerTask('default', ['jshint', 'clean', 'concat', 'uglify', 'replace'])
    }
