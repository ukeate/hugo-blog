---
Categories : ["媒体"]
title: "媒体"
date: 2018-10-10T15:13:01+08:00
---


# 原理

## 硬件
    CRT cathode ray tube 阴极射线管显示器
        随机扫描方式
        光栅扫描方式
        DPU distributed processing unit 分散处理单元
## 标准
    Core Graphics System
        CGI(computer graphics interface)
            # 与设备无关的方法，方便的直接控制图形设备
        CGM(computer graphics metafile)
            # 设备无关的主义定义图形文件格式
        GKS(graphics kernal system)
            # 应用程序与图形输入输出设备之间的功能接口
        PHIGS(programmer's hierarchical interactive graphics system)
            # 为3d设计的工具库
        GL(graphics library)
            # 广泛应用的标准图形程序库
## 算法
    基元的显示
        直线扫描转换
            DDA
            中点画线法
            Bresenham画线
        圆的扫描转换
            中点画圆
            Bresenham
        区域填充
            种子填充
            多边形扫描转换
    图形变换
        二维图形变换
        二维视见变换
        三维图形变换
        投影
            平行正交
            平行斜交
            透视投影
        裁剪
            直线段裁剪算法
                Cohen-Sutherland算法
                中点分割算法
                梁友栋-Barsky算法
            多边形裁剪Sutherland-Hodgman算法
            三维图形裁剪
                梁友栋-Barsky算法
    曲线和曲面
        概念
            插值
            逼近
            参数连续性
            几何连续性
            光顺(smoothness)
        Hermite插值曲线多项式 Coons曲面
        Bezier曲线和曲面
        B样条曲线和曲面
    图形运算
        交点计算
        多边形表面交线计算
        平面中的凸壳算法
            Graham扫描
            Jarvis行进
        包含与重叠
            凸多边形
        多边形的三角剖分
    形体的表示
        概念
            图形信息
                几何信息
                拓扑信息
            非图形信息
                颜色
                亮度
                质量
                体积
        二维
            边界
                拆线逼近曲线
                    选点
                        共线性
                        三点转角阈值
                    带树法
            图形的四叉树表示法
        三维
            几何元素
                点
                边
                环(有序有向边)
                面
                体
                体素
                    一组单元实体: 长方体、圆柱体、圆锥体、球体
                    扫描体
                    代数半空间定义的形体
            线框图
                顶点表、边表、面表
                边界表示法
            实体
                CSG(constructive solid geometry), 指任意复杂形体都可用的体素组合
                特征表示
                Brep表示
            八叉树(四叉树的推广)
        分形
            规则分形
                # 严格自相似性的分形
            Von Koch算法
            Julia集和Mandelbrot集
    消除隐藏线和隐藏面
        线面比较法消除隐藏线
        浮动水平线消除曲面隐藏线
        深度排序算法(优先级算法)
            画家算法(深度优先级表法)
            z一缓冲算法(深度缓冲算法)
        扫描线算法消除隐藏面
        区域分割算法消除隐藏面
        BSP(binary space partitioning)树算法判别物体可见性
        八叉树算法消除隐藏面
        光线投射算法找到可见面
            # 对包含曲面(特别球面的场景效率高)
    真实感
        漫反射及光源照明
            照明效应
                漫射照明
                具体光源照明的照射效应、透射效应
                    漫反射、镜面反射
            环境光
            漫反射
            镜面反射与Phong模型
            光的衰减
        多边形网的明暗处理
            常数明暗法
            亮度插值明暗法(Gouraund着色)
            法向量插值明暗法(Phong着色)
        阴影
        纹理(texture)
        整体光
            透射光亮度模拟
            Whitted光照模型(以Phong为基础)
        光线跟踪
            # 适用光滑表面
            包围盒
            空间分割成网格单元
        辐射度方法
            # 描述封闭环境中的能量交换
            # 可模拟彩色渗透现象
        色彩模型
            颜色
                色彩(Hue)
                色饱和度(Saturation)
                明度(Brightness)
            CIE(国际照明委员会)色度图(红绿蓝)
            混合系统
                面向硬件
                    RGB 红绿蓝加色系统
                    CMY 青、品红、黄着色系统
                        彩色印刷、胶卷等非发光显示体中采用
                面向用户
                    HSV(Hue, saturation, value)
                        # 六棱锥模型
                        # 可与RGB空间互相转化
                        HLS(Hue, lightness, saturation)双六棱锥模型

## 2d
### 分形
    介绍
        Fractal
        具有自相似性质的多个形状
            大的部分由小的部分组成，小的部分像大的部分
            用递归算法模拟
    Mandelbrot Set
        介绍
            分形领域最著名的科学家 本华.曼德博
            曼德博集合常常由 z^2 + c定义
## 3d
### 术语
    顶点(vertexs): 
    图元(primitives, entity, 图素, 实体): 顶点组合为图元
    片元(fragments, 片段): 图元裁剪、颜色、纹理、坐标转换等后合成片元
    像素(pixels)
### 硬件
    cpu与gpu
        特点
            cpu串行运算，电量分配给控制器和缓存，没有太多计算单元
            97, 98年 nvidia 出品 nvidia系列显卡，并行计算。gpu控制单元少，计算单元多
        构造
            cpu通过cpu总线连接内存，cpu总线和pci总线通过主桥(北桥)连接，pci总线连接显卡
            webgl中大量控制逻辑用js编写cpu执行，交给gpu渲染。要渲染的数据从内存传入显存，再由显卡计算
                最耗时的是内存到显存之前的数据传输
### 模型
    mesh模型
        无数三角形面组成的物体（可帖上纹理）。
    概念
        3d模型由顶点(vertex)组成，顶点连成三角形或四边形，再组成复杂的立体模型
        网格模型
    加载过程
        ajax下载文件
        解析成Mesh模型
        显示在场景中
    三角形
        # 渲染效率最高
        顶点
            Vertex
        正反面
            顶点顺时针排列为正面
        法线
            Normal
            正面指向，垂直于面的矢量
            作用
                法线与入射光角度越小，该点光线越强
        顶点法线
            Vertex Normal
            过顶点的矢量
            作用
                高洛德着色(Gouraud Shading) 中计算光照和纹理效果。
                生成平滑的棱时，令顶点法线和相邻多平面法线保持等角
                生成棱时顶点法线为点所在平面的法线(可多个), 这样在面连接处形成突出的边缘。
    google 3d模型库
        sketchup.google.com/3dwarehouse/
    vtk
        vtk DataFile Version 3.0                # 4.0已经出来，3.0广泛使用
        vtk output                                # 一般不改变
        ASCII                                        # 使用标准ASCII码， 也可以写binary
        DATASET POLYDATA                        # 表示多边形面集，面由点组成
                                                ## POLYDATA是数据类型, 可以是STRUCTED_POINTS, STRUCTURED_GRID, UNSTRUCTURED_GRID, POLYDATA, FIELD等。POLYDATA表示三角形或四边形数据。
        POINTS 35947 float                        # 表示该模型由35947个点组成，坐标分量是浮点型
                                                ## 这行的后面是35947 * 3个float型数字。每三个数字表示一个点
        POLYGONS 69451 277804                # POLYGONS是关键字, 69451表示模型有69451个多边形
                                                ## 后面行的 3 21216 21215 20399中3表示每个多边形三个顶点。每一行是一个多边形面。21216 21215 20399表示在POINTS 35947 float段中的索引。
                                                ## 277804表示整个POLYGONS占据的数组的长度，计算公式是69451 * 4 = 277804, 乘数4是3 21216 21215 20399这组元素的长度。用于计算存储空间
        CELL_DATA 69451                        # 表示面的个数，和POLYGONS上定义的面个数一致。
        POINT_DATA 35947                        # 表示点的个数, 和POINTS中定义的点个数一致。
    贴图
        立方体环境贴图(Cubic Environment Mapping)
            # 简称立方体贴图
            介绍
                一个纹理包含了包围物体场景的图像数据。x, y, z轴正负方向各一张图片，首尾相连。

### 计算
    旋转的三种工具
        矩阵
            用来与点相乘，改变点的位置
        欧拉角
            三个轴的旋转角度(Yaw[z], Pitch[y], Roll[x])来表示几何体的旋转
            欧拉角很容易转换为矩阵。使用欧拉角更形象一些
        四元组
    四元组
        介绍
            表示任何一个方向上的轴，和围绕这个轴旋转的弧度
            可方便地与欧拉角和矩阵之间通过公式转换
    三维投影
        三维空间中的点变为二维屏幕上的点是投影运算
            # 二维空间变到三维空间是反投影运算
            ## 如鼠标从二维到三维的反投影
    三维布尔运算
### 渲染

# 工具
    flash
    3d max
    blender
    ps
    unity3d
    wirefusion
    maya
    rhino
    illustrator
    gimp
