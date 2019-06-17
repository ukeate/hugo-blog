---
Categories: ["语言"]
title: "Elixir"
date: 2018-10-09T16:24:04+08:00
---

# 介绍
        跑在erlang虚拟机上
        与erlang相同，actor称作进程, 是比线程更轻量的概念
# 使用
    o-> 元组
    {:foo, "this", 42}
            # 三元组

    o-> actor
    defmodule Talker do
    def loop do
        receive do
        {:greet, name, age} -> IO.puts("Hello #{name}")
        {:shutdown} -> exit(:normal)
        end
        loop
    end
    end

    pid = spawn(&Talker.loop/0)
    send(pid, {:greet, "Huey", 16})
    sleep(1000)

    Process.flag(:trap_exit, true)
    pid = spawn_link(&Takler.loop/0)
    send(pid, {:shutdown})
    receive do
    {:EXIT, ^pid, reason} -> IO.puts("Talker has exited (#{reason})")
    end

    o-> 有状态的actor
            # 递归
    defmodule Counter do
    def start(count) do
        spawn(__MODULE__, :loop, [count])
                # 伪变量__MODULE__, 是当前模块的名字
    end
    def next(counter) do
        send(counter, {:next})
    end
    def loop(count) do
        receive do
        {:next} ->
            IO.puts("Current count: #{count}")
            loop(count + 1)
        end
    end
    end
    counter = spawn(Counter, :loop, [1])
    send(counter, {:next})

    counter = Countre.start(42)
    Counter.next(counter)