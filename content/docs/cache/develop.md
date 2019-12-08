
# go
    go test -bench=.  --cpuprofile=cpu.prof --memprofile=mem.prof -config ../conf/config_lc.toml -test.run TestCreateType
    go test -cover -args -config config.toml -test.run "TestCreate"

    go tool pprof service.test cpu.prof

    go-torch -b cpu.prof

    go list -m -u all
        # 列可升级包
    go list -u need-upgrade-package
        # 升级可升级包
    go get -u
        # 升级所有依赖
# java
    java -jar xxx.jar
        java -jar a.jar  --spring.config.location=/application.yml 
            # 指定spring config
# hugo
    go install --tags extended