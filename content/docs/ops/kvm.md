---
Categories: ["运维"]
title: "Kvm"
date: 2018-10-11T18:17:40+08:00
---

# 介绍
    kernel-based virtual machine, 使用linux自身的调度器进行管理,所以代码较少
            # 又叫qemu-system或qemu-kvm
    虚拟化需要硬件支持(如 intel VT技术或AMD V技术)，是基于硬件的完全虚拟化
# 原理
    包含一个可加载的内核模块kvm.ko, 由于集成在linux内核中，比其他虚拟机软件高效
# 使用
    检查系统是否支持硬件虚拟化
            egrep '(vmx|svm)' --color=always /proc/cpuinfo

