---
Categories : ["算法"]
title: "数据结构"
date: 2018-10-07T13:46:46+08:00
---

# 树

    概念
        tree
        free tree(自由树)，连通无回路的图
        full tree(满树)，所有节点要么是树叶，要么是两个儿子
        forest(森林)，无回路但不一定连通的图
        root
        rooted tree(有根树)，确定根的树，常简称为树
        node
        ancestor(祖先)，顶点本身也作为自己的祖先
                proper ancestor(真祖先)，除了自己的祖先
        parent(父母)
        child(子女)
        sibling(兄弟)
        leaf(叶节点), 没有子女的顶点
        parental(父节点)，至少有一个子女的顶点
        descendant(子孙)，以v为祖先的所有节点，包含v
                proper descendant(真子孙)，不包含本身
        subtree(子树) 

        depth(深度)，从根到v简单路径的长度
                height depth 树中结点的最大级数
        rank(秩)
                # 子女数
        height(高度)，从根到叶节点最长简单路径的长度
                # 按树的层的数量定义时，高度增加1
        degree(度，一个节点子树的数目) 
        level(root为1级, 结点为p级时，儿子在p+1级)

        state-space tree(状态空间树)，可用于分析回溯和分支界限
        ordered tree(有序树)，有根树的每个顶点，所有子女有序
                first child-next sibling representation(先子女后兄弟表示法)
                        # 子女数不定，父节点只存第一个子女，该子女存兄弟链表
                        ## 以一种高效方式将有序树改造成关联二叉树
                        ## 关联二叉树中，左指针表示下层，右指针表示兄弟节点
        binary tree(二叉树)，属于有序树
                left child(左子女)
                right child(右子女)
                左(右)子树
                        # 二叉树可以递归定义，所有可以用递归算法
                binary search tree(二叉查找树)，父母顶点比左子树中所有数字大，右子树中小
                        效率，多取决于高度
                                logn <= h <= n - 1
                                        # h 为高度, n为顶点数
        multiway search tree(多路查找树)
                B树, B+树, B-树
    边
            树向边
            回边
            前向边
                    # 顶点到非子孙
            交叉边
                    # 非前三都是交叉边
    性质
            |E| = |V| - 1
                    # 树的边数总比顶点数小1
                    # 图变树的必要不充分条件，连通图变树的必要充分条件
            任意两个顶点间总存在简单路径，任选顶点可作根
            
## 二叉树
    介绍
        binary tree
        常用顺序表或链表存储
    概念
        full binary tree(满二叉树)
                # 满子节点，且子节点在同一层上
        heap(堆)
                # 根向下从大到小排序
        binary search tree(二分检索树)
                # 左子节点小于父节点小于右子节点
        left child(左子女)
        right child(右子女)
        左(右)子树
                # 二叉树可以递归定义，所有可以用递归算法

        complete binary tree(完全二叉树)
                # 只有最大层节点不满且连续集中在左边
                高是logN
                可以用数组实现(从index = 1开始存储)
                        左儿子在2i, 右儿子在2i + 1, 父亲在i / 2
        perfect binary tree(理想二叉树)
                # 满节点二叉树
        full binary tree(满二叉树)
                # 同理想二叉树
        skewed tree(斜树)        
                # 一个节点不断左斜是左斜树，相反为右斜树
        binary search tree(二叉查找树)
                # 父母顶点比左子树中所有数字大，右子树中小
        AVL tree(Adelson-Velskii-Landis tree)
                # 带有平衡条件(balance condition)的二叉查找树
                平衡条件: 左右子树最多差1
                        # 节点中存储高度信息
        splay tree(伸展树)
                # 分析树的一种

    效率，多取决于高度
        logn <= h <= n - 1
                # h 为高度, n为顶点数
    树转换二叉树
## 堆
    概念
        binary heap(二叉堆、堆)
                # 一棵完全二叉树
                结构性
                heap-order property(堆序性)
                heap-order tree(堆序树)
                已证明，平均一次插入需要2.607次比较，所以上移1.607层
        d-堆
                # 二叉堆是2-堆
                deleteMin为时间为O(dlog(d)(N))
                实践中
                        插入次数比deleteMin次数多(可加速)
                        主存不够时如B树使用
                        4-堆胜过二叉堆
        leftist heap(左式堆)
                不是理想平衡(perfectly balanced)的，实际趋向于不平衡
                具有堆序性
                npl(X) null path length 零路径长
                        # X到一个不具有两个儿子节点的最短路径。到本身npl(X) = 0。npl(null) = -1
                o(N)时间处理一个merge
                定义
                        堆中每个节点，左儿子的npl >= 右儿子的npl
                操作
                        merge
                        insert
                        deleteMin
                性质
                        左儿子npl >= 右儿子npl
        skew heap(斜堆)
                有堆序性
                定义
                        不维护npl
                        每次合并都交换左右(只有左儿子的除外)
                        其它同左式堆
                性质
                        任意M次连续操作, 总的最坏情况运行时间为O(MlogN), 每次摊开销为O(logN)
                操作
                        merge
                        insert
                        deleteMin
        binomial queue(二项树)
                B(k) 由B(0), B(1), ... B(k - 1)连接根组成
                有2^k个节点, k为高度
        pairing heap(配对堆)
        fibonacci heap(斐波那契堆)
    算法
        heapsort(堆排序)
        merge(合并)
# 线性
    列表(list)
        数组(array)
                # 相同数据类型元素的序列，下标(index)访问
                low high
                字符串
                        二进制串(binary string)
                                # 位串(bit string)
        链表(linked list)
                节点(node)        
                        指针(pointer)
                表头(header)
                单链表(singly linked list)
                双链表(doubly linked list)
        栈(stack)
                # 插入和删除只能在端部进行的列表，应用于递归
                栈顶(top)
                LIFO last-in-first-out
        队列(queue)
                队头(front)
                队尾(rear)
                入队(enqueue)
                FIFO first-in-first-out
                优先队列(priority queue)
                        # 数据项多来自于全序域(常整数或实数)
                        查找最大元素，删除最大元素，插入新元素
                        堆(heap)实现
## 散列表
    介绍
            有序输入时，树效率低，如果不要求查找有序结果，可以用散列
    概念
            hash table
            hashing(散列)
            item(项)
            key(关键字)
                    # 项中某部分
            hash function(散列函数)
                    # 映射函数
            collsion(冲突)                
                    # 多个关键字散列到同项的状况
            load factor(装填因子)
                    # λ 元素个数对表长度的比，
                    # 如果散列是均匀的，表示了一个项中关键字的平均长度
                    # 一次成功查找要遍历约1 + (λ / 2)个链，1表示被匹配的项
            rehashing(再散列)
                    一半时进行
                    直到插入失败再进行
                    middle-of-the-road
                            # 到达某load factor时进行
            caching the hash code(闪存散列代码)
        
    算法
            separate chaining(分离链接法)
                    # 解决冲突 
            probing hash table(探测散列表)
                    线性探测法
                            primary clustering(聚集)
                                    # 线性探测法中形成数据区块
                    平方探测法
                            secondary clustering(二次聚集)
                                    # 模拟结果指出，对每次查找，会引起另外的少于一半的探测
                    double hashing(双散列)
                                    # 模拟表明, 两个散列都mod质数时，探测次数几乎和随机冲突解决方法相同
            extendible hashing(可扩散列)
                    D directory(目录)
                            # 一个分区中bit的个数，所以M最多2^D
                    性质
                            # 基于位模式(bit patterm)是均匀分布的事实, 是"分支系数(branch factor)", N 是记录总数(随时间变化)
                            树叶期望个数为(N/M)log(2)(e)
                                    所以平均树叶满的程度为ln2 = 0.69, 同B树
                            目录期望大小为O(N^(1 + 1 / M) / M)
                    叶子可以指向实际记录的链表(内存装不下太大目录时)，这样得到实际数据就需要第二次磁盘访问
## 队列
    介绍
        queue 先进先出
    概念
        enqueue(入队)
        dequeue(出队)
        priority queue(优先队列)
                insert
                deleteMin
        binomial queue(二项队列)
                merge, insert, deleteMin 最坏时间为O(logN), 插入花费常数时间
                堆序树(二项树)的森林实现
                B0 = 2^0, B1 = 2^1, B2 = 2^2 ...
                Bn = B0 + B1 + ... B(n-1)
# 集合
    概念
            set(集合)，互不相同项的无序组合(可空)
            element(元素)
            dictionary(字典)，能够查找，增加，删除元素的集合
                    # 实现时要达到效率的平衡
            set union problem(集合合并问题)
                    # 动态地把n个元素集合划分为一系列不相交的子集
            ADT abstract data type(抽象数据类型)
                    # 由表示数据项的抽象对象集合和一系列对它的操作构成
    实现
            universal set(通用集合)
                    通用集合的子集，用长度为n(通用集合的长度)的位向量(bit vector)表示
                            # 占用大量存储空间
            线性列表
                    # 去除包含的重复元素
                    # 列表是有序的，但这差别并不重要
                    多重集(multiset)、包(bag)
                            # 可重复项的无序组合
                
    表示
            S = {2, 3, 5, 7}
            S = {n: n 为小于0的质数}
# 图

    概念
            graph
            vertices(结点)
            edge(边)
                    # 是结点对偶的集合
            endpoint(端点)
                    # 边(u, v)的端点u, v
            incident(关联)
                    # u, v和边(u, v)关联
            尾(tail)头(head)
                    # 边(u, v)离开u进入v, u是尾, v是头
            loop(环)
                    # 连接顶点自身的边，只考虑不含圈的图
            cycle(圈)
                    # 长至少1的路径
            acycle(无圈的)
            DAG(无圈图)
            adjacent(邻接)
                    # (i, j)则i, j邻接

            directed(图是有向的)
                    # 对偶<i, j>与对偶<j, i>不同
            digraph(有向图)
            undirected(无向的)
                    # 边表示为(i, j)

            network(网络)
                    # 边上有成本的图
            weighted graph(加权图)
                    # weighted digraph(加权有向图)相同
                    weight(权重)
                    cost(成本)

            度
                    # 点的邻接点的数目
            出度
                    # 有向图中，用该点作为第一个成分的边数目
            path(路)
                    # 结点序列
                    cycle(环、回路)
                            # 首尾相同的简单路
                    acyclicity(无环性)

                    connected(连通的)
                            # 每一对结点间存在一条路
                    connectivity(连通性)
                    connected component(连通分量)
                            # 非连通图中包含的连通部分
                    underlying graph(基础图)
                            # 有向图去掉方向
                    strongly connected(强连通的)
                            # 有向图中, 一对结点都存在互相连通的路，则两点强连能
                    weakly connected(弱连通的)
                            # 有向图的基础图是连通的
                    strongly connected graph(强连通图)
                            # 所有结点对强连通
                    strongly connected components(强连通分量)
                            # 极大强连通子图
            length(路的长度)
                    # 路的边数
            simple path(简单路)
                    # 除首尾结点外，所有结点不同的路
            directed path(有向路经)

            complete(完全的)
                    # 任意两个顶点之间都有边相连，表示为K|V|
            dense(稠密)
                    # 缺少边较少
            connected(连通的)
            biconnected(双连通的) 
                    # 不存在割点(articulation point)

    表示
            V = {a, b, c, d, e, f}, E = {(a, c), (a, d), (b, c), (b, f), (c, e), (d, e), (e, f)}
            |E|
                    # 边的数量
            |V|
                    # 顶点的数量
            adjacency matrix(邻接矩阵)
                    # 图的顺序表示法
                    无向图的邻接矩阵总是对称的
                    稠密图，邻接矩阵占空间小
                    weight matrix(权重矩阵)、cost matrix(成本矩阵)
            adjacency list(邻接表)
                    # 图的链接表示法
                    稀疏图，邻接表占空间小
    公式
            0 <= |E| <= |V|(|V| - 1) / 2
                    # 无圈无向图，可能包含边的数量
    算法
            critical path analysis(关键路径分析法)
    应用
            activity-node graph(动作节点图)
            event-node graph(事件节点图)
                    slack time(松弛时间)
                    critical path(关键路径)