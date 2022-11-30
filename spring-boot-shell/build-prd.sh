# 本地快速重启远程服务。用于调试。
#!/bin/bash
# mac安装sshpass，一件登录远程服务器，无需输入密码
#sshpass -p [替换为服务密码] ssh root@[替换为服务器ip地址] > /dev/null 2>&1 << eeooff
sshpass -p [替换为服务密码] ssh root@[替换为服务器ip地址] << eeooff
cd /www/spring-boot-shell
git checkout .
git pull
# 编译jar包（忽略test）
./gradlew build -x test
# 重启进程
chmod 777 ./start-up.sh
./start-up.sh
exit
eeooff
echo done! at `date "+%Y-%m-%d %H:%M:%S"`
