# 框架编写

# 命令
git update-index --assume-unchanged a
mvn clean deploy -P keruyun -pl alsc-item-solution-kryun-dish-client -DskipTests

# 阿里云搜索词
## 大屏
* and __tag__:__path__: "/data/app/jncloud/screen/log/info.log"  and resourceMap and {7435ca87-1c8c-4c76-bcfd-6f45b9c8b167}

## 时长请求
__tag__:__path__:/var/log/nginx/access.log and upstream_response_time > 1 | select distinct request_uri , count(request_uri) as "count", max(upstream_response_time) as max_time, min(upstream_response_time) as min_time, avg(upstream_response_time) as avg_time from log group by request_uri order by count desc

## IP分布
 __tag__:__path__:/var/log/nginx/access.log | select count(1) as c, ip_to_province(remote_addr) as address group by address order by c desc limit 100 
 __tag__:__path__:/var/log/nginx/access.log | select count(1) as c, remote_addr, ip_to_province(remote_addr) as address group by remote_addr order by c desc limit 100 

## PV、UV
__tag__:__path__:/var/log/nginx/access.log not request_uri:  "/stub_status" |
select
  time_series(__time__, '2m', '%H:%i', '0') as time,
  COUNT(1) as pv,
  approx_distinct(remote_addr) as uv
GROUP by
  time
ORDER by
  time
LIMIT
  1000

## 流量
__tag__:__path__:/var/log/nginx/access.log not request_uri:  "/stub_status" |
select
  sum(body_bytes_sent) / 1024 as net_out,
  sum(request_length) / 1024 as net_in,
  date_format(date_trunc('hour', __time__), '%m-%d %H:%i') as time
group by
  date_format(date_trunc('hour', __time__), '%m-%d %H:%i')
order by
  time
limit
  10000

## 地址排名
 __tag__:__path__:/var/log/nginx/access.log not request_uri:  "/stub_status" |
select
  split_part(request_uri, '?', 1) as path,
  count(1) as pv
group by
  path
order by
  pv desc
limit
  10

## tomcat状态
__tag__:__path__:/var/log/nginx/access.log not request_uri:  "/stub_status" |
select
  date_format(date_trunc('minute', __time__), '%H:%i') as time,
  COUNT(1) as count,
  status
GROUP by
  time,
  status
ORDER by
  time
LIMIT
  1000

# snip

# sql