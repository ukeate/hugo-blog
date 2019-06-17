---
Categories : ["架构"]
title: "Protobuf"
date: 2018-10-11T15:21:36+08:00
---

# 命令
        protoc -I. -I-I$GOPATH/src  --go_out=plugins=grpc:. *
                        # -I import目录
        protoc --grpc-gateway_out=.
# 插件
    安装
            # go build 出protoc-gen-go后，放入go/bin下
    protoc-gen-go
            # 编译proto文件
    protoc-gen-grpc-gateway
            # http服务