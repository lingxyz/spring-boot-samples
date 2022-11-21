# 本地快速重启远程服务。用于调试。
#!/bin/bash
# mac安装sshpass，一件登录远程服务器，无需输入密码

sshpass -p [替换为服务密码] ssh root@[替换为服务器ip地址] << eeooff
cd /www/spring-boot-shell
git checkout .
git pull
# 结束原本的8081进程
kill -9 `netstat -lnp|grep 8080 |awk '{print $7}' |awk -F '/' '{print $1}'`
# 通过gradle快速启动，用于调试（无需编译jar包）
./gradlew bootrun --args='--spring.profiles.active=test'
exit
eeooff
echo done! at `date "+%Y-%m-%d %H:%M:%S"`
