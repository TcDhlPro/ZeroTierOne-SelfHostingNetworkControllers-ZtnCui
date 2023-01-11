### [key-networks/ztncui]汉化及一键安装ZtnCui控制器 - ZeroTier根节点服务端:
---

# 适配Debian10.10:
- 全自动安装
- 自动识别主机系统
- 自动识别主机IP,切换对应的下载节点

# 注意事项及参考:
- 建议用个干干净净的Debian10系统进行安装 ZtnCui控制器 - 根节点服务端
- 测试用的服务器系统为: Debian10.10 64位
- 提供的一键安装脚本只做了适配Debian10系统
- 如果想用Centos, 请自行解决环境搭建相关的问题
  - 程序名: [ztncui-0.8.6-1.x86_64.rpm](https://agent-github.08w80.com/https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases/download/v1.0.0/ztncui-0.8.6-1.x86_64.rpm)
  - 证书名: [RPM-KEY-TcDhlProForZtnCui@20230110](https://agent-github.08w80.com/https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases/download/v1.0.0/RPM-KEY-TcDhlProForZtnCui@20230110)
- <s>新版本的ZtnCui控制器完全汉化, 会在空闲时间慢慢完成</s>
- 汉化已完成 !

# 安装步骤
- 进入目录: 
```shell 
cd ~
```
- 下载脚本: 
```shell
wget https://agent-github.08w80.com/https://github.com/TcDhlPro/ZeroTierOne-SelfHostingNetworkControllers-ZtnCui/releases/download/v1.0.0/Auto_Install_ZtncuiForZerotier.tar.gz
```
- 解包: 
```shell
tar -zxvf Auto_Install_ZtncuiForZerotier.tar.gz
```
- 给脚本文件夹权限: 
```shell 
chmod -R 775 Auto_Install_ZtncuiForZerotier
```
- 进入目录: 
```shell 
cd /root/Auto_Install_ZtncuiForZerotier
```
- 启动脚本进行自动化安装: 
```shell 
./Auto_Install_ZtncuiForZerotier
```
- 初次安装时, 脚本一般都会在倒计时后, 主动断开ssh连接, 会有提示, 是为了重新配置环境
- 断开ssh连接后, 重新连接服务器
  - 进入目录```cd /root/Auto_Install_ZtncuiForZerotier```
  - 运行脚本```./Auto_Install_ZtncuiForZerotier```
- 会有一小段时间配置环境......
- 终端会提示你输入两个自定义端口```[ZtnCui的Https端口] [ZeroTier的TCP/UDP端口]```
  - 输入```3000```以外未占用的端口, 因为3000端口是被默认用作ZtnCui-Http
- 要记得在防火墙放开```[ZtnCui的Http端口]```或```[ZtnCui的Https端口]```和```[ZeroTier的TCP/UDP端口]```
- 等安装完成, 访问ZtnCui后台地址进行查看

在官方仓库 [key-networks/ztncui](https://github.com/key-networks/ztncui.git) 基础上进行汉化并打包成可直接安装的linux包，包含deb和rpm格式(附带了证书RPM-KEY-TcDhlProForZtnCui)的软件包

---
## 新版ZtnCui(0.8.6)控制器相关截图(汉化完成度98%)：
 - 编辑日期: 2023年01月10日
 - 98%是因为有些没必要汉化

![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_5.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_6.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_7.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_8.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_9.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_10.png)
## 新版ZtnCui(0.8.6)控制器相关截图(未完全汉化阶段)：
 - 编辑日期: 2022年

![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_1.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_2.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_3.png)
![输入图片说明](https://cdn-jsdelivr-agent-github.08w80.com/gh/TcDhlPro/blog_res/ZtnCui-images/ztncui086zh_ch_4.png)

---

### 客户端替换Planet文件
- 服务器安装完成后会在脚本执行的目录找到planet文件,例如/root下生成的planet文件
- 或者使用```/var/lib/zerotier-one```目录中的planet文件

### 重启服务
- linux重启Zerotier: ```service zerotier-one restart```
- win系统重启Zerotier: ```需要在服务中重启ZeroTier One这个服务```

### 加入自建的根节点网络
- 客户端执行```zerotier-cli join 网络ID```, 之后就可以在web控制中心找到设备。

### 特别注意:安装成功后会变更ZeroTier默认的9993端口为你自己设定的端口
- 初始安装成功后,``` zerotier-cli listpeers```服务端执行命令查看节点列表,如果打印出的节点列表是空的,则安装正确
- 无论是什么样的安装方法,在初始安装完成后打印出来如果有其他节点信息,都是错误的
- 自行部署的Zerotier根服务器,服务端在打印出的节点信息中,应该只显示有效连接的客户端
- 客户端替换planet文件后,在不加入自己根服务器网络的情况下, 打印出的节点列表也是空的
- 加入自己根服务器网络后```zerotier-cli listpeers```客户端执行命令查看节点信息, 如果Planet只有一个,且IP为自己服务器,则安装正确.