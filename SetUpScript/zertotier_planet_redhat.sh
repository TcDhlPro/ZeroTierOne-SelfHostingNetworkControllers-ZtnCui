#!/bin/bash 
# Redhat系列自动安装zerotier 并设置的为planet服务器
# addr服务器公网ip+port
# Github海外节点脚本
 ip=`wget http://ipecho.net/plain -O - -q ; echo`
 addr=$ip/10802
 
 echo "********************************************************************************************************************"
 echo "********** Redhat系列自动安装zerotier 并设置的为planet服务器 放在root目录执行**********************************"
 curl -s https://install.zerotier.com/ | sudo bash
 
 identity=`cat /var/lib/zerotier-one/identity.public`
 echo "identity :$identity=============================================="
 yum install gcc gcc-c++ -y
 yum install git -y
 git clone https://github.com/TcDhlPro/ZeroTierOne.git
 cd ./ZeroTierOne/attic/world/
sed -i '/roots.push_back/d' ./mkworld.cpp
sed -i '/roots.back()/d' ./mkworld.cpp 
sed -i '85i roots.push_back(World::Root());' ./mkworld.cpp 
sed -i '86i roots.back().identity = Identity(\"'"$identity"'\");' ./mkworld.cpp 
sed -i '87i roots.back().stableEndpoints.push_back(InetAddress(\"'"$addr"'\"));' ./mkworld.cpp 
source ./build.sh
./mkworld
mv ./world.bin ./planet
\cp -r ./planet /var/lib/zerotier-one/
\cp -r ./planet /root
systemctl restart zerotier-one.service
wget -t 0 -c https://agent-gh.gethub.tk/https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases/download/v1.0.0/ztncui-0.8.7-1.x86_64.rpm
rpm -ivh ztncui-0.8.7-1.x86_64.rpm
cd /opt/key-networks/ztncui/
echo "HTTPS_PORT = 10801" >>./.env
secret=`cat /var/lib/zerotier-one/authtoken.secret`
echo "ZT_TOKEN = $secret" >>./.env
echo "ZT_ADDR=127.0.0.1:10802" >>./.env
echo "NODE_ENV = production" >>./.env
echo "HTTP_ALL_INTERFACES=yes" >>./.env
systemctl restart ztncui
rm -rf /root/ZeroTierOne
FILE="/var/lib/zerotier-one/local.conf"
echo ">>>>>正在初始化..."
sleep 5s
echo -e "{" > $FILE
echo -e "\t\"settings\":"{"" >> $FILE
echo -e "\t\t\"primaryPort\":"10802"" >> $FILE
echo -e "\t}" >> $FILE
echo -e "}" >> $FILE
echo
systemctl restart zerotier-one.service
echo ">>>>>初始化完成!"
echo ">>>>>注意防火墙或运营商处开放的端口 TCP:10801"
echo ">>>>>注意防火墙或运营商处开放的端口 TCP/UDP:10802"
echo ">>>>>安装成功 | https://$ip:10801 | 初始帐号:admin/初始密码:password"
echo ">>>>>Planet文件路径,两者取其一(/root/planet)(/var/lib/zerotier-one/planet)"
rm -rf /root/zertotier_planet_redhat.sh