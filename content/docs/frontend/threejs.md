---
Categories : ["前端"]
title: "Threejs"
date: 2018-10-11T07:58:16+08:00
---

# 介绍
    协调程序加载项的类库
# 使用
    var preload = new createjs.LoadQueue(false, "assets/");
    var plugin= {
            getPreloadHandlers: function(){
                    return{
                            types: ["image"],
                            callback: function(src){
                                    var id = src.toLowerCase().split("/").pop().split(".")[0];
                                    var img = document.getElementById(id);
                                    return {tag: img};
                            }
                    }
            }
    }
    preload.installPlugin(plugin);
    preload.loadManifest([
            "Autumn.png",
            "BlueBird.png",
            "Nepal.jpg",
            "Texas.jpg"
    ]);
# api
## 涉及dom
    属性
            window.innerWidth
            window.innerHeight
    事件
            window.addEventListener('resize', onWindowResize, false);
                    function onWindowResize(){
                            camera.aspect = window.innerWidth / window.innerHeight;
                            camera.updateProjectionMatrix();
                            renderer.setSize(window.innerWidth, window.innerHeight);
                            controls.handleResize();
                    }
    三大组件
        场景(scene)
                var scene = new THREE.Scene();
        相机(camera)
                var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);                                        # 透视相机
        渲染器(renderer)
                var renderer = new THREE.WebGLRenderer();
                renderer.setSize(window.innerWidth, window.innerHeight);
                document.body.appendChild(renderer.domElement);                        # domElement 是画布
                render( scene, camera, renderTarget, forceClear )                        ＃ renderTarget默认是前面设置的renderer  size, forceClear自动清除(设置为false也会清除)
    版本
        THREE.VERSION
## renderer
    使用
        THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);                # 透视摄像机
        camera.position.x = 0;
        camera.position.y = 0;
        camera.position.z = 600;                                                                # 相机位置
        camera.up.x = 0;
        camera.up.y = 1;
        camera.up.z = 0;                                                                        # 相机"上"的方向
        camera.lookAt({x:0, y:0, z:0});                                                                # 视野中心坐标
        camera.setViewOffset(fullWidth, fullHeight, viewX, viewY, viewWidth, viewHeight)
                # 相机的有效显示部分

    WebGLRenderer 
        renderer = new THREE.WebGLRenderer({ antialias: false});
                        # 抗锯齿为false。true时显示更清晰，更耗cpu
                renderer.setClearColorHex( 0x000000, 1);
                renderer.setSize(window.innerWidth, window.innerHeight);
                        # 设置渲染器的宽度和高度
                renderer.autoClear = false;
                renderer.sortObjects = false;
                
                renderTarget = new THREE.WebGLRenderTarget(window.innerWidth, window.innerHeight);
                        # 设置一个渲染目标
                renderTarget.minFilter = THREE.LinearFilter;
                renderTarget.magFilter = THREE.NearestFilter;
                postBloom = new BloomEffect(renderer, renderTarget, window.innerWidth, window.innerHeight, 4);

                renderer.shadowMapEnabled = true;
                        # 开启显示阴影
                        ## 要显示阴影，还要设置物体castShadow = true; receiveShadow = true;
                        ## shadowMap是一张记录每个像素用于比较遮挡关系的texture
                renderer.shadowMapSoft = true;
                        # 可以使阴影更加平滑，产生更少的锯齿
                renderer.shadowCameraNear = 3;
                renderer.shadowCameraFar = camera.far;
                renderer.shadowCameraFov = 50;
                        # 表示摄像机近平面、远平面、角度的值。在摄像机范围内的物体产生阴影
                renderer.shadowMapBias = 0.0039;
                renderer.shadowMapDarkness = 0.5;
                        # 表示阴影的透明度, 0是完全透明
                renderer.shadowMapWidth = 512;
                renderer.shadowMapHeight = 512;
                        # 指定阴影渲染面的大小
                        ## 根据shadermap原理，阴影需要先绘制在一个缓冲区中，再根据缓冲区计算阴影。这就是缓冲区的大小。

                container = document.createElement('div');
                document.body.appendChild(container);
                container.appendChild(renderer.domElement);
## camera
    使用
        camera = new THREE.Camera(60, 1, 1, 6500);
        camera.position.z = -85;
        camera.position.y = 40;
        camera.aspect = window.innerWidth / window.innerHeight;

        cameraTarget = new THREE.Object3D();
                # 相机目标
        cameraTarget.position.y = 10;
        cameraTarget.position.z = 6000;
        camera.target = cameraTarget;

        camera.updateProjectionMatrix();
    PerspectiveCamera
        THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);                # 透视摄像机
        camera.position.x = 0;
        camera.position.y = 0;
        camera.position.z = 600;                                                                # 相机位置
        camera.up.x = 0;
        camera.up.y = 1;
        camera.up.z = 0;                                                                        # 相机"上"的方向
        camera.lookAt({x:0, y:0, z:0});                                                                # 视野中心坐标
        camera.setViewOffset(fullWidth, fullHeight, viewX, viewY, viewWidth, viewHeight)
                # 相机的有效显示部分
    OrthographicCamera
        OrthographicCamera(left, right, top, bottom, near, far)
                # 左右上下远近
    controls
        contorls = new THREE.FirstPersonControls(camera);
        contorls.movementSpeed = 20;                                        # 移动速度
        controls.lookSpeed = 0.05;                                                # 转头速度
        controls.lookVertical = true;                                                # 是否允许抬头或低头
    PathControls        # 路径相机
        controls = new THREE.PathControls(camera);
        controls.createDebugPath = true;
                # 是否显示轨道
                ## scene.add(controls.debugPath)来添加显示
        controls.waypoints = [[-500, 0, 0], [0, 200, 0], [500, 0, 0]];
                # 路径的转折点，非转折点用插值来计算
        controls.duration = 28;
                # 轨道的一头到另一头的运动时间(ms), 默认是10 * 1000
        controls.useConstantSpeed =true;
                # 设置为匀速运行
        controls.lookSpeed = 0.06;
                # 转头速度, 默认是0.005。数越大，转头越快
                ##页面显示帧数越快, 转头越快
        controls.lookVertical = true;
                # 是否可以上下转头
        controls.lookHorizontal = true;
                # 是否可以左右转头
        controls.verticalAngleMap = {srcRange: [0, 2 * Math.PI], dstRange:[1.1, 3.8]};
        controls.horizontalAngleMap = {srcRange: [0, 2 * Math.PI], dstRange: [0.3, Math.PI - 0.3]};
        controls.lon = 180;

        controls.init();
        scene.add( controls.animationParent );
                # 用THREE.js提供的Animation类来插值改变相机位置和方向
                ## pathControls类中有initAnimationPath函数将动作转换为关键帧，存到了parentAnimation属性中
                ### THREE.AnimationHandler中的add函数，把scene中的parentAnimation中的关键帧动作键入THREE.JS的动画引擎中。动画引擎会自动在关键帧之间插值，来决定关键帧中物体(如相机)的位置、大小、缩放等。

        function  render(){
                controls.update(delta);
                THREE.AnimationHandler.update(delta);
                        ### 让动画引擎动起来
        }
    TrackballControls   # 轨迹球相机
        介绍
                追踪相机, 轨迹球相机
        作用
                控制相机，左键旋转，右键平移，滚轮缩放
        api
                THREE.TrackballControls = function (object, domElement)
                        # object一般是传入相机这个变量
                        # domElement为在哪个div中监听鼠标事件, 默认为document

        controls = new THREE.TrackballControls(camera);
                # 传入相机作为参数来控制相机
        controls.rotateSpeed = 5.0;
                # 旋转的速度
        controls.zoomSpeed = 5;
                # 缩放的速度
        controls.panSpeed = 2;
                # 平移的速度
        controls.noZoom = false;
                # 不允许放大
        controls.noPan = false;
                # 不允许右键摇镜头
        controls.staticMoving = false;
                #  是否静态移动, false时移动镜头会有弹性
        controls.dynamicDampingFactor = 0.3;
                # 阻力系数
                ## 旋转时慢慢停下来是这个系数起作用

        function animate(){
                requestAnimationFrame(animate);
                controls.update();
                        # 完成更新相机属性的工作
                rederer.render(scene, camera);
                stats.update();
        }
    FlyControls     # 飞行相机
    FirstPersonControls     # 第一人称相机
## scene
    使用
        scene = new THREE.Scene();  # 场景
                scene.add(meshCube);
                scene.add(light);
## light
    使用
        // light.position.x = x;
        light.position.set(0, 0, 300).normalize();;        
                # 坐标, 向量化为1

        scene.add(light);                        
    PointLight  # 点光源
        var light = new THREE.PointLight(0x00FF00);
    DirectionalLight    # 方向光
        var dirLight = new THREE.DirectionalLight( 0xffffff, 0.125);
                # 0.125是颜色的密度, 和透明度差不多, 这里表示很淡很淡的白色
        scene.add(dirLight)
    AmbientLight    # 环境光
        scene.add(new THREE.AmbientLight(0x111111));
    SpotLight   # 聚光灯
        light = new THREE.SpotLight(0xffffff, 1.25);
            light.target.position.set(0, 0, 0);
            light.castShadow = true;
                    # 显现阴影，默认不显现
                    ## 显现阴影还要对renderer进行设置
## object
### mesh
    使用
        var mesh = THREE.Mesh(geometry, material);                                                                # mesh模型
                mesh.position.x= x;
                mesh.rotation.x = rx;
                scene.add(meshCube);
        方法
                mesh1.addChild(mesh2)
                        # mesh2加入mesh1, 组成一个Mesh
                
        api
                mesh.scale.multiplyScalar(0.35)
                        # 让x y z方向缩放系数到原模型的0.35倍
    line
        THREE.Line( geometry, material, THREE.LinePieces );                                                ＃ 线
                scene.add(line);
        例子
                var line_material = new THREE.LineBasicMaterial({color: 0x303030}),
                geometry = new THREE.Geometry(),
                floor = -75, step = 25;
                for( var i = 0; i <= 40; i++){
                        geometry.vertices.push(new THREE.Vector3(-500, floor, i * step - 500));
                        geometry.vertices.push(new THREE.Vector3(500, floor, i * step - 500));

                        geometry.vertices.push(new THREE.Vector3(i * step - 500, floor,- 500));
                        geometry.vertices.push(new THREE.Vector3(i * step - 500, floor, 500));
                }
                var line = new THREE.Line(geometry, line_material, THREE.LinePieces);
                scene.add(line);
    MorphAnimMesh
        介绍
                动画网格模型
                包含几个动画帧(一极动画模型)，通过播放帧来看动画。
                可以设置帧数，播放到哪一帧，顺播还是倒播。
        THREE.MorphAnimMesh = function (geometry, material){
                THREE.Mesh.call(this, geometry, material);
                        # 调用基类构造函数
                this.duration = 1000;
                        # 完成所有帧的时间(milliseconds)
                this.mirroredLoop = false;
                        # 表示镜像循环(是否循环播放)
                this.time = 0;
                        # 当前播放时间
                this.lastKeyframe = 0;
                        # 上一帧
                this.currentKeyframe = 0;
                        # 当前播放的帧
                this.direction = 1;
                        # 表示从前向后播放, -1是从后向前
                this.directionBackwards = false;
                        # 是否倒播
                this.setFrameRange(0, this.geometry.morphTargets.length - 1);
                        # 设置最小帧和最大帧
                        ## 这里开始帧是0, 结束帧是 总帧数 - 1
        }
        方法
                THREE.MorphAnimMesh.prototype.setDirectionForward = function(){
                        this.direction = 1;
                                # 1是前进, -1是后退
                        this.directionBackwords = false;
                                # false表示前进
                }
                        # 计算下一帧是哪一帧时，根据上面两个变量计算
                THREE.MorphAnimMesh.prototype.setDirectionBackward
                THREE.MorphAnimMesh.prototype.setAnimationLabel = function(label, start, end){
                        if( !this.geometry.animations) this.geometry.animation = {};
                        this.geometry.animations[label] = {start: start, end: end};
                }
                        # 设置帧分组标签(为了给每组设置不同的播放速度)
                THREE.MorphAnimMesh.playAnimation('A', 33)
                        # 播放标签为'A'的组动画，帧数(fps)为33帧/秒
                THREE.MorphAnimMesh.prototype.updateAnimation = function(delta
                        # delta表示实际浏览器每次刷新的间隔时间
                        # 作用: 主要更新lastKeyframe
### mesh组件                        
#### geometry
    介绍
            geometry表示形状
    THREE.Geometry();
            # 空几何体
            geometry.vertices.push(p1);
            # p1是一个点
            geometry.vertices.push(p2);
            geometry.colors.push( color1, color2 );

    属性
            vertices
                    # 顶点数组
            colors
            morphColors
                    # 加载json模型后存储颜色的地方
            faces        
                    # 面数组
                    color
            faceVertexUvs
                    # 面法线数组
                    方法
                            set                # 设置纹理坐标
                                    faceVertexUvs[0][2][0].set(0, 0)
                                    faceVertexUvs[0][2][1].set(0, 0)
                                    faceVertexUvs[0][2][2].set(0, 0)
                                    faceVertexUvs[0][2][3].set(0, 0)
                                            # 设置第2个面(顶面)的纹理坐标全部为0，这样就去掉了这个面的纹理坐标
                                            # 第一维表示第几种纹理，第二维表示第几个面，第三维表示第几个顶点的纹理坐标
    BufferGeometry
        一般编程中
                物体的形状可以用一个类Geometry来表示
                物体顶点内容如果放到缓冲区中，可以new分配连续的内存
                物体和内存是分离的
        Tree.js中
                物体和内存统一起来，形成了THREE.BufferGeometry
                THREE.BufferGeometry = Buffer + THREE.Geometry
                BufferGeometry是自由度最高的geometry类型
                        自由指定每个顶点的位置、颜色、法线(影响光照)
                        Buffer就是将顶点位置数组、顶点颜色数组等放在一个缓冲区中，加快加载与运行速度。
                                Buffer的这些缓冲区存储在BufferGeometry的属性attributes集合对象里面
                                        # attributes初始化时为空 this.attributes = {};
        api
                var geometry = new THREE.BufferGeometry();
                        # THREE.BufferGeometry = function()
    IcosahedronGeometry
        二十面体

        radius = 200
        geometry = new THREE.IcosahedronGeometry(radius, 1);
        faceIndices = ['a', 'b', 'c', 'd'];
        for(var i = 0; i < geometry.faces.length; i++){
                f = geometry.faces[i];
                        # 得到第i个面
                n = (f instanceof THREE.Face3) ? 3 : 4;
                        # 判断每个面由几个点组成
                        # 每个点可以由f.a, f.b, f.c, f.d得到
                for(var j = 0; j < n; j++){
                        vertexIndex = f[faceIndices[j]];
                                # 得到点在geometry中的索引
                        p = geometry.vertices[vertexIndex];
                                # 得到点
                        f.vertexColors[j] = color;
                                # 给面的顶点赋值
                                ## 顶点默认颜色为白色
                }
        }
    SphereGeometry
        var geometry = new THREE.SphereGeometry(70, 32, 16);
                # 70是半径, 32和16表示横向和纵向球体由多少线分割
    BoxGeometry
        介绍
                原来的CubeGeometry
        长立方体
                THREE.CubeGeometry = function(width, height, depth, widthSegments, heightSegments, depthSegments)
                        # 参数分别表示x y z轴长度和分别在x y z轴上被分成了几份
    CylinderGeometry
        圆柱体
                THREE.CylinderGeometry(100, 150, 400);
    PlaneGeometry   # 平面
    TextGeometry
        介绍
                可以从字体文件中生成字体几何体

        THREE.TextGeometry = function(text, parameters)
                # text是要显示的文字
                # parameters包括
                ## size: <float> 字体大小, 如80号是小字体
                ## height: <float> 厚度
                ## curveSegments: <int> 一条曲线上点的数目, 越多越精细
                ## font: <string> 使用字体的名称
                ## weight: <string> `取值normal或bold, 如果字体中没有bold, 整个程序会崩溃
                ## style: <string> 取值normal或italics(斜体), 没有italics也会崩溃

        使用
                在typeface上转换自己的字体
                        http://typeface.neocracy.org/fonts.html
                        # 要求字体的签名是TrueType或OpenType
                        # 在Convert Font页面选择要转换的字,可以加快转换,也减少生成js文件的大小
                var text3d = new THREE.TextGeometry('要显示的字', {
                        size: 120,
                        height: 30,
                        curveSegments: 3,
                        font: 'simhei',
                        face: 'simhei',
                        weight: 'normal'

        });

#### material
    使用
        THREE.LineBasicMaterial( parameters );                                                        # 线材质
            参数
                    Color：线条的颜色，用16进制来表示，默认的颜色是白色。
                    Linewidth：线条的宽度，默认时候1个单位宽度。
                    Linecap：线条两端的外观，默认是圆角端点，当线条较粗的时候才看得出效果，如果线条很细，那么你几乎看不出效果了。
                    Linejoin：两个线条的连接点处的外观，默认是“round”，表示圆角。
                    VertexColors：定义线条材质是否使用顶点颜色，这是一个boolean值。意思是，线条各部分的颜色会根据顶点的颜色来进行插值。（如果关于插值不是很明白，可以QQ问我，QQ在前言中你一定能够找到，嘿嘿，虽然没有明确写出）。
                    Fog：定义材质的颜色是否受全局雾效的影响。
                        uniforms: 传入着色器中的固定变量, 如
                                {
                                        scale: {type: 'v2', value: new THREE.Vector2()}
                                }
        THREE.MeshBasicMaterial({color: 0x00ff00});                                                        # mesh材质
    MeshBasicMaterial
        介绍
                是three.js中最基本的材质
        功能
                将mesh渲染成线框模式或平面模式
                        # 平面模式指表面渲染比较平整
        api
                new THREE.MeshBasicMaterial({
                        color: 0xffaa00, 
                        transparent: true, 
                                # 标志为true时颜色A分量(alpha)才起作用
                        blending: THREE.AdditiveBlending
                                # 混合方式, 对应OpenGL ES中不同混合方式。表示怎么与背景结合
                                ## OpenGL中有一个颜色缓冲区，存放每次渲染的颜色(目标颜色)，新颜色(源颜色)可以与它混合，形成最新的颜色。
                                ## 可以是THREE.NoBlending = 0
                                ### 不混合。直接用新颜色覆盖以前的颜色
                                ## THREE.NormalBlending = 1
                                ### 将源颜色与目标颜色通过透明度正常混合
                                ## THREE.AdditiveBlending = 2
                                ### 加法混合
                                ## THREE.SubtractiveBlending = 3
                                ### 减法混合
                                ## THREE.MultiplyBlending = 4
                                ### 乘法混合
                                ## THREE.CustomBlending = 5
                                ### 自定义混合
                });
                new THREE.MeshBasicMaterial({
                        color: 0xffaa00, 
                        wireframe: true
                });
                new THREE.MeshBasicMaterial({
                        map: texture, 
                        transparent: true
                });

    MeshNormalMaterial
        只支持以THREE.FlatShading模式来渲染Mesh, 不支持将Mesh渲染为线框模式

    MeshLambertMaterial
        在灰暗或不光滑的表面产生的均匀散射而形成的材质类型。向各个方向均反射光线。如白纸

        new THREE.MeshLambertMaterial({
                color: 0xff6600,                                # 材质的颜色
                ambient: 0xff2200,                                # 受环境光情况
                envMap: textureCube,                                # 环境纹理，会将环境纹理映射到材质身上
                combine: THREE.MixOperation,                # 与环境材质之间的混合方式
                reflectivity: 0.3                                        # 对反射光的反射系数
        })
        new THREE.MeshLambertMaterial({map:texture, transparent: true})
                # 带透明的兰伯特材质, 可以看到球体另一边的颜色
        new THREE.MeshLambertMaterial({color: 0xdddddd, shading: THREE.FlatShading})
                # 灰色，非平滑
        new THREE.MeshLambertMaterial({color: 0xdddddd, shading: THREE.SmoothShading})
                # 灰色，平滑
        new THREE.MeshLambertMaterial({color: 0x666666, emissive: 0xff0000, ambient: 0x000000, shading: THREE.SmoothShading})
                # emissive表示自发光

    MeshPhongMaterial
        有明显高光区，适用于湿滑的，表面具有光泽的物体。如: 玻璃，水滴等
        特点
                会产生高光(球某一点在光线下特别亮)
        THREE.MeshPhongMaterial({ambient: 0x030303, color: 0xdddddd, specular: 0x009900, shininess: 30, shading: THREE.FloatShading})

        THREE.MeshPhongMaterial({ambient:0x030303, color:0xdddddd, specular: 0x009900, shininess: 30, shading: THREE.SmoothShading, map: texture, transparent: true})

        THREE.MeshPhongMaterial({color: 0x000000, specular: 0x666666, emissive: 0xff0000, ambient: 0x000000, shininess: 10, shading: THREE.SmoothShading, opacity: 0.9, transparent: true})
    MeshDepthMaterial
        支持一些尝试测试的效果
    MeshFaceMaterial
        面材质，它是一个材质数组。
        有且仅有一个成员数组materials, 用来存放一组材质。
                这组材质会被geometry的不同面所使用，来做到同一个物体不同面使用不同材质的效果。
                每一个面使用什么材质由geometry中的索引决定
    ShaderMaterial
        使用
                material = new THREE.ShaderMaterial({
                        uniforms: uniforms,
                                # 一致变量数组，传递到两个着色器中使用
                        vertexShader: document.getElementById('vertexShader').textContent,
                                # 顶点着色器的代码
                        fragmentShader: document.getElementById('fragmentShader').textContent
                                # 片元着色器代码
                });
                uniforms = {
                        time: {type: 'f', value: 1.0},
                                # 表示时间， f 代表浮点型
                        resolution: {type: 'v2', value: new THREE.Vector2() }
                                # 表示浏览器窗口的宽度和高度，v2代表二维向量
                }                # 该一致变量在绘制过程中不会改变，在顶点shader与片元shader之间用相同名字来共享
                                ## 一致变量在不同图元中会改变
                uniforms.resolution.value.x = window.innerWidth
                uniforms.time.value += 0.005
                                # 通过value改变uniforms中变量的值
#### texture
    例子
            var geometry = new THREE.PlaneGeometry( 500, 300, 1, 1 );
            geometry.vertices[0].uv = new THREE.Vector2(0,0);
            geometry.vertices[1].uv = new THREE.Vector2(2,0);
            geometry.vertices[2].uv = new THREE.Vector2(2,2);
            geometry.vertices[3].uv = new THREE.Vector2(0,2);
                                            # 平面有4个纹理坐标。由顶点的成员nv表示，nv是一个二维向量，对应到纹理坐标

            var texture = THREE.ImageUtils.loadTexture("textures/a.jpg",null,function(t){});
            var material = new THREE.MeshBasicMaterial({map:texture});

            var mesh = new THREE.Mesh( geometry,material );
            scene.add( mesh );

    例子2(canvas)
            var geometry = new THREE.CubeGeometry(150, 150, 150);
            texture = new THREE.Texture(canvas);
                                            # 默认情况下，纹理被均匀地分配到四边形的各个顶点上。
            var material = new THREE.MeshBasicMaterial({map: texture});
            texture.needsUpdate = true;
                                            # 如果canvas中有动画的话，要设置纹理更新。而且每requestAnimationFrame渲染一帧动画，都要对texture.needsUpdate设置一遍true。如果不更新，显示黑色正方体。
                                            ## 黑色正方体原因: js异步运行,canvas绘制时钟需要时间, three.js已经开始渲染图形了，这时候canvas没有绘制完成，就显示材质本身的颜色。
            mesh = new THREE.Mesh(geometry, material);
            scene.add(mesh);
    Mapping
        UVMapping
    Filter
        LinearFilter
    Wrapping
        RepeatWrapping
#### Color
    THREE.Color()
    THREE.Color( 0x444444 );       
#### Vector3
    THREE.Vecotor3(4,8,9);                                                                        
    THREE.Vector3();
    point1.set(4,8,9);
#### Quaternion
    介绍　
            四元组
    api
            THREE.Quaternion = function(x, y, z, w){
                    this._x = x || 0;
                    this._y = y || 0;
                    this._z = z || 0;
                    this._w = (w !== undefined) ? w : 1;
            }
            setFromAxisAngle: function(axis, angle)
                    # Quaternion的静态方法
                    ## axis是向量，表示轴, angle表示弧度
                    ## 返回一个四元组
            setFromEuler: function(euler, update)
                    # 欧拉角转为四元组
            setFromRotationMatrix: function(m)
                    # 把矩阵转为欧拉角
### fog
    scene.fog = new THREE.Fog(0x999999, 0.1, 8000);
    THREE.Fog = function(hex, near, far)
        # hex为颜色, near是雾开始的地方, far是雾结束的地方
### Object3D
    new THREE.Object3D();
### Ray
    介绍
            一条射线

    ray = new THREE.Ray(camera.position);
            # 传入起点
## particle
    particleSystem = new THREE.ParticleSystem(particles, material);

## 工具
### utils
    ImageUtils
        loadTextureCube(["", ""]);
    ShaderUtils
        var shader = lib["cube"]
    UniformsUtils
        clone(shader.uniforms)
    GeometryUtils
        merge = function(geometry1, object2/* mesh | geometry */){ ... }
            # geometry1是合成后的对象，第二个是要合并的对象，如果是mesh，就取mesh中的geometry对象
### filter
    LinearFilter
    NearestFilter
### effect
    BloomEffect
        postBloom = new BloomEffect(renderer, renderTarget, window.innerWidth, window.innerHeight, 4);
### helper
    o-> 辅助对象一键打开或关闭
            # 将所有辅助对象放到helps数组中
        var help = [];
        helps.push(helper);
        helps.push(faceNormalsHelper);
        helps.push(vertexNormalsHelper);

        window.addEventListener('keydown', onKeyDown, false);

        function setVisible(visible){
                for(var i = 0; i < helps.length; i++){
                        helps[i].visible = visible;
                }
        }

        function onKeyDown(event){
                switch(event.keyCode){
                        case 65: /*A*/
                                setVisible(false);
                                break;
                        case 83: /*S*/
                                setVisible(true);
                                break;
                }
        }
    GridHelper
        介绍
                网格辅助类, 绘制网格和网格线颜色

        api
                THREE.GridHelper = function(size, step)
                        # size定义网格正方形边长, step是间隔距离
        使用
                var helper = new THREE.GridHelper(200, 10);
                helper.setColors(0x0000ff, 0x808080);
                        # 第一个是x y z轴颜色, 第二个是其它线条颜色
                helper.position.y = -150;
                scene.add(helper);
    BoxHelper
        介绍
                长方体包围盒, 椭圆包围盒, 包围物体用于检查碰撞或辅助设计中表示选中

        使用
                var boxHelper = new THREE.BoxHelper(mesh);
                scene.add(boxHelper);
    FaceNormalsHelper
        介绍
                辅助画法线

        api
                FaceNormalsHelper(object, size, hex, linewidth)

        使用
                var faceNormalsHelper = new THREE.FaceNormalsHelper(mesh, 10)
    VertexNormalsHelper
        介绍
                辅助画顶点法线
    WireframeHelper
        介绍
                将模型转换为线框图
### 物件
    Mirror
        介绍
                模拟一个镜子, 放在那, 就反射它前面的景物
                原理是一个平面, 上面的材质不断变化

        o-> api
        THREE.Mirror = function(renderer, camera options)
                renderer是渲染器
                camera最好是透视相机
                options
                        textureWidth
                        textureHeight
                        clipBias
                        color
                        debugMode
        o-> 使用
        var planeGeo = new THREE.PlanneGeometry(100.1, 100.1);
                # 定义平面
        groundMirror = new THREE.Mirror(
                # 定义镜面
                renderer,
                camera,
                {clipBias: 0.003,
                textureWidth: WIDTH,
                textureHeight: HEIGHT,
                        # 表示内存中生成纹理的大小, 最好和屏幕一样大, 否则有mosaic
                debugMode: true}
                        # 开启调试模式会有辅助线
        );

### AnimationHandler
    介绍
            主要负责动画的插值和播放
### shader
    EffectComposer
        介绍
                用于渲染复杂效果, 例如将一个场景作为纹理传入, 例如用着色器将场景某部分模糊或发光处理
                原理是将画面在一个临时缓冲区先画出来,再将大量效果组合. 一般是用着色器来实现

        使用
                composer = new THREE.EffectComposer(render);
                        # 可以是WEBGLRenderer或CanvasRenderer
                        ## 第二个参数是renderTarget(渲染目标), 没有时默认生成一个
                        ### renderTarget是gpu的内部对象,用来暂存绘制结果
                composer.addPass(new THREE.RenderPass(scene, camera));
                        # 第一个效果通常是RenderPass, 它将渲染结果放入效果链中
                        ## 将结果渲染到gpu的一个帧缓冲区(临时内存)
                        ## pass中有enable成员变量, 只有为true时该pass才起作用
                var effect = new THREE.ShaderPass(THREE.DotScreenShader);
                        # DotScreenShader是examples/js/shaders中的一个
                        ## 它定义了一些一致变量, 每个帧循环操作它们来控制渲染效果
                effect.uniforms['scale'].value = 4;
                composer.addPass(effect);
                var effect = new THREE.ShaderPass(THREE.RGBShiftShader);
                effect.uniforms['amount'].value = 0.0015;
                effect.renderToScreen = true;
                composer.addPass(effect);
                        # 通过addPass加效果到效果链passes中
                        ## 添加顺序重要,后一个效果会作用于前一个效果
                composer.render()
                        # 用它替换render.render(scene, camera)
                        ## 遍历所有通道, 可以传入参数delta, 表示帧与帧之间渡过的时间
        api
            方法
                    insertPass(pass, index)
                            # 将某一个通道插入指定的位置
                    
            对象
                    WebGLRenderTarget(width, height, options)
                            # width是缓冲区的宽度, height是缓冲区的高度, options是参数
                    RenderPass(scene, camera, overrideMaterial, clearColor, clearAlpha)
                            # overrideMaterial表示一种材质, 它会覆盖先前设置的材质
                            # clearColor表示每一次帧缓冲绘制前的底色. 用于清除上一次绘制结果
                            # clearAlpha是0或1, 表示清除透明色
                            ## this.enabled属性表示是否启用该pass
                            方法
                                    render(renderer, writeBuffer, readBuffer, delta)
                    DotScreenShader
                            # 点阵屏效果, 就是报纸中点阵的印刷效果
                    RGBShiftShader
                            # 变化颜色分量RGBA, 如A点的R值不显示, 而取B点的R值
                            ## angle表示偏移角度
                            ## amount表示AB的长度. 由于纹理坐标为0到1, 所以0.005会有很多像素
                    BloomPass(n)
                            # 像素点膨胀模糊, 像墨水渗出
                            # n 是模糊的程度
                    FilmPass(noiseIntensity, scanlinesIntensity, scanlinesCount, grayscale)
                            # 依赖FilmShader.js. 整个场景灰白, 或像lcd荧光屏在屏幕上看到线条等屏幕效果
                            ## noiseIntensity 表示杂点的密度, 值越大杂点越多
                            ## scanlinesIntensity 是扫描线的密度, 值越大扫描线透明度越小
                            ## scanlinesCount 扫描线的数量
                            ## grayscale 如果true表示黑白显示
                            var effectFilm = new THREE.FilmPass(0.35, 0.75, 2048, false);
                            effectFilm.renderToScreen = true;
                            composer.addPass(effectFilm);
### projector
    介绍
            包含各种矩阵
            提供重要且简单的函数，进行二维和三维之间的转换

    函数
            this.unprojectVector = function(vector, camera)
                    # 归一化空间中的点
                    ## 归一化是将(-1, -1, -1)到(1, 1, 1)中的某个点还原成三维中的某个点
                    # vector是需要归一化的那个点，要归一化成(-1, -1)到(1, 1)空间的点
                    ## z 是没有意义的，通常设置为1
                    # camera是当前相机，有了相机才能计算当前投影。
## 扩展
### 性能
#### stats.js
    官网
            https://github.com/mrdoob/stats.js 
    视图                        # 点击切换
            fps                # 上一秒的帧数
            ms                # 一帧的毫秒数
    使用
            引入stats.js文件
            init中
                    var stats = new Stats();
                    stats.setMode(1); // 0: fps, 1: ms
                    // 将stats的界面对应左上角
                    stats.domElement.style.position = 'absolute';
                    stats.domElement.style.left = '0px';
                    stats.domElement.style.top = '0px';
                    document.body.appendChild( stats.domElement );
            treeStart中
                    setInterval( function () {
                        stats.begin();
                        // 你的每一帧的代码
                        stats.end();
                    }, 1000 / 60 );
            
            或
            init中
                    stats = new Stats();
                    stats.domElement.style.position = 'absolute';
                    stats.domElement.style.left = '0px';
                    stats.domElement.style.top = '0px';
            animation中
                    stats.update();
### 动画引擎
#### tween.js
    官网
            https://github.com/sole
    介绍
            开源的缓动类
    使用
            引入tween.js
            
            initObject之后调用
                    function initTween()
                    {
                        new TWEEN.Tween( mesh.position)
                                .to( { x: -400 }, 3000 ).repeat( Infinity ).start();
                    }
            animation中
                    requestAnimationFrame(animation);
                        TWEEN.update();
    使用2(雾的far的缓动)
            scene.tween = new TWEEN.Tween(scene.fog, false)
                    # 对scene.fog的属性进行操作
                    .to({far: 1500}, 6000)
                            # 在6秒种内将scene.fog.far变为1500
                    .easing(TWEEN.Easing.Sinusoidal.EaseOut)
                    .delay(6000)
                            # 缓动在调用start()后，等待6秒执行
                    .onComplete(function(){
                            # 缓动执行完成后(far= 1500后)的回调函数
                    }).start();
            
            scene.tweenBack = new TWEEN.Tween(scene.fog, false)
                    .delay(2000)
                    .to({far: 15000}, 10000)
                    .easing(TWEEN.Easing.Sinusoidal.EaseOut);

            scene.tween.chain(scene.tweenBack);

    使用3(相机的左右[-500, 500]摇动)
                    # 缓动链
            camera.tween = new TWEEN.Tween(camera.position, false)
                    .to({x: 500}, 6000)
                    .easing(TWEEN.Easing.Sinusoidal.EaseInOut)
                    .start();

            camera.tweenBack = new TWEEN.Tween(camera.position, false)
                    .easing(TWEEN.Easing.Sinusoidal.EaseInOut)
                    .to({x: -500}, 6000)

            camera.tween.chain(camera.tweenBack);
            camera.tweenBack.chain(camera.tween);
                    # 两个动画彼此加入了自己的缓动链中，两个动画可以交替执行
    TWEEN.Easing
        TWEEN.Easing.Sinusoidal.EaseOut
                # Sinusoidal是正弦曲线的缓动
### Loader
    VTKLoader
        var loader = new THREE.VTKLoader();
        loader.addEventListener('load', function(event){
                var geometry = event.content;
                var mesh = new THREE.Mesh(geometry, material);
                mesh.position.setY( - 0.09);
                scene.add(mesh);
        });
        loader.load("models/vtk/bunny.vtk");
    JSONLoader
        THREE.JSONLoader.prototype.load = functiono(url, callback, texturePath)
            # url是json文件的地址
            # callback在异步加载完后执行
            # texturePath 纹理路径，没有这个参数时，在当前路径下寻找默认纹理。
    BinaryLoader
        使用
                var loader = new THREE.BinaryLoader(true);
                document.body.appendChild(loader.statusDomElement);
                        # 实时显示加载进度

        THREE.BinaryLoader = function(showStatus){
                THREE.Loader.call(this, showStatus);
                        # showStatus表示是否显示进度条
        }
        THREE.BinaryLoader.prototype.load = function(url, callback, texturePath, binaryPath)
                # url是js文件的路径
                # callback 当url中数据加载完成后调用。callback中接收geometry作为参数
                # texturePath 纹理路径，不指定默认放在url同文件夹下，或无纹理。
                # binaryPath 二进制文件的路径，不指定时，根据url地址中的文件来加载。

    ColladaLoader
    UTF8Loader
        介绍
                导入 google WebGL-Loader格式的高压缩文件
    SceneLoader
        介绍
                导入各物体、变换层级、材质、纹理、相机、光源的统一js文件，其中有其它js的url引用
### Controls
    见Camara
### Detector
    if(! Detector.webgl) Detector.addGetWebGLMessage();

# 命令
    convert_obj_three.py
        介绍
                转换obj文件为three.js二进制文件

        python convert_boj_three.py -i alien2.obj -o alien2_bin.js -t binary

# 着色器
    介绍
            一种二进制码，在绘制场景之前做一些事。操作在显卡中进行
            对每一个顶点或者片元执行一次着色器，这个操作并行执行
            浏览器底层只支持着色器
            three.js底层是着色器实现的，所以着色器能实现一些three.js无法实现的功能，并能提高three.js的性能
    优势与性能
            1. 处理大量数据能力。顶点着色器为每一个顶点确定位置，片元着色器为每个片元确定颜色，数据量非常庞大
                    # 一个3d游戏中，一帧几十万个三角形。显示器分辨率1280x1024, 有1310720个像素，每一帧由片元着色器处理。
                    ## 每个顶点位置与每个片元颜色几乎同时计算完成
    webgl着色器分类
            # 无论在opengl, openes, dx中，都分为顶点着色器和片元着色器
            顶点着色器
                    对顶点进行操作，如
                                    改变顶点的位置和大小
            片元着色器
                    定义屏幕中各点的颜色
                    顶点之间的颜色也被一起处理了(插值)
## 顶点着色器
    介绍
            接收三维点坐标，处理为二维坐标并输出
            THREE.ShaderMaterial用来定义着色器，着色器材质用着色器程序去控制几何体的顶点和颜色
    内置变量
            gl_Position
    three.js注入变量
            postion
                    # gl_Position = vec4(position, 1.0);
            uv
    使用
            <script id="vertexShader" type="x-shader/x-vertex">
                    # type只是通用标记为顶点着色器, 不起作用
                    void main(){
                            # 类似c语言, 着色器有一个main函数
                            ## 每个顶点在计算时，都会执行main函数
                            gl_Position = vec4(position, 1.0);
                                    # 将计算顶点最终位置的结果放在gl_Position中
                                    ## 这个位置被称为设备归一化坐标
                                    ## gl_Position是默认变量，不必声明就可用，gl_Position一定要赋值
                                    ## 顶点着色器最主要作用就是给gl_Position赋值
                                    # 作用:
                                    ## gl_Position 是相机投影之后的坐标
                                    ## 顶点的位置传给position, 通过我们变换, 再赋值给gl_Position
                                    ## position中的值来源如mesh.vertices.push(new THREE.Vector3(x, -y, 0))
                    }
            </script>
    例子
        void main(){
                gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }                # projectionMatrix是投影矩阵，modelViewMatrix是模型视图矩阵
## 片元着色器
    介绍
            一个片元对应一个像素，对其输出一个颜色值。
                    # 将顶点着色器输出的二维点坐标转化为待处理的像素并传递给片元着色器的过程，称为图元光栅化
            颜色会受到光照, 阴影等影响, 所以片元着色器大多处理这些物理效果

    内置变量
            gl_FragColor
                    #  输出的一个像素的颜色, vec4类型, 红 绿 蓝 透明
            gl_FragCoord
                    #只读变量,保存了片元相对窗口的坐标位置
                    ## x, y, z, 1/w   其中z表示片元深度, z越大越深

    输入
            varying0, varying1, .... , varyingn
                    #用户自定义的易变变量
            uniforms
                    # 一致变量. 在js, 顶点着色器, 片元着色器中传递数据, 一次渲染中数据不变
            临时变量

            gl_Position
                    # 当前片段(像素)的位置
            gl_FrontFacing
                    # 表示每个顶点的大小
            gl_PointSize
                    # 当前片段来自三角形的正面还是背面. 该变量只是为了节省性能
            采样器

    使用
            <script id="fragmentShader" type="x-shader/x-fragment">
                    void main(){
                            gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
                                    ＃ 表示片元颜色，是RGBA
                    }
            </script>
    例子
        uniform vec2 resolution;
        uniform float time;
        float a = 1.0, b = 1.0, c = 1.0;
        float t;
        void main (){
                t = time;
                a = abs(sin(t));
                b = abs(cos(t));
                c = abs(sin(t) * cos(t));
                gl_FragColor = vec4(vec3(a, b, c), 1.0);
        }
## 变量
    变量分类
            attributes(属性变量)                        # 保存顶点独有数据，如顶点的位置
                    attributes vec3 pos;
            uniform(一致变量)                                # 一帧渲染过程中保持不变，如光照方向
                    uniform vec3 a;
            varying(易变变量)                                # 比较容易变化的变量，用来在顶点着色器与片元着色器之间传递数据
                    varying vec3 a;
    类型
            vec2
                    # 二维变量
            vec3
                    # 三维变量
            vec4
            mat4
            sampler2D
            float
    传递关系
            attribute        ->        顶点着色器        ->        varying        ->        图元光栅化        ->        varying        ->        片元着色器        ->        gl_FragColor
            uniform        ->        顶点着色器        ->        gl_Position        ->        图元光栅化        ->        gl_Position        ->        片元着色器        ->        gl_FragColor

# 思路
## animate动画
    window.requestAnimationFrame(callback)
            # 返回id, 传给window.cancelAnimationFrame()取消该次动画
            ## 原理
            ### 传递浏览器回调函数，浏览器调用它更新画面。
            #### 与setInterval()不同之处在于自动控制了时间。对方法调用进行了优化。页面失去选中时动画自动暂停。
            ### 回调函数中　调用了requestAnimation(callback)来循环调用
            ### 通常执行callback函数来开始动画
            # 最原始的是window.setTimout()或者window.setInterval()来更新元素的位置
            ## 更新频率要达到每秒60次
    animation
        function threeStart() {
                    initThree();
                    initCamera();
                    initScene();
                    initLight();
                    initObject();
                    animation();

                }
        function animation() {
                    //rend＋                                                                                                                                                                                                                erer.clear();
                    camera.position.x = camera.position.x + 1;
                    renderer.render(scene, camera);
                    requestAnimationFrame(animation);
                }
        或
        function animation()
                    {
                        mesh.position.x-=1;
                        renderer.render(scene, camera);
                        requestAnimationFrame(animation);
                    }
    render
        function animate(){
                for(var i = 0; i < apps.length; ++i){
                        apps[i].animate();
                }
                requestAnimationFrame(animate);
        }
        function App(...){
                this.animate = function(){
                        render();
                        stats.update();
                }
                function render(){
                        camera.position.x += (mouseX - camera.position.x) * 0.05;
                        camera.position.y += (-mouseY - camera.position.y) * 0.05;
                                # 相机位置随鼠标移动
                                ## mouseX, mouseY为自定义的全局变量
                        camera.lookAt(scene.postion);
                        renderer.render(scene, camera);
                }
        }
    render计算
        var mouseX = 0, mouseY = 0;
        document.addEventListener('mousemove', onDocumentMouseMove, false);
        function onDocumentMouseMove(event){
                mouseX = (event.clientX - windowHalfX);
                mouseY = (event.clientY - windowHalfY);
        }
    相机旋转
        围绕y轴, 半径1000的圆作圆周运动。
                var timer = 0.0001 * Date.now();
                        # 用当前时间作弧度
                camera.position.x = Math.cos(timer) * 1000;
                camera.position.z = Math.sin(timer) * 1000;
                camera.lookAt(scene.position);
    自发光变化
        material.emissive.setHSV(0.54, 1, 0.7 * (0.5 + 0.5 * Math.sin(35 * timer)));
    引擎
        组成
                定义与初始化相机
                定义与初始化场景
                定义与初始化光
                定义与初始化渲染器
                定义与初始化性能监视器
                定义鼠标事件, 窗口缩放事件
                        ele.addEventListener('mousedown', ...)
                        ele.addEventListener('mouseup', ...)
                        ele.addEventListener('mousemove', ...)
                        window.addEventListener('resize', ...)
                播放音乐
## 结构
    定义App类
        App类将相机，视图，灯光等场景代码封装，为了场景的代码的重用
                # 场景重新new
        例子1, 视口app
                function App( containerId, fullWidth, fullHeight, viewX, viewY, viewWidth, viewHeight )
    对象池
        介绍
                用过的对象保存起来，下次需要时重复使用。
                减少频繁创建对象所造成的内存开销和cpu开销
        自定义ObjectPool.js
                function ObjectPool(){
                        this.pool = new Array();
                        this.avail = new Array();
                                # 可用在pool中的索引，pool中对象不在使用，待再利用时放入avail中
                }
                ObjectPool.prototype.createObject = function(){
                        return new Object();
                }
                        #  创建一个多态的对象(如一个豆径)，需要重载,
                ObjectPool.prototype.returnObject = function(poolId){
                        this.avail.push(poolId);
                }
                        # 标记为可再利用
                ObjectPool.prototype.getObject = function(){
                        if(this.avail.length ==0){
                                var o = this.createObject();
                                o.poolId = this.pool.length;
                                this.pool.push(o);
                                this.avail.push(o.poolId);
                        }
                        var poolId = this.avail.pop();
                        return this.pool[poolId];
                }
## 控制
    resize
        window.addEventListener( 'resize', onWindowResize, false );

        function onWindowResize( event ) {
                SCREEN_WIDTH = window.innerWidth;
                SCREEN_HEIGHT = window.innerHeight;

                renderer.setSize( SCREEN_WIDTH, SCREEN_HEIGHT );
                camera.aspect = 0.5 * SCREEN_WIDTH / SCREEN_HEIGHT;
                camera.updateProjectionMatrix();
                        # 产生透视投影矩阵
        }
    鼠标射线
        mouse = new THREE.Vector3(0, 0, 1);
        projector = new THREE.Projector();
        ray = new THREE.Ray(camera.position);

        function onDocumentMouseMove(event){
                mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
                mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
                        # 取得鼠标的位置，并将其转换为-1到1之间(归一化)
                ray.direction = projector.unprojectVector(mouse.clone(), camera);
                        # 得到当前鼠标指向二维的点在程序三维中的位置
                ray.direction.subSelf(camera.position).normalize();
                        # 鼠标所在的点送去相机所在的点，得到相机指向鼠标所在点的向量并规范化
                intersects = ray.intersectObject(plane);
                        # 计算射线与模型的相交点数组
        }
## 场景
    天空盒
        两种实现
                立方体内部贴纹理
                椭球内部贴纹理
        立方体天空盒
                var r = 'textures/cube/Bridge2';
                var urls = [r + 'posx.jpg', r + 'negx.jpg', r + 'posy.jpg', r + 'negy.jpg', r + 'posz.jpg', r + 'negz.jpg'];
                var textureCube = THREE.ImageUtils.loadTextureCube(urls);
                textureCube.format = THREE.RGBFormat;
                        # 设置图片格式，此格式不需要透明度。节约内存又加快渲染速度
                var shader = THREE.ShaderLib['cube'];
                        # ShaderLib与three.js引擎的一个数组, 其中的cube存放的是立方体贴图的shader
                shader.uniforms['tCube'].value = textureCube;
                        # 纹理给shader着色器
                var material = new THREE.ShaderMaterial({
                        fragmentShader: shader.fragmentShader,
                        vertexShader: shader.vertexShader,
                        uniforms: shader.uniforms,
                        depthWrite: false,
                        side: THREE.BackSide
                });        # 用ShaderMaterial材质包装shader
                mesh = new THREE.Mesh(new THREE.CubeGeometry(100, 100, 100), 22, material);
                sceneCube.add(mesh);
## 性能
    概要
            3d设计的精髓在于性能优化
            使用连续内存(如数组)将加速程序运行，不连续内存将增加读取时寻址的时间。
    使用
        $(document).ready(
                function(){
                        var container = document.getElementById("container");
                        var app = new MineCraftApp();
                        app.init({container: container});
                                # container属性 表示最后渲染结果外层的div
                        app.run();
                }
        );
    App
        介绍
                封装了three.js的一些基本操作, 如
                        创建渲染场景
                        创建相机
                        控制画布缩放
                        鼠标输入
                对three.js进行了面向对象的封装，可以面向对象编程
        函数
                prototype.init(param)
                        # 初始化
                        ## 参数是一个键值对对象
                        ## 一个WebGLRenderer渲染器
                        ## 一个场景 THREE.Scene()
                        ## 一个透视投影 THREE.PerspectiveCamera
                        ## 一个投影器 THREE.Projector()
                        ## 一些鼠标键盘的操作
                prototype.run = function(){
                        # 是渲染循环，会不断被调用
                        ## 调用每一个Sim.Object的update
                        this.update();
                        this.renderer.render(this.scene, this.camera);
                        var that = this;
                        requestAnimationFrame(function(){that.run(); });
                                # run的帧循环
                }
                        
                prototype.addObject
                        # 将Sim.Object对象加入场景中
                prototype.removeObject
                        # 将Sim.Object对象从场景移出

        属性
                renderer
                scene
                camera
                objects
                        # 场景中的所有可视对象
    Publisher
        介绍
                一个事件驱动模型
                Sim.Publisher用于
                        记录事件
                        发送事件
                        处理事件
                当事件发生时，它遍历注册的回调列表，调用每一个注册的函数
        函数
                prototype.subscribe = function(message, subscriber, callback)
                        # 发起订阅
                        ## message表示事件名
                        ## 放callback函数的类
                        ## 事件发生时的执行回调函数
                prototype.unsubscribe = function(message, subscriber, callback)
                        # 取消订阅, 删除MessageTypes数组中事件名对就的链表中的一节点
                        ## message值为null, false, undefined时表示删除整个链表(不删除事件)
                prototype.publish = function(message)
                        # 触发事件
        属性
                MessageTypes
                        # 事件与其处理函数的集合
                        ## 形如 messageType['remove'] = [subscriber, callback] -> [subscriber, callback]
                        ### 'remove'是事件名, subscriber是订阅者, callback是订阅者该事件的回调方法
                        ### -> 是链表的意思
    Object
        介绍
                sim.js所有封装类的基类, 派生于Sim.Publisher
                可以表示大多数对象(自定义的对象派生于它)
        方法
                prototype.setPosition
                        # 设置object3D对象的位置
                prototype.setScale
                prototype.setVisible
                prototype.update
                        # 更新该对象和它的children
                        ## 在每一次渲染循环时调用,用来产生自己的动画
                prototype.addChild
                        # 添加子对象, 如汽车添加轮子
                prototype.removeChild
        属性
                object3D
                        # 用于保存three.js中的Object3D对象
                children


# 框架
## sim
    介绍
        封装three.js大量重复工作
                如设置渲染器，循环重绘，向场景添加Mesh等

## physi.js
    介绍
            基于three.js上构建的物理引擎
## voxel.js
    介绍
            像素方块游戏开发(minecraft)
# 例子(来自webgl中文网)
## 16万个三角形
    定义
            o-> triangles = 160000
            o-> 每个三角形有３个顶点, 一个顶点三个float表示，共triangles * 3 * 3个float
                    # 用数组存放
            o-> 每个顶点一个法向量，一个三角形３个法向量

    赋值
            o-> 所有三角形顶点应该在一个以原点为中心的正方体内
            o-> 三角形的位置在正方体内随机分布
    实现
            var geometry = new THREE.BufferGeometry();
            geometry.attributes = {
                            index:{
                                    itemSize: 1,
                                    array: new Uint16Array(triangles * 3),
                                    numItems: triangles * 3
                            },
                                    # 索引
                                    ## 每一个数组元素的聚会范围是[0, 65535],如果顶点数超过65535,必须通过geometry的offset成员来进一步设置偏移量。
                                    ### 65535是16位整型
                            position: {
                                    itemSize: 3,
                                    array: new Float32Array(triangles * 3 * 3),
                                    numItems: triangles * 3 * 3
                            },
                                    # 位置
                            normal:{
                                    itemSize: 3,
                                    array: new Float32Array(triangle * 3 * 3),
                                    numItems: triangles * 3 * 3
                            },
                                    # 法线
                            color: {
                                    itemSize: 3,
                                            # 一项目(元)由几个字节组成
                                    array: new Float32Array(triangles * 3 * 3),
                                            # 实际存项目的内存数组
                                    numItems: triangles * 3 * 3
                                            # 有多少个项目
                            }
                                    # 颜色
                    }
                            # Uint16Array分配指定个数的16位无符号整数，寝值为0
                            ##  如果内存紧张，无法分配时则引发异常
                            ## api uint16Array = new Uint16Array(length);
                            ### uint16Array = new Uint16Array(array);
                            # 位置，用Vector3来表示，共有triangles * 3个Vector3
                            ## 每个Vector3有x, y, z三个分量组成, 所以顶点需要triangles * 3 * 3个浮点数表示。
                            # 法线, 一个点对应一个法线, 由x, y, z三个float组成，所以需要triangles    * 3 * 3个float
                            # 颜色, 每个顶点一种颜色，颜色由R, G, B组成，所以需要triangles * 3 * 3个float
                    var n = 800, n2 = n/2;
                            # n是正方体的边长
                    # 为三角形顶点赋随机值，后计算每个顶点的法向量
                    ## positions数组每隔9个是一个三角形
                    ## normals数组每隔9个是一个三角形
                    # 随机生成颜色，赋给顶点
                    ## colors数组每隔9个是一个三角形

                    # 给geometry设置索引和偏移量
                    ## 索引对应到点，所以有triangles * 3个
                    ### 索引从0开始

                    # 将BufferGeometry和材质组成mesh
## 人物粒子
    生成粒子
            var vertices = geometry.vertices;
            var mesh = new THREE.ParticleSystem(geometry, new THREE.ParticleBasicMaterial({size: 3, color: c}));
            mesh.scale.x = mesh.scale.y = mesh.scale.z = scale;
            mesh.position.x = mesh.position.y = mesh.position.z = position;
    渲染
            render()
            mesh.geometry.verticesNeedUpdate = true;
                    # 如果不刷新，渲染出来的顶点位置不会改变
            renderer.clear();
            composer.render(0.01);
                    # composer为THREE.EffectComposer, 效果组合器
## 多视口
    viewport
    注意
            视口的坐标为归一化的坐标。左上角是(0, 0), 右下角是(1, 1)
    阴影贴图
        canvas画阴影
        阴影纹理
                var shadowTexture= new THREE.Texture(canvas);
                shadowTexture.needsUpdate = true;
                        # 表示纹理是新纹理，在绘制的时候，需要更新到材质上
                var shadowMaterial = new THREE.MeshBasicMaterial({map:shadowTexture});
    平面和线框同时显示
        材质wireframe属性只有true和false,所以要创建2个不同材质的相同物体

        THREE.SceneUtils.createMultiMaterialObject(geometry, materials)
                # 传递一个几何体和材质数组，几何体每一个材质组合成一个Mesh, 将Mesh加入组group对象中，返回组对象。
## 杰克与豆径
    主要内容
            天空盒
            生长效果
                    树叶的生长
                    树干变形
                    音乐渲染控制生长
            对象池
    设计
            鼠标操作
            植物模型
                    plant
                            豆干，豆径(leaf3.js)，豆叶(leaf5.js)
                            豆径豆叶的材质
            植物生长
            阴天、晴天
                    天空材质

            相机动画
    音乐
        <audio id="audio" preload="auto" loop>
                        # 预加载音乐并循环播放
                <source src="a.mp3" type="audio/mpeg">
        </audio>

        <script>
                audio = document.getElementById('audio');
                audio.play();
        </script>
## 流动立方体
    设计
            从相机到鼠标发射射线, 与射线相交的点，就是选中物体的某个点
## 我的世界
    MineCraftApp = function(){
            Sim.App.call(this);
    }
    MineCraftApp.prototype = new Sim.App();

    MineCraftApp.prototype.init = function(param){
            Sim.App.prototype.init.call(this, param);
                    # 调用父类的init函数，在父类中初始化相机, 场景等类
            # 性能监视器
            # 天空盒
            # 相机控制类
            # 场景中的一个个小物体
    }
    $(document).ready(
            function(){
                    var container = document.getElementById("container");
                    var app = new MineCraftApp();
                    app.init({container: container});
                            # container属性 表示最后渲染结果外层的div
                    app.run();
            }
    );
## 汽车换装
    设计
            汽车类
                    更换s汽车模型
                    更换汽车各部分颜色
            两个相机
            两个场景
            三种光源
            天空盒
            渲染器
            效率监听器
            初始化各种材质
    汽车类
            veyron: {
                    name: '布加迪威龙',
                    url: 'obj/veyron/VeyronNoUv_bin.js',
                    author: '布加迪威龙',
                    init_rotation: [0, 0, 0],
                    scale: 5.5,
                    init_materials: 4,
                    body_materials: [2],
                    object: null,
                    buttons: null,
                    materials: null
            }
## 分形
    uniforms = {
            scale: {type: 'v2', value: new THREE.Vector2()},
            c: {type: 'v2', value: new THREE.Vector2()}
    }
    material = new THREE.ShaderMaterial({
            uniforms: uniforms,
            vertexShader: document.getElementById('vertexShader').textContent,
            fragmentShader: document.getElementById('fragmentShader').textContent
    });
    mesh = new THREE.Mesh(new THREE.PlaneGeometry(2.0, 2.0), material);
            # 用 2 * 2 的平面来覆盖浏览器窗口
    function onWidowResize(event){
            renderer.setSize(window.innerWidth, window.innerHeight);
            uniforms.scale.value.x = window.innerWidth / 2;
            uniforms.scale.value.y = window.innerHeight;
    }

    o-> 片元着色器中代码 
    uniform vec2 c;
    uniform vec2 scale;
    void main(void){
            float R = (gl_FragCoord.x - scale.x) / scale.y;
            float I = (gl_FragCoord.y - scale.x) / scale.y;
            float R2 = R * R, I2 = I * I;
            int mm;
            for(int m =0; m < 255; m++){
                    I = (R + R) * I + c.y; R = R2 - I2 + c.x; R2 = R * R; I2 = I * I; mm = m;
                    if(abs((I2) / (I + R)) > 10.) break;
            }
            if(mm == 254) gl_FragColor = vec4(0., 0., 0., 1.);
            else{
                    float a = float(mm);
                    a = mod(a, 15.) / 5.;
                    gl_FragColor = vec4(max(0., abs(a - 1.5) - .5)),
                            max(0., 1. - abs(a - 1.)),
                            max(0., 1. - abs(a - 2.)),
                            1.);
            }
    }
## 镜像分形
    介绍
            镜面反射场景

    var mirrorMesh = new THREE.Mesh(planeGeo, groundMirror.material);
            # groundMirror.material是THREE.Mirror中定义的材质. 会在每次update(或者render)过程中变化
            ## groundMirror.updateTextureMatrix()
            ## groundMirror.render() 要在update或render前重新渲染镜子的纹理.
            ### 多面镜子时, 如上一个个更新会有干扰, 要用下面代码更新
            ### groundMirror.renderWithMirror(verticalMirror);
            ### verticalMirror.renderWithMirror(groundMirror);
    mirrorMesh.add(groundMirror);
    mirrorMesh.rotateX(-Math.PI / 2);
    scene.add(mirrorMesh);

    THREE.ShaderLib['mirror'] = {
            uniforms: {
                    mirrorColor: {
                            type: 'c',
                            value: new THREE.Color(0x7F7F7F)
                    },
                    mirrorSampler: {type: 't', value: null},
                    textureMatrix: {type: 'm4', value: new THREE.Matrix4()}
            },
            vertexShader: [
                    'uniform mat4 textureMatrix;',
                    'varying vec4 mirrorCoord;',
                    'void main() {',
                            'vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);',
                            'vec4 worldPosition = modelMatrix * vec4(position, 1.0);',
                            'mirrorCoord = textureMatrix * worldPosition;',
                            'gl_Position = projectionMatrix * mvPosition;',
                    '}'
            ].join(''\n),
            fragmentShader: [
                    'uniform vec3 mirrorColor;',
                    'uniform sampler2D mirrorSampler;',
                    'varying vec4 mirrorCoord;',
                    'float blendOverlay(float base, float blend){',
                            'return (base < 0.5 ? (2.0 * base * blend) : (1.0 - 2.0 * (1.0 - base) * (1.0 - blend)));',
                    '}',
                    'void main(){',
                            'vec4 color = texture2DProj(mirrorSampler, mirrorCoord);',
                            'color = vec4(blendOverlay(mirrorColor.r, color.r), blendOverlay(mirrorColor.g, color.g), blendOverlay(mirrorColor.b, mirrorColor.b), 1.0);',
                            'gl_FragColor = color;',
                    '}'
            ].join('\n')
    };

## 文字
    介绍
        原理: 每个要显示的文字生成mesh
## 小地图
    介绍
            实现方式1, 在天空直接用正投影相机
                    # 实现简单,但渲染效果差,占很多cpu时间(重新绘制一次整个场景)
            实现方式2, 用正投影相机, 但用画大地图的数据来绘制
                    # 小地图渲染用很少时间, 因为复杂模型都用小方块或图片代替了

    o-> 实现
            camera.lookAt(scene.position);
            camera2.lookA(scene.position);

            renderer2 = new THREE.CanvasRenderer();
                    # 两个WebGLRenderer位置重叠时,会渲染不正常(其中一个全黑)
            renderer2.setSize(200, 150);

            renderer.render(scene, camera);
            renderer2.render(scene, camera2);
                    