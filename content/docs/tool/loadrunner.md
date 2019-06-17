---
Categories: ["工具"]
title: "LoadRunner"
date: 2018-10-11T18:42:40+08:00
---

# 脚本参数
    get
        web_url("login", 
            "URL=http://192.168.0.14:9081/ryx-login/sso/login", 
            "Resource=0", 
            "RecContentType=text/html", 
            "Referer=", 
            "Snapshot=t1.inf", 
            "Mode=HTML", 
            EXTRARES, 
            "Url=../ycls/img/banner1.jpg", ENDITEM, 
            "Url=../ycls/img/banner2.jpg", ENDITEM, 
            "Url=../ycls/img/banner3.jpg", ENDITEM, 
            "Url=../ycls/img/userinput.png", ENDITEM, 
            "Url=../ycls/img/sawtooth.png", ENDITEM, 
            "Url=../ycls/img/tip2.png", ENDITEM, 
            "Url=../ycls/img/pwdinput.png", ENDITEM, 
            "Url=../ycls/img/login_back.png", ENDITEM, 
            "Url=../ycls/img/tip1.png", ENDITEM, 
            "Url=../ycls/img/codeinput.png", ENDITEM, 
            "Url=../ycls/img/loading-small2.gif", ENDITEM, 
            "Url=/favicon.ico", "Referer=", ENDITEM, 
            LAST);

    post参数
        web_submit_data("getActivityParameter",
            "Action=http://192.168.0.14:9081/tobacco/retail/lottery/getActivityParameter?jsonp=jQuery19109862107675272699_1401335732777",
            "Method=POST",
            "RecContentType=text/html",
            "Referer=http://192.168.0.14:9081/tobacco/retail/index;jsessionid=7BBAFC6DE481FBCB1CB88D738BD7EE71",
            "Snapshot=t6.inf",
            "Mode=HTML",
            ITEMDATA,
            "Name=requestType", "Value=ajax", ENDITEM,
            LAST);

    post直接传数据
        web_custom_request("dataservice",
            "URL=http://202.110.222.207:7080/rtserver/rest/resource/tobacco/dataservice",
            "Method=POST",
            "Resource=0",
            "RecContentType=text/plain",
            "Referer=",
            "Snapshot=t1.inf",
            "Mode=HTML",
            "Body= {\"trans_code\":\"1006\",\"end_date\":\"20140701\",\"source\":\"appkey\",\"data\":\"eyJiZWdpbl9kYXRlIjoiMjAxNDA2MDEiLCJlbmRfZGF0ZSI6IjIwMTQwNzAxIiwicG9zX2lkIjoiODg1MDAzMTAiLCJzb3VyY2UiOiJhcHBrZXkiLCJjdXN0b21lcl9pZCI6IjM3MDExMjEwNzQ2NyIsImFjY2Vzc190b2tlbiI6IiJ9\",\"begin_date\":\"20140601\",\"mac\":\"123\",\"pos_id\":\"88500310\",\"customer_id\":\"370112107467\",\"access_token\":\"\"}",
            LAST);

