---
Categories : ["架构"]
title: "Rabbitmq"
date: 2018-10-11T16:30:07+08:00
---

# install
        yum install rabbitmq-server
# 命令
        添加用户:
                rabbitmqctl add_user rainbird password
        添加权限:
                rabbitmqctl set_permissions -p "/" rainbird ".*" ".*" ".*"
        删除测试用户:
                rabbitmqctl delete_user guest
# 原理
    虚拟主机 virtual host: 用户通过虚拟主机进行权限控制(如禁止A组访问B组的交换机)
            ＃ 默认虚拟主机为"/"
            队列 queue: 由生产者(producers)通过程序建立，再通过消费者(consuming)连接取走
                    消息:
                            路由键 routing key
            交换机 exchange: 负责把消息放入队列
                    绑定 binding(路由规则): 如指明交换机中具有路由键"X"的消息要到名为"Y"的队列中去
                            # 如果同一个键对应多个队列，则复制后分别发送

    功能
            持久化
                    队列和交换机创建时指定标志durable,指定队列和交换机重启生重建
                            ＃ 如果绑定了durable的队列和durable的交换机，该绑定自动保留
                            ＃ non-durable的交换机与durable的队列不能绑定
                            ＃ 一但创建durable标志，不能修改
                    消息发布到交换机时，指定标志Delivery Mode=2,这样消息会持久化
# 使用(原文http://adamlu.net/rabbitmq/tutorial-one-python)
        安装python 与插件支持
                pip
                python-pip git
                python-pika
        rabbitmq-server start
        send.py
            #!/usr/bin/env python
            import pika

            connection = pika.BlockingConnection(pika.ConnectionParameters(
                    host='localhost'))
            channel = connection.channel()

            channel.queue_declare(queue='hello')

            channel.basic_publish(exchange='',
                                routing_key='hello',
                                body='Hello World!')
            print " [x] Sent 'Hello World!'"
            connection.close()
                    receive.py
                            #!/usr/bin/env python
            import pika

            connection = pika.BlockingConnection(pika.ConnectionParameters(
                    host='localhost'))
            channel = connection.channel()

            channel.queue_declare(queue='hello')

            print ' [*] Waiting for messages. To exit press CTRL+C'

            def callback(ch, method, properties, body):
                print " [x] Received %r" % (body,)

            channel.basic_consume(callback,
                                queue='hello',
                                no_ack=True)

            channel.start_consuming()


