# 本地快速重启远程服务。用于调试。
#!/bin/bash
# mac安装sshpass，一件登录远程服务器，无需输入密码
#sshpass -p [替换为服务密码] ssh root@[替换为服务器ip地址] > /dev/null 2>&1 << eeooff
sshpass -p [替换为服务密码] ssh root@[替换为服务器ip地址] << eeooff
cd /www/spring-boot-shell
git checkout .
git pull
# 结束原本的8081进程
kill -9 `netstat -lnp|grep 8081 |awk '{print $7}' |awk -F '/' '{print $1}'`
# 用于调试
#./gradlew bootrun --args='--spring.profiles.active=prd'
# 用于正式部署：编译jar包（忽略test）
./gradlew build -x test
# nohup进程守护方式部署。日志输出到本地./log文件夹
nohup java -jar ./build/libs/demo-0.0.1-SNAPSHOT.jar --spring.profiles.active=prd >> ./log/nohup`date +%Y-%m-%d`.out 2>&1 &
exit
eeooff
echo done! at `date "+%Y-%m-%d %H:%M:%S"`
