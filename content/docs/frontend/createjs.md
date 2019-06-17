---
Categories : ["前端"]
title: "Createjs"
date: 2018-10-11T07:56:33+08:00
---

# easeljs
    介绍
            处理canvas
    使用
            var stage = new createjs.Stage("canvasName");
            stage.x = 100;
            stage.y = 100;
            var text = new createjs.Text("Hello", "36px Arial", "#777");
            stage.addChild(text);
            stage.update();
# tweenjs
    介绍
            处理动画调整和js属性
    使用
            var circle = new createjs.Shape();
            circle.graphics.beginFill("#FF0000").drawCircle(0, 0, 50);
            stage.addChild(circle);
            createjs.Tween.get(circle, {loop: true})
                    .wait(1000)
                    .to({scaleX: 0.2, scaleY: 0.2})
                    .wait(1000)
                    .to({scaleX:1, scaleY:1}, 1000, createjs.Ease.bounceInOut)
            createjs.Ticker.setFPS(20);
            createjs.Ticker.addEventListener("tick", stage);
# soundjs
    介绍
        简化处理音频
    使用
        var displayStatus;
        displayStatus = document.getElementById("status");
        var src = "1.mp3";
        createjs.Sound.alternateExtensions = ["mp3"];
        createjs.Sound.addEventListener("fileload", playSound());
        createjs.Sound.registerSound(src);
        displayStatus.innerHTML = "Waiting for load to complete";

        function playSound(event){
                soundIntance = createjs.Sound.play(event.src);
                displayStatus.innerHTML = "Playing source: " + event.src;
        }

# preloadjs
    介绍
            协调程序加载项的类库
    使用
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
