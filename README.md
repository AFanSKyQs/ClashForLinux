# Linux系统Clash一键部署教程

此项目是通过使用开源项目[clash](https://github.com/Dreamacro/clash)作为核心程序，再结合脚本实现简单的代理功能。

主要是为了解决我们在服务器上下载GitHub等一些国外资源速度慢的问题。
<br>

# 使用教程

### 1、下载项目


```bash
git clone https://github.com/AFanSKyQs/ClashForLinux.git
```

### 2、进入目录
```bash
cd ClashForLinux
```
### 3、运行脚本启动。
```bash
bash StartRun.sh
```
### 4、粘贴你的订阅地址、回车
>Shift+Insert粘贴  或者  Ctrl+V确认

## ！！！重点

>建议结合`ftp软件`或者直接`vim`查看`ClashForLinux/conf/config.yaml`配置文件内是否有订阅节点信息
>>现在大部分机场的订阅链接都是加密了的，所以配置文件里面并没有得到节点信息

## ！如果没有节点信息该怎么办
>1、前往：https://clash.back2me.cn/ <br>
> 2、填入你的订阅链接`（确保你链接原本就可用）` <br>
> 3、[`客户端`、`后端地址`、`远程配置`]都默认第一个即可，`FileName`随便输，其余不用填
> <br>4、点击下面的:`生成订阅链接`
> <br>5、复制这个链接，重新运行步骤【3】脚本，粘贴这个链接，回车
<br>
### 然后就会全自动启动代理



## 远程设置节点

- 访问 Clash Dashboard

通过浏览器访问 `start.sh` 执行成功后输出的地址，例如：http://192.168.0.1:9090/ui

- 登录管理界面

在`API Base URL`一栏中输入：http://IP:9090 ，在`Secret(optional)`一栏中输入启动成功后输出的Secret。

点击Add并选择刚刚输入的管理界面地址，之后便可在浏览器上进行一些配置。

- 更多教程

此 Clash Dashboard 使用的是[yacd](https://github.com/haishanh/yacd)项目，详细使用方法请移步到yacd上查询。



## 以后启动
### 如果要设置新链接直接重新运行【3】的脚本即可
- 进入项目目录

```bash
$ cd ClashForLinux
```

- 运行启动脚本

```bash
$ sudo sh start.sh

正在检测订阅地址...
Clash订阅地址可访问！                                      [  OK  ]

正在下载Clash配置文件...
配置文件config.yaml下载成功！                              [  OK  ]

正在启动Clash服务...
服务启动成功！                                             [  OK  ]

Clash Dashboard 访问地址：http://IP:9090/ui
Secret：xxxxxxxxxxxxx

请执行以下命令加载环境变量: source /etc/profile.d/clash.sh

请执行以下命令开启系统代理: proxy_on

若要临时关闭系统代理，请执行: proxy_off

```

```bash
$ source /etc/profile.d/clash.sh
$ proxy_on
```

- 检查服务端口

```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```

- 检查环境变量

```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```

以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。

<br>

### 重启程序

如果需要对Clash配置进行修改，请修改 `conf/config.yaml` 文件。然后运行 `restart.sh` 脚本进行重启。

> **注意：**
> 重启脚本 `restart.sh` 不会更新订阅信息。

<br>

### 停止程序

- 进入项目目录

```bash
$ cd ClashForLinux
```

- 关闭服务

```bash
$ bash shutdown.sh

服务关闭成功，请执行以下命令关闭系统代理：proxy_off

```

```bash
$ proxy_off
```

然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。


<br>

# 常见问题

1.部分Ubuntu系统默认的 shell `/bin/sh` 被更改为 `dash`，运行脚本会出现报错。建议使用 `bash xxx.sh` 运行脚本。


