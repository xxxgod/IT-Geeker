## 1.更换安装源

termux-change-repo

pkg update

安装常用软件

pkg install vim curl wget tree -y 

## 2.授予权限,创建链接

### 2.1授予termux读取文件的权限

输入命令等一会就会跳出来，允许之后输入ls就发现多了一个storage文件夹，storage里面的各个文件夹分别指向手机的各个文件夹其中shared是指向内部存储的根目录

termux-setup-storage

### 2.2创建软连接

创建软连接的目的是为了方便之后的使用，如果没有软连接就要多输好多来完成对文件的操作

在这里，我在手机的根目录创建1/file文件，方便寻找嘛

ln -s storage/shared/1/file/ file
输入ls -l就会发现多了一个映射文件file

### 2.3创建ssh连接

因为使用手机操作确实不是太方便，这里安装openssh电脑连接进行操作，当然只使用手机也可以,只是建议

安装openssh

pkg install openssh -y

设置密码，输入密码的时候是看不见的，需要输入两遍密码

passwd

然后ifconfig获取ip地址，whoami获取用户名
这里推荐电脑给手机开热点，或者电脑手机同时连上一个wifi，或者使用内网穿透或者…然后才能使用电脑进行连接，打开手机的wifi也可以查看ip
然后就可以在电脑进行连接

### 2.4Xshell连接

手机启动ssh

sshd &

开始连接


有电脑的就可以在电脑看大屏进行之后的操作，没电脑还是继续使用手机弄吧

可以不使用，只是记录一下
设置自启动的
pkg install termux-services
sv-enable sshd
termux的root权限有两种方法
1.手机没有root，利用proot模拟root
pkg install proot
termux-chroot #进入root
exit #退出
2.手机已经root，可以安装tsu
pkg install tsu
tsu #进入root
exit #退出

## 3.下载jdk

jdk可以自己官网下载需要的版本，也可以是用推荐下载

3.1命令下载
因为我想用jdk1.8然后…

1.查询官方提供的JDK

pkg search jdk

会列出可以下载的jdk，下面就一个openjdk-17

2.安装JDK

pkg install openjdk-17

3.验证是否安装成功

java -version

3.2官网下载
不想去登录账号下载的看这里，我之下载了jdk-8u341-linux-aarch64.tar.gz版本，下载没限速，网速快，几秒就下完了
jdk-8u341-linux-aarch64.tar.gz，点击这里去下载，密码为1234

3.2.1将jdk放到termux
下载完之后将安装包传输到手机里面，放到根目录/1/file文件夹下
cp是复制，mv是移动

cp file/jdk-8u341-linux-aarch64.tar.gz ~
mv file/jdk-8u341-linux-aarch64.tar.gz ~

3.2.2解压jdk
解压jdk并且删除，如果不想删除就把&&和之后的代码去掉即可

tar -zxvf jdk-8u341-linux-aarch64.tar.gz && rm -rf jdk-8u341-linux-aarch64.tar.gz
进入解压之后的目录

cd jdk1.8.0_341

输入pwd获取路径
路径为：/data/data/com.termux/files/home/jdk1.8.0_341

先进行安装linux，之后把环境放到linux里面
