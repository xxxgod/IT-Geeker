# 极路由4使用Shadowsocks插件（含web配置面板）

## 简介

- 本插件只是为了方便自用，基于Geewan的旧版插件修改而来，界面适配之后，在其他版本极路由测试通过（极路由4用户可以正常打开页面，但根据一个用户的反馈，默认情况下会出现页面消失，请参考文末的故障排查部分）
- 请知晓，由于极路由固件会对界面做改动，我无法保证这个插件在每一台路由器都可用（因为它本身就是修改HTML页面产生的）

  

## 注意事项

- 最近极路由发布了极4, 其基于OpenWrt的固件也做了较大幅度的升级，之前的ss插件基本上都已经无法正常使用
- 所以我在 极路由Shadowsocks家庭无痛翻墙实践 的基础上针对新的极路由官方固件做了修改，主要工作包括：
  - 升级了老旧的ss-libev到今年6月的最新版本
  - 改写了适配老版本极路由固件的web控制面板
  - 加入了自己的一些东西以及删掉自己认为没用的东西
- 为什么不用OpenWrt？嗯，我之前一直在用，然而极3用OpenWrt会出现WLAN速度缩水的问题，最终无法忍受而换回原版固件，这也是本文诞生的主要原因

## 安装方式

### Step 1. 开启极路由开发者模式

- 安装Shadowsocks插件需要开启开发者权限。

### Step 2. SSH登录极路由

- 在Windows上，你需要使用PuTTY获得SSH的功能

- 你可以下载到PuTTY，然后使用它通过SSH登录到你的极路由。

- 登录

```
    ssh root@192.168.199.1 -p 1022  #使用root帐号连接路由，端口为1022，密码为后台登陆密码
```

### Step 3. 运行脚本来安装插件

- 使用如下命令：

```
cd /tmp && curl -k -o shadow.sh https://jm33.me/files/shadow.sh && sh shadow.sh && rm shadow.sh
```

- 你会看到：

![output](https://jm33.me/img/shadow.png)

- 看一下输出信息，一切正常的话就可以去路由器管理页面开始使用了

> 你可能需要先导入Shadowsocks客户端的JSON配置文件才能看到控制面板
>
> 示例如下：

```
{
    "server":"1.1.1.1",
    "server_port":80,
    "password":"password",
    "method":"aes-256-cfb"
}
```

![hiwifi](https://jm33.me/img/hwf.png)

![ss_hiwifi](https://jm33.me/img/hwf_ss.png)

## hosts自动更新脚本

- 使用前请先安装极路由的自定义hosts插件

- 如果你做完了上面的工作而且可以正常使用ss，你可能还会遇到无法访问的网页，这时候你需要解决DNS污染的问题


## 备注

- 本插件目前在极路由3尝鲜版本固件（和极路由4界面相同）使用，根据我个人以及身边朋友的反馈，一切正常
- 有两例极路由4出现页面无法加载的情况，请在浏览器地址栏输入 `http://192.168.199.1/cgi-bin/turbo/;stok=8e478507f8f08085b67355d78b9d23f5/api/geewan/shadowsocks`，或者在`互联网`页面，把`/admin_web/network`改为`/api/geewan/shadowsocks`，尝试手动加载Shadowsocks管理页面
- 我不清楚你的路由器是否可以正常使用，请参照本文给出的思路自行解决异常问题