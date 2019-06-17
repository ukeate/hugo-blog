---
Categories : ["前端"]
title: "Webpack"
date: 2018-10-11T09:37:31+08:00
---

# 介绍
        模块打包

# 命令        
        npm i -g webpack
        npm i css-loader style-loader
        webpack ./entry.js bundle.js
                # --progress 
                # --colors
                # --watch
                # --module-bind
                ## jade, 'css=style!css'
                webpack ./entry.js bundle.js --module-bind 'css=style!css'
                webpack
                        # use webpack.config.js
        npm i webpack-dev-server -g
        webpack-dev-server
                # --progress --colors
                # --hot 热部署
                # 启动一个express在8080端口
# 配置
    # webpack.config.js

    var webpack = require('webpack')
    var merge = require('webpack-merge')
    var path = require('path')
    var HtmlwebpackPlugin = require('html-webpack-plugin')

    var ROOT_PATH = path.resolve(__dirname)
    var APP_PATH = path.resolve(ROOT_PATH, 'app')
    var BUILD_PATH = path.resolve(ROOT_PATH, 'build')

    var baseWebpackConfig = {
            entry: {
                    app: path.resolve(APP_PATH, 'app.jsx')
            },
            output: {
                    path: BUILD_PATH,
                    filename: '[name].js',
                        chunkFilename: '[id].chunk.js',
                    publicPath: '/',
                            # 浏览器路径
            },
            devtool: 'eval-source-map',
            devServer: {
                contentBase: path.resolve(ROOT_PATH, 'build') ,
                historyApiFallback: true,
                inline: true,
                port: 3031
        }
            resolve: {
                    extensions: ['', '.js', '.vue', 'jsx'],
                        # 这样可以在js import 中加载扩展名
                    fallback: [path.join(__dirname, '../node_modules')],
                    alias: {
                            'src': path.resolve(__dirname, '../src'),
                            'assets': path.resolve(_dirname, '../src/assets'),
                            'components': path.resolve(__dirname, '../src/components')
                    }
            },
            resolveLoader: {
                    fallback: [path.join(__dirname, '../node_modules')]
            },
            module: {
                preLoaders: [
                        {
                                test: /\.jsx?$/,
                                loaders: ['eslint'],
                                include: APP_PATH
                        }
                ]
                    loaders: [
                    {
                            test: /\.vue$/,
                            loader: 'vue'
                    }, 
                    {
                            test: /\.js$/,
                            loader: 'babel',
                            include: projectRoot,
                            exclude: /node_modules/
                    },
                    {
                            test: /\.json$/,
                            loader: 'json'
                    },
                    {
                            test: /\.html$/,
                            loader: 'vue-html'
                    },
                    {
                            test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
                            loader: 'url',
                            query: {
                                    limit: 10000,
                                    name: path.posix.join('static', 'img/[name].[hash:7].[ext]')
                            }
                    },
                    {
                            test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
                            loader: 'url',
                            query: {
                                    limit: 10000,
                                    name: path.posix.join('static', 'fonts/[name].[hash:7].[ext]')
                            }
                    }
                    ]
            },
        plugins: [
                    new HtmlwebpackPlugin({title: 'a'})
            ]
    }
    module.exports = merge(baseWebpackConfig, {
    })
# 插件
    内置
            # 通过webpack.BannerPlugin获得
            bannerPlugin
    htmlWebpackPlugin
    hotModuleReplacement