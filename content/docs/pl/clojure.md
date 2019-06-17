---
Categories: ["语言"]
title: "Clojure"
date: 2018-10-09T16:00:21+08:00
---

# 介绍
        是jvm上的一个lisp语言变种，比lisp更强调纯函数式编程
        操作符知道自己的特征值(identity value), 如+是0, *是1
        数组是懒惰的，需要时求值。适用于任意层的嵌套。头元素在使用后舍弃
        集合(vector, map, set)都是持久的，使用共享结构，与ruby, java中非持久结构有相似的性能
                # 持久的数据结构中，其它线程对数据的修改对该线程是不可见的
        没有尾递归优化，不常用递归，要用loop.recur
# 语法
        s-expressions
                (max 3 5)
                (+ 1 (* 2 3))
                (def meaning-of-life 42)
                (if (< meaning-of-life 0) "negative" "non-negative")
        (def droids ["Huey" "Dewey" "Louie"])
                (count droids)
                (droids 0)
        (def me {:name "Paul" :age 45 :sex :male})
                (:age me)
        (defn percentage [x p] (* x (/ p 100.0)))
                (percentage 200 10)
# 并发
    o-> 原子变量
            # 对一个值进行同步更新
    (def my-atom (atom 42))
    (deref my-atom)
    @my-atom
    (swap! my-atom inc)
    (swap! my-atom + 2)
    (reset! my-atom 0)

    (def session (atom {}))
    (swap! session assoc :username "paul")

    (if (compare-and-set! a old new)
            # 判断原子变量a的值是否是old, 是时赋成new并返回true
    new
    (recur))

    o-> conj 添加新成员
    (def players (atom ()))
    (defn list-players []
    (response (json/encode @players)))
    (defn create-player [player-name]
    (swap! players conj player-name)
    (status (response "") 201))
    (defroutes app-routes
    (GET "/players" [] (list-players))
    (PUT "/players/:player-name" [player-name] (create-player player-name)))
    (defn -main [& args]
    (run-jetty (site app-routes) {:port 3000}))

    o-> cons列表首添加元素
    (def listv2 (cons 4 listv1))

    o-> validator
            # 值改变之前调用
    (def non-negative (atom 0 :validator #(>= % 0)))
    (reset! non-negative -1)

    o-> 监视器
            # 值改变之后调用　
    (def a (atom 0))
    (add-watch a :print #(println "Changed from " %3 " to " %4))
    (swap! a + 2)
            # !的命名表示函数是事务不安全的

    o-> 代理
            # 对一个值进行异步更新。
            # 代理维护的数据与事务数据相同。代理具有事务性，send会在事务成功后生效
            # 方便做内存并发日志系统
    (def my-agent (agent 0))
    @my-agent
    (send my-agent inc)
            # send在值更新之前立即返回，不进行重试。多线程同时调用send, 调用被串行。具有副作用
            # send使用公用线程池，send-off使用一个新线程，send-via使用由参数指定的executor
    (send my-agent #((Thread/sleep 2000) (inc %)))
            # 设置延迟时间
    (await my-agent)
            # 等待代理执行完成后再继续。await-for函数可以设置超时时间

    (def non-negative (agent 1 :validator (fn [new-val] (>= new-val 0))))
            # 代理可以使用校验器和监视器
            # 校验器失败时抛出异常，代理进入失效状态
            # 错误处理模式默认为 :fail, 可以置为:continue
            # 可以设置错误处理函数
    (agent-error non-negative)
            # 查看代理是否在失效状态
    (restart-agent non-negative 0)
            # 重置失效状态

    o-> 引用
            # 只有在事务中才能修改引用的值，对多个值进行同步更新
    (def my-ref (ref 0))
    @my-ref

    (dosync (ref-set my-ref 42))
            # dosync创建一个事务，事务同swap!一样，用重试机制实现
            # clojure的事务有原子性，一致性，隔离性，没有持久性
    (dosync (alter my-ref inc))
            # commute替换alter，可以得到不很强的隔离性，用于做优化
    (defn transfer [from to amount]
    (dosync 
        (alter from - amount)
        (alter to + amount)))

    o-> threed
    (defn stress-thread [from to iterations amount]
    (Thread. #(dotimes [_ iterations] (transfer from to amount))))
    (let [t1 (stress-thread checking savings 100 100)
        t2 (stress-thread savings checking 200 100)]
    (.start t1)
    (.start t2)
    (.join t1)
    (.join t2))

    o-> ensure确保当前返回的值不被其它事务修改
    (when (and (= (ensure left) :thinking) (= (ensure right) :thinking))
    (ref-set philosopher :eating))
## csp
    介绍
            core.async提供了channel和go块
            引入的core.async中部分函数名与clojure核心库函数名冲突

    o-> channel
    (def c (chan))
    (thread (println "Read:" (<!! c) "from c"))
            # thread是core.async提供的辅助宏，将其中代码运行在一个单独的线程上
    (>!! c "Hello thread")
# 用例
    o->求和
    (defn recursive-sum 
    ""
            # 文档字符串
            ## (require '[philosophers.util :refer :all])
            ## (clojure.repl/doc swap-when!) 来查看文档字符串
    [numbers & args])
            # &表示可变参数
            ## (apply f old args) 将args展开，作为附加参数传递给f
    (if (empty? numbers)
        0
        (+ (first numbers) (recursive-sum (rest numbers))))

    (defn reduce-sum [numbers]
    (reduce (fn [acc x] (+ acc x)) 0 numbers))

    (defn sum [numbers]
    (reduce + numbers))

    o->并行
    (ns sum.core
    (:require [clojure.core.reducers :as r]))

    (defn parallel-sum [numbers]
    (r/fold + numbers))

    (def numbers (into [] (range 0 10000)))
    (time (sum numbers))
    (time (sum numbers))
            # 预热jim编译器
    (time (parallel-sum numbers))

    o-> map
    (def counts {"apple" 2 "orange" 1})
            (get counts "apple" 0)
            (get counts "banana" 0)
                    # 没有时返回设定的默认值0
            (assoc counts "banana" 1)
            (assoc counts "apple" 3)

    o-> frequencies
    (defn word-frequencies [words]
    (reduce
    (fn [counts word] (assoc counts word (inc (get counts word 0))))
    {} words))

    (frequencies ["one" "potato"])
            # 标准库中已提供

    o-> partial函数
            # 返回一个被局部代入的函数
    (def multiply-by-2 (partial * 2))
    (multiply-by-2 3)

    o-> 序列
    (defn get-words [text] (re-seq #"\w+" text))
    (get-words "one tow three four")
    (map get-words ["one two three" "four five six"])
    (mapcat get-words ["one two three" "four five six"])
            # 平辅数组

    o-> iterate
            # 不断将函数应用到初始值，第一次返回值，第二次返回值
    (take 10 (iterate inc 0))
    (take 10 (iterate (partial + 2) 0))
    (take-last 5 (range 0 10000))
            # 头元素使用后舍弃，耗相同的内存

    o-> pmap
    (pmap #(frequencies (get-words %)) pages)
            # pmap在需要结果时并行计算，仅生成需要的结果，称为半懒惰(semi-lazy)
            # #(...)是读取器宏，来快速创建匿名函数，参数通过%1, %2标识, 只有一个参数时可以是%
            ## (fn [page] (frequencies (get-words page)))与其等价

    o-> merge-with
            # 标准库函数
    (merge-with f & maps)
            # 将maps中其余map合并到第一个map中，返回合并后的map
            ## 同键名时，多个值从左向右地合并，调用传递的f(val-in-result val-in-latter)
    (def merge-counts (partial merge-with +))
    (merge-counts {:x 1 :y 2} {:y 1 :z 1})

    o-> partition-all
            # 序列分批
    (partition-all 4 [1 2 3 4 5 6 7 8 9 10])
            # ((1 2 3 4) (5 6 7 8) (9 10))

    o-> reducers包
            # 化简器，不代表函数的结果，代表如何产生结果的描述
            ## 嵌套的函数返回化简器，比返回懒惰序列效率更高
            ## 可以对整个嵌套链的集合操作，可以用fold进行并行化
            # clojure.core中大部分函数都有其对应的化简器版本
    (require '[clojure.core.reducers :as r]')
    (r/map (partial * 2) [1 2 3 4])
            # 返回一个化简器(reducible)
    (reduce conj [] reducible)
            # conj函数第一个参数为一个集合(初始值为[]), 将第二个参数合并到第一个参数中
    (into [] reducible)
            # into函数为内置函数，同上

    o->协议(类似java中的接口)来定义
    (defprotocol CollReduce
            # 化简
    (coll-reduce [coll f] [coll f init]))
            # coll相当于this, 支持多态性分派(polymorphic dispatch)
    (coll-reduce coll f)

    (defn my-reduce
    ([f coll] (coll-reduce coll f))
    ([f init coll] (coll-reduce coll f init)))
    (my-reduce + [1 2 3 4])
    (my-reduce + 10 [1 2 3 4])

    (defn make-reducer [reducible transforms]
    (reify
        CollReduce
        (coll-reduce [_ f1]
        (coll-reduce reducible (transformf f1) (f1)))
        (coll-reduce [_ f1 init]
        (coll-reduce reducible (transformf f1) init))))
            # 用reify实现一个协议
            # 调用reducible的coll-reduce方法。用transformf对f1进行转换，转换出的函数作为传给coll-reduce方法的一个参数
            # _表示未被使用的函数参数名，可以写成(coll-reduce [this f1])

    (defn my-map [mapf reducible]
    (make-reducer reducible
        (fn [reducef]
        (fn [acc v]
            (reducef acc (mapf v))))))
            # acc是之前化简结果, v是集合元素。mapf对v进行转换

    o-> fold折叠
            # 不能适用于懒惰序列
    (defprotocol CollFold
    (coll-fold [coll n combinef reducef]))

    (defn my-fold
    ([reducef coll]
        (my-fold reducef reducef coll))
    ([combinef reducef coll]
        (my-fold 512 combinef reducef coll))
    ([n combinef reducef coll]
        (coll-fold coll n combinef reducef)))

    (defn make-reducer [reducible transformf]
    (reify
        CollFold
        (coll-fold [_ n combinef reducef]
        (coll-fold reducible n combinef (transformf reducef)))

        (CollReduce
        (coll-reduce [_ f1]
            (coll-reduce reducible (transformf f1) (f1)))
        (coll-reduce [_ f1 init]
            (coll-reduce reducible (transformf f1) init))))

    (def numbers (into [] (take 10000000 (repeatedly #(rand-int 10)))))
    (require ['reducers.parallel-frequencies :refer :all'])
    (time (frequencies numbers))
    (time (parallel-frequencies numbers))

    o-> doall强迫懒惰序列对全部元素求值
    (reduce + (doall (map (partial * 2) (range 10000))))

    o-> future
            # 单独线程中执行一段代码
            # 典型场景是异步通信
    (def sum (future (+ 1 2 3 4 5)))
    sum
            # 返回一个future对象
    (deref sum)
    @sum
            # 运行
    (let [a (future (+ 1 2))
        b (future (+ 3 4))]
    (+ @a @b))
            # let给a赋值，阻塞当前线程直到被求值
            # 外层加法将一直阻塞，直到所有代表的值被求值

    o-> promise
            # 创建promise对象后，代码并不会像future一样立即执行，等待deliver赋值后执行
    (def meaning-of-life (promise))
    (future (println "The meaning of life is:" @meaning-of-life))
    (deliver meaning-of-life 42)

    o-> Compojure库的服务器
    (def snippets (repeatedly promise))
    (defn accept-snippet [n test]
    (deliver (nth snippets n) test))
    (future
    (doseq [snippet (map deref snippets)]
        (println snippet)))

    (defroutes app-routes
    (PUT "/snippet/:n" [n :as {:keys [body]}]
        (accept-snippet (edn/read-string n) (slurp body))
        (response "OK")))
    (defn -main [& args]
    (run-jetty (site app-routes) {:port 3000}))

    o-> re-seq正则
    (defn sentence-split [text]
    (map trim (re-seq #"[^\.!\?:;]+[\.!\?:;]*" text)))
            # trim是内置函数
    (defn is-sentence? [text]
    (re-matches #"^.*[\.!\?:;]$" text))

    o-> reductions
            # 同reduce, 返回中间值构成的序列
    (reductions + [1 2 3 4])
            # (1 3 6 10)

    o-> clj-http库
    (def translator "http://localhost:3001/translate")
    (defn translate [text]
    (future
        (:body (client/post translator {:body text}))))

    o-> delay在解引用前不求值
    (def translations
    (delay
        (map translate (strings->sentences (map deref snippets)))))

    o-> 系统时间
    (defn now []
    (System/currentTimeMillis))

    o-> Schejulure库
    (def session-sweeper
    (schedule {:min (range 0 60 5)} sweep-sessions))
            # 定期调用

    o-> Useful库
    (defn expired? [session]
    (< @(:last-referenced session) (session-expiry-time)))
    (defn sweep-sessions []
    (swap! sessions #(remove-vals % expired?)))
            # 删除元素

    o-> Loop/Recur
    (defn swap-when! [a pred f & args]
    (loop []
        (let [old @a]
        (if (pred old)
            (let [new (apply f old args)]
            (if (compare-and-set! a old new)
                new
                (recur)))
            nil))))
# 工具
    clojureScript
            # 编译到js