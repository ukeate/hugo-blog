# 原理
    block k-d tree
    倒排索引
        词典
            排序数组
                # 为了二分查找
                # 实现简单，性能差
            哈希表
                # 性能好，占内存大
            跳跃表
                # 内存小且可调节, 模糊查询不好
            B/B+树
                # 磁盘索引 ，更新方便，检索慢
            trie树
                # 效率与字符串长度有关，只适合做英文词典
            dat
                # 可做中文词典，内存占用小
            fst
                # 共享前缀，内存占用小，要求输入有序，不易更新
                内存存前缀索引、磁盘存后缀词块
        倒排表
        正向文件
            # 行式存储，原始文档
        doc-values
            # 列式存储，文档号到值的映射
    文件指纹

# 概念
    index
        # 一个倒排表，对应一个目录
    segment
        # index的存储单元，包含多个文档
    document
        # 创建单位
    field
        # 文档里的键值对
    term
        # 分词后的字符串
    analyzer
        tokenizer
            # 切分文本到索引单元
        tokenfilter
            # 对token预处理
# 常识
    特性
        索引
        高亮
        命中率排序
        分词
    与数据库的区别：数据库注重存储、全文检索注重查询
    其它搜索：多媒体搜索
    索引库(文件夹 或 内存中)：
        只存储了商品的基本信息
         索引库与数据库定时同步
        索引库 -> document -> field                # field是键值对,值只能存数据
                同步
        IndexWriter:addDocumnet(),delteDocument(),updateDocument()
                查询
                        IndexSearch:search(),get()
        Field的内部结构
                    # 不存不索引会报错
        Store:控制此Field字段是否存储到索引库中
        Index:是否建立索引（索引不区分大小写,过滤词不创建索引）
            NO:不建立索引，可以通过field的key查到，但是不能通过关键字查询到
            NOT_ANALYZED:建立索引，但是不分词
            ANALYZEd:建立索引又分词
# 使用到的对象
    Directory
    Analyzer
        TokenStream tokenStream = analyzer.tokenStream("eldName",new StringReader("测试字符串"))
        while(tokenStream.incrementToken()){
                TermAttribute termAttribute = tokenStream.getAttribute(TermAttribute.class);
                System.out.println(termAttribute.term());
        }                # 使用分词器测试分词
    Document
        add(Field)
        document = indexSearcher.doc(ScoreDoc)
        get(String)                # 通过key查找value
    IndexWriter
        IndexWriter(directory,analyzer,MaxFieldLength.LIMITED);       # LIMITED限定Field的数量(源码中规定默认值)
        addDocument(Document)
        commit()
        close()                        # 自带commit()
        rollback()
    IndexSearcher
    QueryParser
        QueryParser(Version.LUCENE_30,"name",analyzer)
    Query
        query = parser.parse(用户传递的字符串);
        query = parser.parseMultiField(String [], 用户传递的字符串);
    TopDocs
        topDocs = indexSearcher.search(query, 10);                # 10是期望的结果数
                                                                                                        ## 最终查询到的结果数是：期望结果数与实际结果数的最小值
        totalHits                # 命中的结果数
    ScoreDoc
        ScoreDoc [] scoreDocs = topDocs.scoreDocs;
        scoreDoc.score                # 命中率积分
        scoreDoc.doc                # 命中文档编号，该编号由lucene自动生成
    Term                # 索引项
        Term("field中的key","field中value解析出的关键字")
# 索引的结构
    Term("key","value")[0,3,4]                        # key 为对应的field中的"key",value对应的是解析field的"value"出的关键字
                                                                                ## []中的内容为匹配的文档编号，该编号为系统自动生成的
# 注意
    lucene创建索引时field的key都可以重复，没有主键方面的限制。但是实际应用时要求我们为document有唯一的标识“主键”field,便于对每个document进行更新与删除
# 使用
    包：IKAnalyzer,lucence-analyzer(英文分词，不需要),memory,core,highlighter
    工具：lukeAll 用来查看索引库
    添加、查询、删除、修改
    抽取配置类（构造方法私有化）
        Configuration
            维护了directory与analyzer
        DocumentUtil
            goodsToDocument(Goods)
            documentToGoods(Document)
        LuceneUtil
            维护了indexWriter与indexSearcher
            注意
                    1.indexWriter在static代码块中初始化
                    2.getIndexWriter
        LuceneService
            用indexWriter与indexSearcher处理业务逻辑
            添加
                indexWriter.addDocument(Document)
                indexWriter.rollback()
            删除
                indexWriter.deleteDocument(Term)
                indexWriter.optimize()                # 删除document的时候同步索引库，没有设置的话只是删除document，但是索引中还是可以查到
            更新
                indexWriter.updateDocument(Term,Document)
                indexWriter.optimize()                # 更新是先删除再添加（所以如果updateDocument(Term,Document)中匹配多个Document时，会出现删除了多个Document,而添加了一个Document的情况）
            查询
                QueryParser parser = new QueryParser(Version.LUCENE_30, "field中的key", analyzer);
                Query query = IKQueryParser.parseMultiField(new String[]{"name","remark"}, "ee");                # 多字段查询，IKAnalyzer特有
                    #　多字段查询到的第二个字段的结果，在转换高管时（调用getBestFragment时）只会对该方法指定的一个字段进行匹配，如果该字段不匹配时（但是第二个字段匹配），则会返回空。
                    ## 针对这一个bug,在getBestFragment处理匹配的结果返回空时，不使用空而直接返回没有高亮的字符串即可。
                parser.parse(用户传递的字符串);
                TopDocs topDocs = indexSearcher.search(query, 3);        # 3是期望结果数
                ScoreDoc [] scoreDocs = topDocs.scoreDocs;
                Document document = indexSearcher.doc(scoreDoc.doc);                scoreDoc.doc得到文档编号
                分页查询：
                    传递当前页码与一页记录数
                    利用topDocs.totalHits得到总记录数
                    查询本页与前面所有页的期望数据量，然后只截取本页的文档编号，得到document并返回数据

# 分词器
    IKAnalyzer
        配置文件
            src/IKAnalyzer.cfg.xml中配置
                <properties>
                    <entry key="ext_dict">/mydict.dic</entry>                 # 配置自己的字典（不分词）
                    <entry key="ext_stopwords">/ext_stopword.dic</entry>                 # 配置跳过的字
                </properties>
        Query query = IKQueryParser.parse("name",name);                # IKAnalyzer特有
# 排序
    Directory directory = FSDirectory.open(new File("d:/lucene"));
    IndexSearcher indexSearcher = new IndexSearcher(directory);
    Query query = IKQueryParser.parse("name","cc");
    Sort sort = new Sort(new SortField("id", SortField.INT,true));                # 这里可以排序多个字段
        # 参数1："id"是排序的field字段,参数2：是字段内容的类型,参数3 true代表降序排列
        ## 此时命中率不再计算（因为不按命中率排序）
        ## 排序的field必须建立索引
    indexSearcher.search(query, null,10,sort);
高亮
    导入包:highlight与memory
    Highlighter highlighter = new Highlighter(new SimpleHTMLFormatter("<font color='red'","</font>"),new QueryScorer(query));
    highlighter.setTextFragmenter(new SimpleFragmenter(10));                # 限制字符长度
    ..
    String result = highlighter.getBastFragment(analyzer,"name",doc.get("name"));
        # 返回高亮处理字符串
        ## 参数1：解析用户输入词的分词器,参数2：是要查询的field的key(没有用)，参数3：field的value
