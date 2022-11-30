# kill 8081 端口进程，并使用 nohup 进程守护重启。
# 与build-xxx.sh不写在一个脚本的原因是，远程执行复杂的shell调试麻烦，功力还不够。
#!/bin/bash

# 结束原本的8081进程
kill -9 `netstat -lnp|grep 8081 |awk '{print $7}' |awk -F '/' '{print $1}'`
# nohup进程守护方式部署。日志输出到本地./log文件夹
nohup java -jar ./build/libs/demo-0.0.1-SNAPSHOT.jar --spring.profiles.active=prd >> ./log/nohup`date +%Y-%m-%d`.out 2>&1 &
