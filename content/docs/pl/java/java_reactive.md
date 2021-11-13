---
Categories : ["后端"]
title: "Java响应式编程"
date: 2018-10-11T10:33:48+08:00
---
# Java响应式层级
	Level 0: Thread & Runnable (Java 1+)
	Level 1: ExecutorService, Callable, Future (Java 5+)
	Level 2: ForkJoinPool (Java 7+)
	Level 3: CompletableFuture (Java 8+)
	Level 4: reactive streams, Flow (Java 9+)
	Level 5: HTTP/2 client (Java 11+)
	Level 6: Reactive libraries (RxJava, Reactor)
	Level 7: Reactive services (Vert.x, Spring, Kafka)
# Flow
	Flow.Publisher
	Flow.Subscriber
	Flow.Subscription
		# link publisher和subscriber
	Flow.Processor
		# subscriber和publisher的act
# ReactiveX
	Flux
	Mono
# RxJava
	模型	
		Observable
		Subscriber
# Reactor
# Vert.x
# AKKA