# java
    -Dserver.port=18001
    -Deureka.client.serviceUrl.defaultZone=http://localhost:19090/eureka
    -javaagent:/opt/svc/apache-skywalking-apm-bin/agent/skywalking-agent.jar
    -Dspring.profiles.active=prod
    -Dlogging.config=classpath:logback-spring-prod.xml
# mac os 改mac
    sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z
    sudo ifconfig <intf> lladdr 00:bb:cc:dd:ee:ff 