#!/bin/bash
# [TcDhl]-[自动识别服务器所属环境,全自动安装Zerotier并设置为Planet节点服务器]
# Edit>2022-04-26 17:53:53
#  cat /etc/redhat-release
# CentOS Linux release 7.5.1804 (Core)
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
LANG=en_US.UTF-8

echo "****************************************************"
echo "************** 脚本执行目录为cd /root **************"
echo "**************** 进行简单的初步检测 ****************"
if [ $(whoami) != "root" ];then
	echo "请使用Root权限执行!!!!！"
	exit 1;
fi
if command -v wget >/dev/null 2>&1; then 
  echo "[wget]命令检测正常!!!"
else 
  yum install wget
  apt-get install wget
fi
if command -v curl >/dev/null 2>&1; then 
  echo "[curl]命令检测正常!!!"
else 
  yum install curl
  apt-get install curl
fi
if command -v sudo >/dev/null 2>&1; then 
  echo "[sudo]命令检测正常!!!"
else 
  yum install sudo
  apt-get install sudo
fi
script_dir_first=$(cd $(dirname "${BASH_SOURCE[0]}");pwd)
cd /root

wget -t 0 -c https://ipinfo.io/json -P /root/ip_info_temp
#56ys5LiA5Liq566h6YGT5bCG5q+P6KGM55qE6YCX5Y+35Y675o6JDQrnrKzkuozkuKrnrqHpgZPljrvmjol75ZKMfQ0K56ys5LiJ5Liq566h6YGT5Y675o6J5omA5pyJ5Y+M5byV5Y+3DQrnrKzlm5vkuKrnrqHpgZPmm7/mjaLnrKzkuIDkuKo6IOS4uj3lj7cNCuesrOS6lOS4queuoemBk+WPlua2iOaJgOacieeahC0NCuesrOWFrSzkuIMs5YWr5Liq566h6YGT5Yig6Zmk5YyF5ZCrb3JnPSxyZWFkbWU9LHJlZ2lvbj3nmoTpgqPooYwNCuesrOS5neS4quWIoOmZpOavj+ihjOeahOepuuagvA==
ip_info_data=$(cat /root/ip_info_temp/json | sed -r 's/",/"/' | egrep -v '^[{}]' | sed 's/"//g' | sed 's/: /=/1' | sed 's/-//g' | sed '/org=/d' | sed '/readme=/d' | sed '/region=/d' | sed '1,5s/ //g')
declare -r $ip_info_data

sertch_centos="CentOS"
sertch_debian="Debian"
sertch_ubuntu="Ubuntu"
system_info_centos=`cat /etc/redhat-release`
system_info_debian=`cat /etc/issue`
country_cn_num=0
country_uncn_num=0
centos_redhat_num=0
debian_ubuntu_num=0
cn_add_centos_msg=">>>>>当前下载线路为适配centos系统的国内节点"
cn_add_debian_msg=">>>>>当前下载线路为适配debian系统的国内节点"
uncn_add_centos_msg=">>>>>当前下载线路为适配centos系统的海外节点"
uncn_add_debian_msg=">>>>>当前下载线路为适配debian系统的海外节点"
error_email_msg=">>>>>未能成功适配, 请截图邮件至: ybsets@gmail.com"
sleep 2s

if [ $country = "CN" ];then
	country_cn_num=1000
	country_uncn_num=0
	echo ">>>>>当前服务器所属内地IP($ip - $city)"
else
	country_cn_num=0
	country_uncn_num=2000
	echo ">>>>>当前服务器所属海外IP($ip - $city)"
fi
sleep 1s

if [[ $system_info_centos =~ $sertch_centos ]];then
	centos_redhat_num=1
	debian_ubuntu_num=0
	echo ">>>>>当前服务器系统: Centos Redhat系列"
fi
sleep 1s

if [[ $system_info_debian =~ $sertch_debian ]] || [[ $system_info_debian =~ $sertch_ubuntu ]];then
	centos_redhat_num=0
	debian_ubuntu_num=2
	echo ">>>>>当前服务器系统: Debian Ubuntu系列"
fi
echo ">>>>>检测完成,即将切换下载线路......"
sleep 2s

#5Yik5pat5LiL6L296IqC54K555qE57uT566X57uT5p6cDQrlm73lhoUtY2VudG9z6IqC54K5KDEwMDAgMTAwMSkgY27lnLDljLotY2VudG9z57O757ufPuWbveWGheS4i+i9veiKgueCuSAxMDAxDQpjb3VudHJ5X2NuX251bT0xMDAwICBjb3VudHJ5X3VuY25fbnVtPTANCmNlbnRvc19yZWRoYXRfbnVtPTEgIGRlYmlhbl91YnVudHVfbnVtPTANCuWbveWGhS1kZWJpYW7oioLngrkoMTAwMCAxMDAyKSBjbuWcsOWMui1kZWJpYW7ns7vnu58+5Zu95YaF5LiL6L296IqC54K5IDEwMDINCmNvdW50cnlfY25fbnVtPTEwMDAgIGNvdW50cnlfdW5jbl9udW09MA0KY2VudG9zX3JlZGhhdF9udW09MCAgZGViaWFuX3VidW50dV9udW09Mg0K5rW35aSWLWNlbnRvc+iKgueCuSgyMDAwIDIwMDEpIGNu5Zyw5Yy6LWNlbnRvc+ezu+e7nz7mtbflpJbkuIvovb3oioLngrkgMjAwMQ0KY291bnRyeV9jbl9udW09MCAgY291bnRyeV91bmNuX251bT0yMDAwDQpjZW50b3NfcmVkaGF0X251bT0xICBkZWJpYW5fdWJ1bnR1X251bT0wDQrmtbflpJYtZGViaWFu6IqC54K5KDIwMDAgMjAwMikgY27lnLDljLotZGViaWFu57O757ufPua1t+WkluS4i+i9veiKgueCuSAyMDAyDQpjb3VudHJ5X2NuX251bT0wICBjb3VudHJ5X3VuY25fbnVtPTIwMDANCmNlbnRvc19yZWRoYXRfbnVtPTAgIGRlYmlhbl91YnVudHVfbnVtPTI=
let "cn_add_centos=$country_cn_num+$centos_redhat_num"
let "cn_add_debian=$country_cn_num+$debian_ubuntu_num"
let "uncn_add_centos=$country_uncn_num+$centos_redhat_num"
let "uncn_add_debian=$country_uncn_num+$debian_ubuntu_num"
rm -rf /root/ip_info_temp

if [ $cn_add_centos = 1001 ];then
	echo "$cn_add_centos_msg"
	sleep 2s
	wget -t 3 https://dhlgits.gitee.io/zerotierone-selfhostingnetworkcontrollers-ztncui/SetUpScript/zertotier_planet_redhat.sh && chmod +x zertotier_planet_redhat.sh && ./zertotier_planet_redhat.sh

elif [ $cn_add_debian = 1002 ];then
	echo "$cn_add_debian_msg"
	sleep 2s
	wget -t 3 https://dhlgits.gitee.io/zerotierone-selfhostingnetworkcontrollers-ztncui/SetUpScript/zertotier_planet_debian.sh && chmod +x zertotier_planet_debian.sh && ./zertotier_planet_debian.sh

elif [ $uncn_add_centos = 2001 ];then
	echo "$uncn_add_centos_msg"
	sleep 2s
	wget -t 3 https://raw.githubusercontent.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/v1.0.0/SetUpScript/zertotier_planet_redhat.sh && chmod +x zertotier_planet_redhat.sh && ./zertotier_planet_redhat.sh

elif [ $uncn_add_debian = 2002 ];then
	echo "$uncn_add_debian_msg"
	sleep 2s
	wget -t 3 https://raw.githubusercontent.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/v1.0.0/SetUpScript/zertotier_planet_debian.sh && chmod +x zertotier_planet_debian.sh && ./zertotier_planet_debian.sh

else
	echo "$error_email_msg"
fi
cd $script_dir_first
unlink $0