---
Categories: ["语言"]
title: "Haskell"
date: 2018-10-09T16:54:16+08:00
---

# 介绍
    源于ML
    标准化的、纯函数式编程语言
    非限定性语义和强静态类型
    作为其他语言设计新功能时的样板，如Python的lambda标记语句
# 工具
    检索函数用http://www.Haskell.org/hoogle

# 单词
    polymorphism
        # 多态
    monomorphic
        # 单态
# 风格
    point free style
        sum' xs = foldl (+) 0 xs
        sum' = foldl (+) 0

# 注意
    使用缩进代替括号，但也可用括号

# 文件扩展名
    # 文件中不用let定义变量, 
    # 变量赋值两次会报错, 这意味着代码顺序不重要
    hs

# 内置变量
    pi

# 模块
    :m Data.Char Data.Map
        # 加载模块
        chr
            # chr :: Int -> Char
        ord
            # ord :: Char -> Int
        toUpper
        toLower
    import Data.Char
        # 导入到全局命名空间
        import Data.List (nub, sort)
        import Data.List hiding (nub)
        import qualified Data.Map as M
            # 这样其中命名冲突的filter, null函数，只能用Data.Map.filter或M.filter方式调用
    可用模块
        prelude
            # 默认载入的模块
        Data
            Char
            List
            Map
            Set
    自定义模块
    module Geometry.Sphere
    (sphereVolume
    , sphereArea
    , Shape(..)
        # 导出类型和其所有构造子
    ) where
    sphereVolum :: Float -> Float
    sphereVolum radius = (4.0 / 3.0) * pi * (radius ^ 3)
# 命令函数
    :load
        # 加载模块
        :load a.hs
    :l
    :cd
        # 切换工作目录
        :cd c:\a
    :reload
        # 重载所有模块
    :r
    :type
        :type 'H'
    :t
    :info
        # 查看一个typeclass有哪些instance和subclass
        # 类型的信息、函数的类型声明
    :k
        # 查看kind
        :k Int
            # Int :: *
        :k Maybe
            # Maybe :: * -> *
# 操作符
    %
        # 分号
    &&
    ||
    ++    
        # 字符串拼接
    /=
        # 不等
    do
        # 动作的combine, do 是>>=的语法糖, 用来连接一系列动作
    <-
        # name <- getLine, 存到变量
        # 除了程序的最后一行用来作返回值，其它语句都可以用 <-
# 表达式
    # 表达式可以随处安放
    if x < 0 then
        -1
    else if x > 0 then
        1
    else
        0

    case x of
        0 -> 1
        1 -> 5
        _ -> (-1)

    let a = 1
        # 局部绑定, in可省略则定义到全局
        twice_a = 2 * a
    in (a + twice_a, a - twice_a)
        
    let boot x  y z = x * y + z in boot 3 4 2
# I/O action
    # 在main中 I/O action才被执行
    # return () 语句产生I/O action, do接着执行
    # 执行后会打印结果，结果为()时不打印
    main = do
        _ <- putStrLn "a"
        name <- getLine
        putStrLn (name)
# 类型表示
    Eq a => a -> a -> Bool
        # => 前面是类型约束, 后面表示传入两个同类型参数，返回Bool类型
# 变量
    let pi = 3.14
        # 变量不可变，但可重复定义
    (-1)
        # 负数一般加小括号
      let r = 25 :: Double
        # 默认猜测是Integer
        # monomorphish restriction(单一同态限定)原理，可以指定polymorphic(多态)
        ## let r = 25 :: Num a => a
    True, False
        # 类型为 Bool
    "abc"
        # 类型为[char], 与'a':'b':'c':[]
        a = "aaa" :: String
            # 得到一个String, 与[char]同样使用
    LT, GT, EQ
# 函数
    # 函数名与参数，参数与参数之间有空格隔开
    # 函数比运算符先结合
    let area r = pi * r ^ 2
        # 定义函数, 
    area 2
    area (-2)
    let area2 r = area r
    let first (x, y) = x
        # 接收元组
    uppercase, lowercase :: String -> String
        # 指定函数类型
    分段定义
        # 编译成case语句
        f 0 = 1
        f 1 = 5
        f _ = -1
    函数合成调用
        square (f 1)
        (square . f) 1
    (\xs -> length xs > 15)
        # lambda表达式
        # lambda可以用模式匹配，但使用不了多个模式
       
# 列表
    # 列表，类型必须相同。
    # 列表都由[]追加得到，逗号是语法糖
    let n = [1, 2]
    [1..20]
        # range浮点数不精确
    take 20 [1,2..]
    [2,4..20]
    ['a'..'z']
    0:n
        # 得到追加列表[0, 1, 2]， 头部追加叫作consing, cons是constructor
        # -1:0:n
    [[1], [2]]
    n !! 1
        # 取元素
    l1 > l2
        # 元素依次比较
    [x*2 | x <- [1..10], x*2 >= 12]
        # list comprehension
        boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <-xs, odd x]
        [x*y | x <-[1,2], y <-[3,4]]
            # 聚合得[3,4,6,8]
        length' xs = sum [1 | _ <- xs]

        xxs = [[1,2], [3,4]]
        [[x | x <- xs, even x] | xs <- xxs]

        [(a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 = c ^2]

        [a + b | (a,b) <- xs]
            # list comprehension中的模式匹配
    模式匹配
        x:xs
        x:y:z:xs
# 元组
    # 类型可不同，不能单元素。2元组叫pairs, 3元组叫triples, n元组叫n-tuple
    # 元组不可变
    # 元组的类型由长度和其中的类型决定, ("a", 1)与(1, "a")是不同的类型，所以[("a", 1), (2, "b")]是错误的
    (True, 1)
    ((1,2), True)

# monad
    o-> do
    doGuessing num = do
        putStrLn "Enter your guess:"
        guess <- getLine
        if (read guess) < num
        then do putStrLn "Too low"
            doGuessing num
        else if (read guess) > num
        then do putStrLn "Too high"
            doGuessing num
        else putStrLn "You Win"
            # 只有一个动作时，可省略do

    o-> do
    doGuessing num = do
        putStrLn "Enter your guess:"
        guess <- getLine
        case compare (read guess) num of
            LT -> do putStrLn "Too low"
            GT -> do putStrLn "Too high"
            EQ -> putStrLn "You Win"

    o-> functor applicative monad
    class Functor f where
    fmap :: (a -> b) -> f a -> f b
    class Functor f => Applicative f where
    pure :: a -> f a
    () :: f (a -> b) -> f a -> f b
    class Applicative m => Monad m where
    return :: a -> m a
    (>>=) :: m a -> (a -> m b) -> m b
    (>>) :: m a -> m b -> m b
    x >> y = x >>= \_ -> y
    fail :: String -> m a
    fail msg = error msg
    instance Functor Maybe where
    fmap func (Just x) = Just (func x)
    fmap func Nothing  = Nothing
    instance Applicative Maybe where
    pure = Just
    Nothing  _ = Nothing
    (Just func)  something = fmap func something
    instance Monad Maybe where
    return = Just
    Nothing >>= func = Nothing
    Just x >>= func  = func x

# 内置函数
    prelude
        $
            # 函数调用符，优先级最低。而空格是最高优先级
            # $右结合。而空格左结合
            # 等价于在右而写一对括号
        .
            # f . g = \x -> f (g x)
            # 函数组合
        main
            # main :: IO ()
            main = do
        signum
            # 根据数字返回 -1, 0, 1
        not
        id
            # identity
        unlines
            unlines ["a", "b"]
                # 成为 "a\nb\n"
        unwords
            unwords ["a", "b"]
                # 成为 "a b"
        show
            # 接受各种类型，转换为String, 再转义打印
        read
            read "5" :: Int
            read "5" - 2
            read "[1,2,3]" ++ [4]
        reads
            # 读取失败返回[]而不报错
        negate
            # 取反数字
        abs
            # 绝对值
        length
            # 列表的长度, [a] -> Int , a在这里是一个type variable, 以小写字母开头(具体类型都大写开头)。
        map
        compare
            # 返回 LT, GT, EQ其中一个
        min
        max
        compare
            # 返回LT, GT, EQ
            "Abc" `compare` "Zyx"
        mod
            # 取模
        odd
            # 奇数
        even
            # 偶数
        succ
            # 取Enum的后继
        pred
            # 取Enum的前置
        minBound
            # 取Bound下限
        maxBound
        substract
            # 减

        head
        tail
            # 除第一个
        last
        init
            # 除最后一个

        null
            # 检查list是否空
        reverse
            # list反转
        take
            take 1 [1,2,3]
        takeWhile
            # 取list值，直到某条件
        drop
            drop 1 [1,2,3]
        maximum
            # list中最大元素
        minimun
            # list中最小元素
        sum
            # list和
        product
            # list积
        elem
            # 判断元素是否在list中
            4 `elem` [3,4,5]
        cycle
            take 7 (cycle [1,2,3])
                # [1,2,3,1,2,3,1]
        repeat
            repeat 5
        replicate
            replicate 3 10
                # [10, 10, 10]

        fst (1, 2)
            # 只适合2元组
        snd (1, 2)
            # 只适合2元组
        zip
            # zip3, zip4 ... zip7
            zip [1,2,3] [4,5,6]
                # [(1,4), (2,5), (3,6)]
        zipWith
            # zipWith1 ... zipWith7
            zipWith (\x y -> x + y) [1,2] [3,4]
                # [4,6]
        fromIntegral
            # 返回更通用的数字类型
        error ""
            # 抛错
        flip
            # 翻转两个参数调用
        map
        filter
        foldl
            foldl (\acc x -> acc + x) 0 xs
        foldr
            foldr (\x acc -> f x : acc) [] xs
        foldl1
            # 以第一个元素为初始值，空list报错
        foldr1
        foldl'
            # foldl的strict版
        foldr'
        scanl
            # 返回累加过程的list
        scanr
        scanl1
        scanr1
        o-> I/O action
            # 只有在main中执行
            # 类型为 IO a
            putStrLn
                # 只接受String，不转义打印，加换行符
                # putStrLn :: String -> IO () , 表示接收String, 是IO动作, 结果类型是()。表示是一个"IO monad"动作
            putStr
                # 由putChar递归定义，边界条件是空字符串
            putChar
            print
                # 打印Show typeclass的值
            getLine
                # 控制台读一行
                # getLine :: IO String
                name <- getLine
            getChar
            sequence
            # 顺序执行I/O action
            mapM
                mapM print [1,2,3]
                    # 对list元素执行sequence f
            mapM_
                # 同mapM，不打印[(),()]
            getContents
                # 读直到 eof (ctrl + d)
            interact
                # 用函数处理输入，返回到输出
    Data.List
        # 每个元素存在thunk中
        \
            # 差集
            [1..3] \\ [2]
                # [1,3]
            "Im a big baby" \\ "big"
                # "Im a baby"
        union
        intersection
        insert
            # 插入一个元素到可排序list相对位置
        nub
            # 去重复元素,常用Set转换取代,提高很多效率
        map
            # 导出到了prelude
        filter
            # 导出到了prelude
        intersperse
            intersperse '.' "abc"
                # "a.b.c"
        intercalate
            # 同intersperse, 但插入list
        transpose
            # 二元list列为行
        foldl'
            # fold的严格版，直接计算出中间值，而非用惰性"承诺"塞满堆栈
        foldl1'
        concat
            # 移除一级嵌套
        concatMap
            # 先map再concat
            concatMap (replicate 2) [1..3]
                # [1,1,2,2,3,3]
        and
            # list中全true返回true
            and $ map (>4) [5,6,7,8]
        or
        any
        iterate
            # 无限迭代值到函数，结果形成list
            take 10 $ iterate (*2) 1
        splitAt
            # 断开list, 返回二元组
            splitAt 3 "abcdef"
                # ("abc", "def")
        takeWhile
            # 取元素，直到不符合条件
        dropWhile
        span
            # 同takeWhile, 不过返回分割list的二元组
        break
            # 同span, 但在条件首次为true时断开
        sort
            # list元素要求Ord类型，排序list
        group
            # 合并相邻并相等的list元素
        inits
            # init递归调用自身
            inits "abc"
                # ["", "a", "ab", "abc"]
        tails
            # tail递归调用自身
            tails "abc"
                # ["abc", "bc", "c", ""]
        isInfixOf
            # list中搜索子list, 有则返回true
            "cat" `isInfixOf` "im a cat"
        isPrefixOf
            # 是否以某list开头
        isSuffixOf
            # 是否以某list结尾
        elem
            # 是否包含某元素
        notElem
        partition
            # 条件划分list为二元组
            partition (`elem` ['A'..'Z']) "AbCD"
                # ("ACD", "b")
        find
            # 条件查找list, 返回第一个符合元素的Maybe值
        elemIndex
            # 返回elem第一个元素的索引的Maybe值
        elemIndices
            # 返回所有匹配索引的list
        findIndex
        findIndices
        lines
            # 字符串分行到list
        unlines
        words
            # 字符串分词到list
        unwords
        delete
            # 删除list中第一个匹配元素
            delete 'h' "hha"
                # "ha"
        replace
        lookup
            # 用a查找[('a', 'b')]中的b
        genericLength
            # 换Int类型为Num类型
        genericTake
        genericDrop
        genericSplitAt
        genericIndex
        genericReplicate

        nubBy
            # 传递函数判断相等性，取代==
        deleteBy
        unionBy
        intersectBy
        groupBy
        sortBy
        insertBy
        maximumBy
        minimumBy
    Data.Monoid
        Monoid
        Product
        Sum
        Any
        All
    Data.Foldable
        foldr
        foldl
        foldr1
        foldl1
    Data.Function
        on
            ((==) `on` (> 0))
                # 判断相等性，等价于 (\x y -> (x > 0) == (y > 0))
            (compare `on` length)
                # 判断大小
    Data.Char
        isControl
            # 是否控制字符
        isSpace
            # 包括空格, tab, 换行等
        isLower
        isUpper
        isAlpha
            # 是否字母
        isAlphaNum
            # 字母或数字
        isPrint
            # 可打印
        isDigit
        isOctDigit
        isHexDigit
        isLetter
            # 同isAlpha
        isMark
            # unicode注音字符
        isNumber
        isPunctuation
            # 是否标点符号
        isSymbol
            # 货币符号
        isSeperater
            # unicode空格或分隔符
        isAscii
            # unicode 前128位
        isLatin1
            # unicode 前256位
        isAsciiUpper
        isAsciiLower
        GeneralCategory
            # 得到字符的分类，一共31类, 属于Eq类型
            generalCategory ' '
                # Space
        toUpper
        toLower
        toTitle
        digitToInt
            # 数字，大小写字母list 转成 int list
        intToDigit
        ord
        char
    Data.Map
        # 用avl树实现
        fromList
            # 重复键会忽略，要求key有相等性和排序性
        fromListWith
            # 重复键给函数处理
        toList
        empty
            # 返回空map
        insert
            insert 3 10 map
        insertWith
            # 已包含键时函数处理
        null
            # 检查map是否空
        size
            # 返回map的大小
        singleton
            singleton 3, 9
                # fromList [(3,9)]
        lookup
        member
            # key 是否在map中
        map
        filter
        keys
        elems
    Data.Set
        # 要求元素可排序，自动排序、唯一
        # 用avl树实现
        fromList
        intersection
        difference
            # 存在于第一集合而不在第二集合的元素
        union
        null
        size
        member
        empty
        singleton
        insert
        delete
        isSubsetOf    
            # 子集
            fromList [1,2] isSubsetOf fromList [1,2]
        isProperSubsetOf
            # 真子集
        filter
        map
    Data.ByteString
        # strict bytestring
        # Empty相当于[], cons相当于:
    Data.ByteString.Lazy
        # 每个元素存在chunk中，每个chunk 64k，每个chunk相当于一个strict bytestring
        # cons在chunk不满的时候会新建chunk, cons'是strick版的cons, 会填充chunk
        pack
            # pack :: [Word8] -> ByteString
            pack [80,81]
        unpack
        fromChunks
            # 转换strick bytestring 到lazy
        toChunks
            # lazy转strick
    Data.Ratio
    Control.Applicative
        Applicative
            class (Functor f) => Applicative f where
                pure :: a -> fa
                (<*>) :: f (a -> b) -> f a -> f b
                f <$> x = fmap f x
        ZipList
            ZipList3
            ZipList7
        getZipList
        liftA2
            liftA2 f x y = f <$> x <*> y 
        sequenceA
    Control.Monad
        when
            # Bool true时，返回后面的I/O action, 否则return ()
        forever
            # 不断执行后面的I/O action
            forever $ do
                putStr "a"
        forM
            # 同mapM, 但两个参数顺序相反
        liftM
            # monad中的fmap
        liftM2 liftM3 liftM4 liftM5
        `ap`
            # monad中的<*>
        join
            join :: (Monad m) => m (m a) -> m a
            join mm = do
                m <- mm
                m
        filterM
        foldM
    Control.Monad.State
        State
            newtype State s a = State {runState :: s -> (a, s)}
        get
        put
    Control.Monad.Error
    System.IO
        openFile
            # openFile :: FilePath -> IOMode -> IO Handle
            # data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
            do
            handle = openFile "a.txt" ReadMode
            contents <- hGetContents handle
            putStr contents
            hClose handle
        withFile
            # withFile :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
            # 处理完关掉
            withFile "a.txt" ReadMode (\handle -> do
                contents <- hGetContents handle
                putStr contents)
        readFile
            # readFile :: FilePath -> IO String
            do
            contents <- readFile "a.txt"
            putStr contents
        wirteFile
            # writeFile :: FilePath -> String -> IO ()
            do
            writeFile "a.txt" contents
        appendFile
        hSetBuffering
            # 读binary file时的buffer，默认是系统值
            # data BufferMode = NoBuffering | LineBuffering | BlockBuffering (Maybe Int)
            hSetBuffering handle $ BlockBuffering (Just 2048)
        hFlush
            # 写入时自动Flush
        openTempFile
            (tempName, tempHandle) <- openTempFile "." "temp"
        hGetContents
        hClose
        hGetLine
        hPusStr
        hPutStrLn
        hGetChar
    System.IO.Error
        catch
            # catch :: IO a -> (IOError -> IO a) -> IO a
            toTry `catch` handler
            handler e
                | isDoesNotExistError e = 
                    case ioeGetFileName e of Just path -> putStrLn $ "a" ++ path
                        Nothing -> putStrLn "b"
                | otherwise = ioError e
        isDoesNotExistError
        isAlreadyExistsError
        isFullError
        isEOFError
        isIllegalOperation
        isPermissionError
        isUserError
        ioeGetFileName
            # ioeGetFileName :: IOError -> Maybe FilePath
        ioError
            # 丢出接到的error
    System.Directory
        removeFile
            removeFile "a.txt"
        renameFile
            renameFile tempName "a.txt"
        copyFile
        doesFileExist
    System.Environment
        getArgs
        getProgName
    System.Random
        mkStdGen
            # mkStdGen :: Int -> StdGen
        getStdGen
            # IO类型, 得到系统启动时的global generator
        newStdGen
            # 把现有的random generator分成两个新的generators, 其中一个指定成新的，返回另一个
        random
            # random :: (RandomGen g, Random a) = g -> (a, g)
            random (mkStdGen 100) :: (Int, StdGen)
        randoms
            take 5 $ randoms (mkStdGen 11) :: [Int]
        randomR
            # 区间random
            randomR (1,6) (mkStdGen 2)
        randomRs
            take 10 $ randomRs ('a', 'z') (mkStdGen 3) :: [Char]
# 函数        
    o-> 模式匹配
        # case的语法糖
        # 对构造子匹配，如 8 'a' : []
    factorial :: (Integral a) => a -> a
    factorial 0 = 1
    factorial n = n * factorial (n - 1)

    addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
    addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

    first :: (a, b, c) -> a
    first (x, _, _) = x

    tell :: (Show a) => [a] -> String
    tell [] = ""
    tell [x: []] = ""
    tell [x:y:[]] = ""
    tell [x:y:_] = "too long, the first is " ++ show x ++ " and the second is " ++ show y

    length' :: (Num b) => [a] -> b
    length' [] = 0
    length' (_:xs) = 1 + length' xs

    capital :: String -> String
    capital "" = ""
    capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
        # @是as模式

    o-> guard
    bmiTell :: (RealFloat a) => a -> String
    bmiTell weight height
        | bmi <= skinny = "You're underweight"
        | bmi <= normal = "You're supposedly normal"
        | bmi <= fat = "You're fat"
        | otherwise = "You're a whale"
        where bmi = weight / height ^ 2
        (skinny, normal, fat) = (18.5, 25.0, 30.0)
            # where是语法结构，不是表达式
    calcBmis :: (RealFloat a) => [(a, a)] -> [a]
    calcBmis xs = [bmi w h | (w, h) <- xs, let bmi = w / h ^ 2]

    myCompare :: (Ord a) => a -> a -> Ordering
    a `myCompare` b
        | a > b = GT
        | a == b = EQ
        | otherwise = LT

    o-> quicksort
    quicksort :: (Ord a) => [a] -> [a]
    quicksort [] = []
    quicksort (x:xs) = 
        let smallerSorted = quicksort (filter (<=x) xs)
            biggerSorted = quicksort [a | a <- xs, a > x]
        in smallerSorted ++ [x] ++ biggerSorted

    o-> curry
    compareWithHundred :: (Num a, ord a) => a -> Ordering
    compareWithHundred = compare 100

    divideByTen :: (Floating a) => a -> a
    divideByTen = (/10)
        # 中缀函数用括号来不完全调用
        # 但(-4)表示负4, (substract 4)来表示减4函数

    o-> 高阶函数
    applyTwice :: (a -> a) -> a -> a
    applyTwice f x = f (f x)

    o-> lambda
    addThree :: (Num a) => a -> a -> a -> a
    addThree = \x -> \y -> \z -> x + y + z

    o-> $ 做数据函数
    map ($ 3) [(4+), (10*), (^2), sqrt]
# 类型
    类型
        Int
            # 有界整数
        Integer
            # 无界整数
        Float
            # 单精度浮点数
        Double
        Bool
        Char
        Maybe
        []
        ()
        a
            # type variables
    类型约束
        Eq
        # 可判断相等性的类型，可用 == 或 /= 判断
            # 只除函数
        Ord
            #可比较大小的类型, 必定是Eq
            # 只除函数
        Ordering
            # 只有GT, EQ, LT
        Show
            # 可用字符串表示的类型
            # 只除函数
        Read
            # 与Show相反
        Enum
            # 连续的类型，有后继子(successer)和前置子(predecesor), 分别通过succ函数和pred函数得到
            # 可以[1..2]构造list
            # 包含 (), Bool, Char, Ordering, Int, Integer, Float, Double
        Bounded
            # 有上限和下限
            # 如果Tuple中都属于Bounded, 那么这个Tuple属于Bounded
        Num
            # 数字特征
        Integral
            # 整数
        Floating
            # 浮点，包含Float和Double
    构造类型
        data Bool = False | True deriving (Ord)
            # Bool是构造的类型, False为值构造子，值可以用:t查看其类型
            # 值构造子可以用于模式匹配
            # 这里值构造子是没有参数的，叫作nullary
            # False在True前，所以比较时True比False大
        data Point = Point Float Float deriving (Show)
            # 值构造子可以与类型同名
        data Shape = Circle Point Float | Rectangle  Point Point deriving (Show)
            # 派生自Show, 就可show值成字符串
        data Person = Person {firstName :: String
            , lastName :: String
            } deriving (Show)
                # Record Syntax, 同 Person String String,  但自动生成同名的取值函数，show显示也改变
            let p = Person {firstName="aa", lastName="bb"}
        
            tellPerson :: Person -> String
            tellPerson (Person {firstName = a, lastName = b}) = a ++ b
        newtype CharList = CharList {getCharList :: [Char]} deriving {Eq, Show}
            # newtype将现有类型包成新类型，只能定义单一值构造子，且其只能有一个字段。并将包裹和解开的成本都去掉
    类型构造子
        # data声明中不能加类型约束
        data Maybe a = Nothing | Just a
        data Car a b = Car { company :: a
            , year :: b
            } deriving (Show)
        tellCar :: (Show a) => Car String a -> String
    类型别名
        type String = [Char]
        type AssocList k v = [(k,v)]
            # 别名类型构造子
        type IntMap = Map Int
            # 不全调用得到不全类型构造子, 同 type intMap v = Map Int v
    infixr
        infixr 5 :-:
            # 定义中缀构造子, 5是优先级, :-:是符号
            # 默认left-associative

        infixr 5 .++
        (.++) :: List a -> List a -> List a
        Empty .++ ys = ys
        (x :-: xs) .++ ys = x :-: (xs .++ ys)
    recursive data structures
        data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)
    typeclass
        class Eq a where
            (==) :: a -> a -> Bool
            (/=) :: a -> a -> Bool
            x == y = not (x /= y)
            x /= y = not (x == y)
                # 只需要instance一个定义就好，这个定义叫minimal complete definition
        data TrafficLight = Red | Yellow | Green
        instance Eq TrafficLight where
            Red == Red = True
            Green == Green = True
            Yellow == Yellow = True
            _ == _ = False
        instance Show TrafficLight where
            show Red = "Red light"
            show Yellow = "Yellow light"
            show Green = "Green light"

        class (Eq a) => Num a where
            # Num 是 Eq  的 subclass, 要是Num必是Eq

        instance (Eq m) => Eq (Maybe m) where
            Just x == Just y = x == y
            Nothing == Nothing = True
            _ == _ = False
                
    o-> Either
    data Either a b = Left a | Right a deriving (Eq, Ord, Read, Show)

    o-> Tree
    data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

    o-> YesNo
    class YesNo a where
        yesno :: a -> Bool
    instance YesNo Int where
        yesno 0 = False
        yesno _ = True

    o-> Functor
    class Functor f where
        # map over
        fmap :: (a -> b) -> f a -> f b
    instance Functor Maybe where
        # 接收构造子而非类型
        fmap f (Just x) = Just (f x)
        fmap f Nothing = Nothing
    instance Functor (Either a) where
        # parital apply Either, Either a 是个类型构造子
        fmap f (Right x) = Right (f x)
        fmap f (Left x) = Left x
    instance Functor ((->) r) where
        # 对函数的functor
        fmap f g = (\x -> f (g x))
# 命令
    ghci
        set prompt "ghci> "
            # 设置显示的提示符
    ghc
        ghc --make a.hs
    runhaskell
    ghc-pkg list
        # 列出已安装的软件包
# 玄学
    o->
    :{
    data X = X
    a :: Int -> Int
    a x = x + 3
    :}