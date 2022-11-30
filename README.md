[key-networks/ztncui]汉化及一键安装ZeroTier控制中心:

centos redhat与debain ubuntu 系列:
- 全自动安装
- 自动识别主机系统
- 自动识别主机IP,切换对应的下载节点
```
wget https://fastly.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/AutoInstall/install_zertotier_planet@v1.0.1.sh && chmod +x install_zertotier_planet@v1.0.1.sh && ./install_zertotier_planet@v1.0.1.sh 
```

在官方的仓库 [https://github.com/key-networks/ztncui.git](https://github.com/key-networks/ztncui.git) 基础上进行汉化并打包成可直接安装的linux包，包含deb格式和rpm安装包

 [点击本链接下载发行版](https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases)

相关截图：
![输入图片说明](https://cdn.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/images/0.png)
![输入图片说明](https://cdn.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/images/1.png)
![输入图片说明](https://cdn.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/images/2.png)
![输入图片说明](https://cdn.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/images/3.png)
![输入图片说明](https://cdn.jsdelivr.net/gh/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui@v1.0.0/images/4.png)

客户端替换planet
- 服务器安装完成后会在脚本执行的目录找到planet文件,例如/root下生成的planet文件
- 或者使用```/var/lib/zerotier-one```目录中的planet文件

重启服务
- linux重启Zerotier: ```service zerotier-one restart```
- win系统重启Zerotier: ```需要在服务中重启ZeroTier One这个服务```

加入自建的根服务器网络
- 客户端执行```zerotier-cli join 网络ID```, 之后就可以在web控制中心找到设备。

特别注意:安装成功后会变更服务端默认的9993端口为10802
- 初始安装成功后,``` zerotier-cli listpeers```服务端执行命令查看节点列表,如果打印出的节点列表是空的,则安装正确
- 无论是什么样的安装方法,在初始安装完成后打印出来如果有其他节点信息,都是错误的
- 自行部署的Zerotier根服务器,服务端在打印出的节点信息中,应该只显示有效连接的客户端
- 客户端替换planet文件后,在不加入自己根服务器网络的情况下, 打印出的节点列表也是空的
- 加入自己根服务器网络后```zerotier-cli listpeers```客户端执行命令查看节点信息, 如果Planet只有一个,且IP为自己服务器,则安装正确
test