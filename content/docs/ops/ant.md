---
Categories : ["运维"]
title: "Ant"
date: 2018-10-11T18:24:51+08:00
---

# 功能
    js压缩
    自动发布
# build.xml
    示例
    <?xml version="1.0" encoding="UTF-8"?>
    <project default="execute">
            <target name="compile">
                    <javac destdir="." srcdir="."/>
            </target>

            <target name="execute" depends="compile">
                    <java classpath="." classname="HelloWorld"/>
            </target>
    </project>
