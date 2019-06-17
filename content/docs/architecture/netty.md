---
Categories : ["架构"]
title: "Netty"
date: 2018-10-11T16:25:14+08:00
---

# 介绍
        JBOSS提供，由Trustin Lee开发，比mina晚
        java开源框架
# 原理
        基于socket的数据流处理
                # socket数据流不是a queue of packets , 而是a queue of bytes, 所以分次传输的数据会成为a bunch of bytes
# 例子
    Handler
        ChannelHandler
                ChannelOutboundHandler
                        ChannelOutboundHandlerAdapter                        # 可作Encoder
                        MessageToByteEncoder
                ChannelInboundHandler                # 提供可重写的事件
                        ChannelInboundHandlerAdapter
                        ByteToMessageDecoder        # easy to deal with fragmentation issue
                                事件
                                        decode(ctx, in, out)                        # 内部处理过数据，堆积到了buffer(in)
                                                                                ## out中add了数据, 表示decode成功，则执行后抛弃in中数据
                                                                                # decode会被循环调用直到有一次out中没有add东西
                        ReplayingDecoder                
                        事件
                                channelRead()                # 从client接收到数据时调用，数据的类型是ByteBuf
                                                        ## ByteBuf是 reference-counted object
                                                        ## 必须用ReferenceCountUtil.release(msg)或((ByteBuf) msg).release()来明确释放
                                exceptionCaught()        # 当抛出Throwable对象时调用
                                channelActive()                # as soon as a connection is established
                方法
                        handlerAdded()
                        handlerRemoved()
        ByteBuf
                方法
                        buf.writeBytes(m)                # 将m[ByteBuf]中的数据 cumulate into buf[ 定长的ByteBuf, 如ctx.alloc().buffer(4) ]
                        isReadable()                        # 返回ByteBuf中data的长度
        ChannelHandlerContext                # 用于触发一些i/o事件
                方法
                        write(msg)                # msg在flush后自动realease
                                write(msg, promise)                                # promise是ChannelPromise的对象，用来标记msg是否确切地写入到管道中
                        flush()
                        writeAndFlush(msg)                                        # 返回ChannelFuture
                        alloc()                                                        # 分配缓冲区来包含数据
        ByteBufAllocator
                buffer(4)                        # 返回存放32-bit Integer的ByteBuf
    Server
        EventLoopGroup
                NioEventLoopGroup                # 多线程 i/o eventloop
                方法
                        shutdownGracefully()                                                # 返回Funture类来通知group是否完全关闭并且所有group的channels都关闭
        ServerBootstrap                        # 建server的帮助类，链式编程
                                                ## 可以直接用Channel来建server
                方法
                        group(bossGroup, workerGroup)                                # boss接收连接，worker处理boss中的连接
                                group(workerGroup)                                        # 只有一个参数时，该group即作boss也作worker
                        channel(NioServerSocketChannel.class)                        # 用来接收连接的channel的类型
                                channel(NioSocketChannel.class)                        # create client-side channel
                        childHandler(channelInitializer)                                # 新接收的channel总执行本handler
                                                                                        ## 只有workerGroup时不用
                        option(ChannelOption.SO_BACKLOG, 128)                        # channel实现的参数
                        childOption(channelOption.SO_KEEPALIVE, true)                # option设置boss, childOption设置worker
                                                                                        ## 在只有workerGroup时不用childOption,因为它没有parent
                        bind(port)                                                        # 开始接收连接，返回的是ChannelFuture
                                                                                        ## 绑定网卡上的所有port端口，可以bind多次到不同的端口
        ChannelInitializer                        # 帮助设置channel, 如设置channel的pipeline中的handler
                实例
                        new　ChannelInitializer<SocketChannel>(){
                                @Override
                                public void initChannel(SocketChannel ch) throws Exception{
                                        ch.pipeline().addLast(new DiyHandler());
                                }
                        }
        ChannelFuture
                方法
                        sync()
                        channel()                                                        # 返回Channel
                        addListener(channelFutureListener)
        Channel
                        closeFuture()                                                        # 返回ChannelFuture
        ChannelFutureListener
                实例
                        new ChannelFutureListener(){
                                // 当请求结束时通知
                                @Override
                                public void operationComplete(ChannelFuture future){
                                        assert f == future;
                                        ctx.close();
                                }
                        }
    client
        Bootstrap                        # for non-server channels such as a client-side or connectionless channel
                connect(host, port)

# netty-tcnative
    介绍
            tomcat native 的分支
    特点
            简化本地库的分配和连接
            可以maven配置dependency
            提供openssl的支持
            
