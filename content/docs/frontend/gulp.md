---
Categories : ["前端"]
title: "Gulp"
date: 2018-10-11T09:36:17+08:00
---

# 介绍
        自动化构建项目工具
# 使用
    安装
            npm install --global gulp
                    # npm install --save-dev gulp
            // gulpfile.js 在项目根目录
            var gulp = require('gulp');
            gulp.task('default', function () {
                    // 默认任务代码
            })
    命令
            shell> gulp
                    # gulp <task> <othertask>
# 插件
    gulp-dom-src
            合并src, 改写html
    gulp-if
    gulp-useref
    gulp-usemin
    gulp-htmlreplace
    google-closure-compiler
    gulp-add-src
    gulp-autoprefixer
    gulp-changed
    gulp-clean
    gulp-clean-css
    gulp-concat
    gulp-concat-css
    gulp-consolidate
    gulp-html-replace
            # 替换html内容
    gulp-htmlmin
    gulp-imagemin
    gulp-less
    gulp-make-css-url-version
    gulp-minify-css
    gulp-rev-append
    gulp-uglify