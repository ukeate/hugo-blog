# 介绍
    分布式实时lucene
# 使用
    ./bin/elasticsearch
    curl http://localhost:9200
# 命令
    elasticsearch -Ecluster.name=my_cluster_name -Enode.name=my_node_name
# 概念存储
    index
        type
            # document中加_type field实现
            # 所以不同type中的field在index要唯一，否则冲突
            # 对field排序会载入所有type的document
            document
                # 对应lucene中的key value倒排文档
                # 对就一个请求的json对象
                field
                    mapping
                        # 定义type的field，映射json到document field
# 设置
    config/elasticsearch.yml
        action.auto_create_index: -l*, +z*
            # 自动创建，以z开头和非l开头的索引
        action.destructive_requires_name: true
            # 允许通配删index
        http.cors.enables: true
        http.cors.allow-origin: "*"
        cluster.name: c1
        node.name: n1
        node.master: true
        node.data: true
        transport.host: localhost
        transport.tcp.port: 9300
        network.host: 0.0.0.0
            # 修改es监听地址，别的机器也可以访问。同时设置bind_host和publish_host
            # 需要设置transport.host:localhost
        network.bind_host
            # 节点绑定ip
        network.publish_host
            # 发布地址，其它节点通过这个地址通信
        http.port: 9200
        transport.tcp.port
            # 通信端口，默认9300
        discovery.zen.minimum_master_nodes: 2

    o-> 可用配置
    cluster.name: myES_Cluster
    node.name: ESNODE_CYR
    node.master: true
    node.data: true
    transport.host: localhost
    transport.tcp.port: 9300
    http.port: 9200
    network.host: 0.0.0.0
    discovery.zen.minimum_master_nodes: 2
# 接口
    索引
        put /index1
            # 创建index
            # get查询，delete删除
            settings
            mappings
            aliases:
        put /index1/_mapping/type2
        put /index1/type2/_mapping
            # 创建type或给已有type加mappings
            # get得到mapping信息
            properties
        put /index1/_settings
        put /index1/type1/1
            # 插入doc
            # get得到doc
            name: "name1"
    _cat
        get /_cat/health?v
            # 集群健康
        get /_cat/nodes?v
            # 集群节点
        get /_cat/indices?v
            # 所有索引
    _aliases
        post /_aliases
            # 索引别名
            actions:
                add:
                    alias: "my_index"
                    index: "my_index_v1"
                remove
    _template
        put /_template/tpl1
            template: "te*"
                # 匹配所有re开头的index
            settings:
            mappings:
    _search
        post /index1/type1/_search
            # from size实时分页
            # scroll快照分页
            ?from=0&size=50
            ?scroll=1m&size=50
                # 过期时间1分钟，每次返回50条
            ?search_type=scan&scroll=1m
                # scroll-scan分页不排序，更快,
    _analyze
        post /index1/_analyze
            text: "刘德华"
            analyzer: "analyzer1"
    _close
        post /index1/_close
            # 关闭索引，此后可以改settings
    _open
        post /index1/_open
    _cache
        post /index1/type1/_cache/clear?filter_keys=k1
            # 清空query filter的缓存
    数据对象
    _search
        query
            match
                # 理解如何分词的, 会对field分词再查询
                field1:
                    query: "a b"
                    operator: "and"
                    minimum_should_match: "75%"
                        # 匹配的query分词的最低占比
            match_all
                # 默认，会查出所有文档
            multi_match
                query: "a b"
                fields: ["field1", "field2"]
            match_phrase
                # 所有term命中，并且位置邻接
                field1: "a b"
            term
                # 确切查询
                field1: "value1"
            terms
                # 多条件and
                field1: [1,2,3]
            range
                field1:
                    gt: 20
                    gte:
                    lt:
                    lte:
            exists:
                field: "field1"
            missing:
                field: "field1"
            regexp
                postcode: "W[0-9].+"
            wildcard
                postcode: "W?F*HW"
            prefix
                # 以某些字符开头
                field1: "a"
            bool
                # 分值计算来自must和should语句, must_not不影响
                must
                    match
                must_not
                should: []
                minimum_should_match: 2
            filtered
                query
                filter:
                    # filter的field会缓存起来
                    ## geo, and, or, not, script, numeric_range的默认不缓存
                    term:
                        field1: "a"
                        _cache_key: "k1"
                        _cache: false
                    range:
                        field1:
                            gte: 0
        aggs
            diy1:
                avg:
                    field: "field1"
            diy2:
                terms:
                    # 聚合查询中的所有term
                    field: "field1"
        post_filter:
            # 对搜索结果进行过滤
            term:
                field1: "a"
        sort: []
            # 默认升序，_score默认降序
            field1
                order: "desc"
                    # asc
                mode: "min"
                    # 对数组元素排序时的取值, 还有max, sum, avg, median
                missing: "field1"
            "_score",
        highlight
            pre_tags: ["<tag1>"]
            post_tags: ["</tag1>"]
            fields:
                content: {}
        simple_query_string:
            query: ""
            analyzer:
            fields: ["body^5", "_all"]
            default_operator: "and"
    mappings:
        type1:
            dynamic: true
                # 默认true,自动给未知field建索引
                # false: 忽略未知field， strict: 未知field报错
            include_in_all: false
                # 默认不include
            _all:
                # meta field
                enabled: false
                        # 关闭all作用域
                analyzer:
                        # 其实是search_analyzer
                term_vector: no
                        # 对field建立词频向量空间
                store: "false"
            _source:
                #  是否保存内容
                enabled: true
            properties:
                field1:
                    type: “text”
                        # text分词，keyword不分词，numeric, date, string
                        # multi_field可定义多个field
                    fields:[]
                        field1:
                            type
                    store: "yes"
                    index: "not_analyzed"
                        # analyzed
                    analyzer: "ik_max_word"
                    search_analyzer: "ik_max_word"
                        # 默认为analyzer
                    include_in_all: "true"
                        # 是否加入_all作用域
                    boost: 8
    aliases:
        alias1:
            filter:
                term: user: "kimchy"
            routing: "kimchy"
    settings:
        # 有些设置不能动态修改
        index:
            number_of_shards: 3
            number_of_replicas: 2
            max_result_window: 10000
                # from + size的上限，默认10000
            analysis:
                tokenizer:
                    # 处理原始输入
                    tokenizer1
                        type: "pinyin"
                        pinyin_field1:
                filter:
                    # tokenizer作为输入
                    filter1:
                        type: "pinyin"
                        pinyin_field1:
                analyzer:
                    # 组合tokenizer和filter
                    analyzer1:
                        type: "custom"
                        tokenizer: "ik_smart"
                        filter: ["filter1", "word_delimiter"]
# 插件
    使用
        复制到/plugins
        场景中，指定type:"xx"使用
    ## ik
        介绍
            elasticsearch-analysis-ik
        安装
            mvn package
            unzip -d /elasticsearch/plugins/ik ./target/releases/elasticsearch-analysis-ik-1.8.0.zip
            重启elasticsearch
        分词器
            ik_max_word
                curl -XGET 'http://localhost:9200/_analyze?pretty&analyzer=ik_max_word' -d '联想是全球最大的笔记本厂商'
            ik_smart
                curl -XGET 'http://localhost:9200/_analyze?pretty&analyzer=ik_smart' -d '联想是全球最大的笔记本厂商'
        mapping type
            {
            "properties": {
                "content": {
                "type": "text",
                "store": "no",
                "term_vector": "with_positions_offsets",
                "analyzer": "ik_smart",
                "search_analyzer": "ik_smart",
                "include_in_all": "true",
                "boost": 8
                }
            }
            }
    ## pinyin
        介绍
            elasticsearch-analysis-pinyin


        o->
        "analysis" : {
            "analyzer" : {
                "pinyin_analyzer" : {
                    "tokenizer" : "my_pinyin",
                    "filter" : "word_delimiter"
                }
            },
            "tokenizer" : {
                "my_pinyin" : {
                    # 单字
                    "type" : "pinyin",
                    "first_letter" : "none",
                    "padding_char" : " "
                },
                "my_pinyin_fisrt_letter" : {
                    # 首字母, 如北京为bj
                    "type" : "pinyin",
                    "first_letter" : true,
                    "padding_char" : " "
                },
            }
        }
        o-> pinyin
        "analysis" : {
            "tokenizer" : {
                "my_pinyin" : {
                    "type" : "pinyin",
                    "keep_separate_first_letter" : false,
                    "keep_full_pinyin" : true,
                    "keep_original" : true,
                    "limit_first_letter_length" : 16,
                    "lowercase" : true,
                    "remove_duplicated_term" : true
                }
            },
            "analyzer" : {
                "pinyin_analyzer" : {
                    "tokenizer" : "my_pinyin"
                }
            }
        }
        "properties": {
            "name": {
                "type": "keyword",
                "fields": {
                    "pinyin": {
                        "type": "text",
                        "store": "no",
                        "term_vector": "with_offsets",
                        "analyzer": "pinyin_analyzer",
                        "boost": 10
                    }
                }
            }
        }

        o-> ik-pinyin
        "analysis": {
            "filter": {
                "pinyin1": {
                    "type": "pinyin"
                }
            },
            "analyzer": {
                "ik_pinyin_analyzer": {
                    "filter": ["pinyin1","word_delimiter"],
                    "type": "custom",
                    "tokenizer": "ik_smart"
                }
            }
        },
工具
    kopf
    bigdesk
    head
        使用
            https://github.com/mobz/elasticsearch-head
            cnpm i
            npm i -g grunt-cli
            grunt server
            curl localhost:9100
        配置
            Gruntfile.js
                port:9100
client
    olivere/elastic
        Search
            # SearchService
            Do
            Index
            Query
            Sort
            From
            Pretty
        Index
            # IndexService
            Do
            Index
            Type
            Id
            BodyJson
            Refresh
        Suggest
            # SuggestService
        query
            SimpleQueryString


