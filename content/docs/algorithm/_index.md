---
title: 算法
type: docs
---
# 名词
    graph        图
    TSP        traveling salesman problem        旅行商问题
    graph-coloring-problem        图填色问题
    combinatorial problems        组合问题
    geometric algorithm        几何问题
    closest-pair problem        最近对时间
    convex-hull problem        凸包问题
    numerical problem        数值问题
    lexicographic order        字典序
    on-line algorithm                联机算法
    ADT abstract data type        抽象数据类型
    activation record        活动记录
            # 递归栈所存的信息
    stack frame        栈桢
            # 同 activation record
    circular array        循环数组
    amoritzed        摊还
    biased deletion        偏删除
            # 二叉树删除节点引起平衡不足问题的删除
    symbol table        符号表
            # 编译器用
    tranposition table        变换表
            # 游戏用
    tick        滴答
            # 模拟的一份时间
    external sorting        外部排序
    comparison-based sorting        基于比较的排序
    transposition table
            # 置换表

# NP问题
    介绍
        polynomial problem(p问题), 可以在多项式时间内解决的问题
        non-deterministic polynomial problem(np, 非确定性多项式问题)，指可以在多项式时间内得到一个解的问题
        non-deterministic polynomial hard problem(np-hard, np-hard问题)很难找到多项式时间算法的问题
        non-deterministic polynomial complete problem(npc，np完全问题)很难找到多项式时间算法的np问题, 包含np-hard


# 排序
## 插入排序

## 冒泡排序

## 选择排序

## 希尔排序
    概念
            shellsort
            diminishing increment sort(缩减增量排序)
            increment sequence(增量序列)

## 桶排序
    介绍
            bucket sort
            将数据分到有限数量的桶子里，每个桶分别排序(可能再使用别的排序办法)
            当数据均匀分配时，时间复杂度是O(n), 不受O(nlogn)下限的影响
            适用于小范围、独立均匀分布的整数数据。可以计算数据量大，符合线性期望时间的排序
    步骤
            # 排序7, 36, 65, 56, 33, 60, 110, 42, 42, 94, 59, 22, 83, 84, 63, 77, 67, 101
            1. 设置5个桶, 找到最大值110, 最小值7, 每个桶范围是(110 - 7 + 1)/5 = 20.8
            2. 遍历原始数据，以链表结构分组放入桶中，公式为: 桶编号n = floor((a - 7) / 20.8)
            3. 桶第二次插入数据时，进行插入排序的一次插入
            4. 拼接5个桶

## 快速排序
    最坏时间复杂度为O(nlogn)

# hash
    介绍
        将任意长度二进制值映射到较短固定长度二进制值。改一个值会生成不同的哈希
        同一个哈希(散列)的二进制值是不存在的
        常见的有: md5, sha, sha1, sha256, sha512, RSA-SHA

# 加密
    签名
        公钥
            dsa
            ecdsa
            rsa
# 资源
    token bucket
        # 令牌桶
        通过多少流量，删除多少令牌
        突发流量
            丢弃
            排队
            特殊标记发送，网络过载时丢弃加标记的包
        过程
            产生令牌
            消耗令牌
            判断数据包是否通过
        作用
            限制平均传输速率，允许突发传输
    leaky bucket
        # 漏桶
        作用
            强行限制数据传输速率
    max-min fairness
        # 加权分配资源
        dominant resource fairness (DRF)
            # 一种 max-min fairness实现，可以多资源分配
