---
Categories : ["前端"]
title: "React"
date: 2018-10-11T07:32:08+08:00
---

# 介绍
    facebook推出的用于build user interfaces 的类库
# 使用
    o-> webpack
    # webpack.config.js
    var webpack = require('webpack')
    module.exports = {
            devtool: 'inline-source-map',
            entry: ['webpack/hot/dev-server', __dirname + '/app/main.js'],
            output: {
                    path: __dirname + '/build',
                    filename: 'bundle.js'
            },
            module: {
                    loaders: [
                            {
                                    test: /\.(js|jsx)$/,
                                    exclude: /node_modules/,
                                    loader: 'babel-loader',
                            }
                    ]
            },
            plugins: [
                    new webpack.HotModuleReplacementPlugin(),
                    new webpack.DefinePlugin({
                            'process.env': {
                                    NODE_ENV: JSON.stringify('production')
                            }
                    })
            ],
            devServer: {
                    contentBase: __dirname + '/build',
                    historyApiFallback: true,
                    inline: true,
                    port: 3031,
            }
    }

    # index.html
    <div id="content"></div>
    <script src="bundle.js"></script>


    o-> browser
    # index.html
    <script src="build/react.js"></script>
    <script src="build/react-dom.js"></script>
    <script src="browser.min.js"></script>
    <body>
            <div id="example"></div>
            <script type="text/babel">
                    ReactDOM.render(
                            <h1>Hello</h1>
                            document.getElementById('example')
                    )
            </script>
    </body>
# api
    ReactDOM
            render
                    render(
                            <h1>Hello</h1>
                            document.getElementById('example')
                    )
    React
            # createClass
            createClass({
                    getInitialState () {return {liked: false}},
                    handleClick(event) {
                            this.setState({liked: !this.state.liked})
                    },
                    getDefaultProps () {
                            # 设定属性默认值
                            return {title: 'Hello'}
                    },
                    propTypes: {
                            # 限定属性的类型
                            title: React.PropTypes.string,isRequired
                    },
                    render () {return <h1></h1>}
            })
            # createElement
            createElement('h1', {title: 'a'}, 'b')
            # Component
            class List extends React.Component{
                    constructor() {super()}
                    render() {return ()}
            }
            
    this
            # 代表当前标签
            props
                    # 属性
                    children
                            # 代表所有子节点的text
                            # 没有子节点, 是undefined, 有一个子节点, 是Object, 多个子节点是array
                            # React.Children来处理children
            refs
                    # 获取dom
            state
    jsx
        介绍
                < 开头解析为html, { 开头解析为js
        例子
        # Profile.jsx
        import React from 'react';
        export default Class Profile extends React.Component {
                constructor (props) {
                        super(props)
                        this.state = {
                                list: [1,2,3],
                                activeIndex: -1
                        }
                },
                activate (index) {
                        this.setState({activeIndex: index})
                },
                render () {
                        const {list, activeIndex} = this.state
                        const lis = list.map((item, index) => {
                                const cls = index === activeIndex ? 'active' : ''
                                return (
                                        <li key={index} className={cls} onClick={() => this.activate(index)}></li>
                                )
                        })
                        return (<ul>{lis}</ul>)
                }
        }


        o->
        <div>
        {/*注释*/}
        {
                names.map((name) => {return <div>{name}</div>})
        }
        </div>

        o-> ref
        <input ref="domNam">

        o-> 事件
        <p onClick={this.handleClick}>

        o-> 属性
        <Profile {...props} name='a'>
                # 后面的覆盖前面的
# 插件
    react-big-calendar
        日历
# 工具
    JSXTransformer
            # 浏览器中引入，编译jsx
    https://babeljs.io/repl/
            # 在线编译jsx