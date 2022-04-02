[key-networks/ztncui]汉化及一键安装ZeroTier控制中心:

centos redhat系列安装:
```
wget https://raw.githubusercontent.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/v1.0.0/SetUpScript/zertotier_planet_redhat.sh && chmod +x zertotier_planet_redhat.sh && ./zertotier_planet_redhat.sh 
```
debain ubuntu 系列安装:
```
wget https://raw.githubusercontent.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/v1.0.0/SetUpScript/zertotier_planet_debain.sh && chmod +x zertotier_planet_debain.sh && ./zertotier_planet_debain.sh 
```

```zerotier-cli listpeers```客户端执行命令查看节点信息, 如果Planet只有一个,且IP为自己服务器,说明安装正确


在官方的仓库 [https://github.com/key-networks/ztncui.git](https://github.com/key-networks/ztncui.git) 基础上进行汉化并打包成可直接安装的linux包，包含deb格式和rpm安装包 在安装zerotier之后直接用命令安装好就是中文其他的配置与网上教程一致;

 [点击本链接下载发行版](https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases)

相关截图：
![输入图片说明](images/0.png)
![输入图片说明](images/1.png)
![输入图片说明](images/2.png)
![输入图片说明](images/3.png)
![输入图片说明](images/4.png)

服务器安装完成后会在脚本执行的目录 例如/root下生成planet文件

在客户端替换 planet文件 

重启服务 
```
service zerotier-one restart
```
客户端执行```zerotier-cli join 网络ID```, 之后就可以在web控制中心找到设备。

特别注意:安装成功后会变更服务端默认的9993端口
