# Gentoo Overlay (Self)

Gentoo自用的overlay，没有研究怎么public出去，大家如果感兴趣的话，可以将这个仓储clone到/usr/local/，然后将文件etc_portage_repo.postsync.d_local.conf复制到对应的位置，再sync应该就可以了。

这里面的ebuild都不是我自己写的，而是在网上收录的，创作权归原来的作者所有。

同时，自己系统的使用软件也在此整理，供感兴趣的人参考

## 系统的桌面贴图
![image](https://raw.githubusercontent.com/taozhijiang/gentoo_overlay/master/screen.png)

![image](https://raw.githubusercontent.com/taozhijiang/gentoo_overlay/master/screen2.png)

## 软件整理
### 内核  
gentoo的主流内核有三种：sys-kernel/gentoo-sources sys-kernel/ck-sources sys-kernel/vanilla-sources，第一种是gentoo官方打了补丁的内核，优点是menuconfig的时候配置方便，缺点是毕竟改过点东西，不是最稳定的选择；第二种是打了鸡血的内核，主要修改了cpu和硬盘的调度补丁，据说对桌面系统交互相应会好很多，缺点是更不主流；第三种是官方原版的内核，干净的很。  
我以前用ck-sources，现在用gentoo-sources。  

### 驱动  
这个跟每个人的硬件有关系，基本在编译内核的时候，根据自己的情况进行相应的精简。我的电脑用的DELL的无线网卡，内核的开源驱动性能很低，换成net-wireless/broadcom-sta，性能和稳定性好了很多。  

### 系统美化
- 桌面主题  
GNOME SHELL用的
GTK用的

- 桌面图标  
- 桌面壁纸  
- 字体  

### 应用软件  
- 文档编辑类  
sublime 

- 

