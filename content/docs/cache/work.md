

mosquitto_pub -h localhost -p 1883 -t 'gateway' -m '{"id":"M4XcVGQDs1O2ZX2xX2NgDK2NdlyWPw4","deviceID":"ea1","status":10,"type":301,"kind":0,"content":"ewoJImhvc3QiOgl7CgkJImFyY2giOgkiQ29ydGV4LUE3IiwKCQkiaXAiOgkiMTkyLjE2OC4wLjEzMCIsCgkJIm1hYyI6CSI5YzpiNjpkMDowMDowMDowMSIsCgkJInNvZnR3YXJlIjoJIlYxLjAiLAoJCSJoYXJkd2FyZSI6CSJWMS4wIiwKCQkib3MiOgkiVGluYVYyLjIiCgl9Cn0="}' 
mosquitto_pub -h localhost -p 1883 -t 'gateway' -f  a.json
mosquitto_pub -h 101.132.195.113 -p 32003 -t 'gateway' -f  a.json

mosquitto_pub -h 101.132.195.113 -p 32003 -t 'gateway' -m '{"id":"M4XcVGQDs1O2ZX2xX2NgDK2NdlyWPw4","deviceID":"mrsipspeaker0001","status":10,"type":30300,"kind":0}'
mosquitto_pub -h 101.132.195.113 -p 32003 -t 'device/mrsipspeaker0001/deliver' -f  




mosquitto_sub -h localhost -p 1883 -t 'device/ea1'
