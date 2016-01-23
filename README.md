# Gentoo Overlay (Self)

Gentoo自用的overlay，没有研究怎么public出去，大家如果感兴趣的话，可以将这个仓储clone到/usr/local/，然后将文件etc_portage_repo.postsync.d_local.conf复制到对应的位置，再sync应该就可以了。

这里面的ebuild都不是我自己写的，而是在网上收录的，创作权归原来的作者所有。

同时，自己系统的使用软件也在此整理，并同步更新（如果有更改的话），供感兴趣的人参考。

## 系统的桌面贴图
![image](https://raw.githubusercontent.com/taozhijiang/gentoo_overlay/master/screen.png)

![image](https://raw.githubusercontent.com/taozhijiang/gentoo_overlay/master/screen2.png)

## 软件整理
### 内核  
gentoo的主流内核有三种：sys-kernel/gentoo-sources sys-kernel/ck-sources sys-kernel/vanilla-sources，第一种是gentoo官方打了补丁的内核，优点是menuconfig的时候配置方便，缺点是毕竟改过点东西，不是最稳定的选择；第二种是打了鸡血的内核，主要修改了cpu和硬盘的调度补丁，据说对桌面系统交互相应会好很多，缺点是更不主流；第三种是官方原版的内核，干净的很。  
我以前用ck-sources，现在用gentoo-sources。  
分区和引导方式为GPT+EFI，grub被废弃，用的sys-boot/refind帮助引导系统。  

### 驱动  
这个跟每个人的硬件有关系，基本在编译内核的时候，根据自己的情况进行相应的精简。我的电脑用的DELL的无线网卡，内核的开源驱动性能很低，换成net-wireless/broadcom-sta，性能和稳定性好了很多。  

### 系统美化
- 桌面主题  
GNOME SHELL: ZukiShell  
GTK: Numix

- 桌面图标  
Numix-Circle  

- 桌面壁纸：varitey  
这是个壁纸自动替换程序,最初出现在Ubuntu上（已收录），可以自己设置壁纸的源、自动切换的时间等参数。  

- 字体：infinality + 宋体  
在行内有一句话，高分屏用什么字体都好看，低分屏用什么字体都渣渣。都这么多年头了，手机都2K屏了，笔记本居然还是720p。低分屏字体需要优化一下，不然太难看了。下面的方案是折腾了很久感觉最耐看、最好效果的。（见图）  
安装app-eselect/eselect-infinality和media-libs/fontconfig-infinality，然后  
 ```bash sudo eselect infinality set 2 [infinality]
sudo eselect lcdfilter set 3 [infinality]
sudo eselect fontconfig disable/enable
 ```
将fontconfig中除了52-infinality.conf和65-nonlatin.conf两个enable之外，所有的conf都disable掉。  
再将你windows系统的宋体（simsun.ttc）安装到Linux系统，修改/etc/fonts/conf.d/65-nonlatin.conf，第一个字体用好看的英文字体（宋体的英文显示太难看了，我用的Liberation Sans），然后跟中文宋体（NSimSun），这样在显示的时候，英文会优先使用第一个字体，然后遇到中文没法显示的时候，用下面的宋体显示。然后你GNOME中所有的字体都设置成Liberation Sans就可以了。

- GNOME SHELL插件扩展：  
Applications Menu  
Battery percentage  
Caffeine  
Clipboard indicator  
Dash to dock  
Focus my window  
Freon  
Frippery move clock  
Frippery panel favorites  
Impatience  
Input method panel  
Lock keys  
Native window placement  
Panel-docklet v18  
Recent(item)s  
Refresh wifi connections  
Removable drive menu  
Show desktop button  
Status area horizontal spacing  
Suspend button  
Topicons  
Turn off display  


### 应用软件  
- 文档编辑类: sublime wiznote  
sublime据说很牛逼，不过我只是当notepad++来用了，很惭愧。
wiznote是一个良心跨平台的笔记解决方案。可能evernote最有名，不过Linux官方没有支持的版本，第三方版本懒得折腾，就选wiznote了。  

- 输入法类：fcitx + sogou拼音  
以前都是fcitx+sunpinyin的，感觉fcitx打起字来反应比ibus、scim要快不少。得益于深度和各大软件厂商的合作，sogou拼音支持Linux版本的，这里已经收录了，用的是闭源的fcitx扩展，感觉打字准确度确实要好不少。  

- 开发类  
python：Wing IDE  
确实是一个IDE，可以调试、断点、单步运行、查看变量等，方便Python开发。  

C/C++：SlickEdit  
据说是最贵的编辑器（其实是个IDE），自动补全，很多配置选项。  

- 网络类  
浏览器：chrome、firefox  
虽然chrome是最吃资源的，狂占内存，但是作为越来越流行的浏览器是不可否认的。缺点是没法同步，大家都懂得，作为人家说“不扩展不chrome”，就介绍一下自己用的chrome插件吧  
chromeIPass: KeePass的扩展，见[这篇文档](http://blog.freesign.net/2015/08/29/%E4%B8%AA%E4%BA%BA%E5%AF%86%E7%A0%81%E7%AE%A1%E7%90%86%E5%99%A8KeePass/)   
Flickr Tab: 每打开一个chrome tab，都会有个新的背景壁纸  
Google 类似网页: 展现当前相似网页，没怎么用  
Neat Bookmarks：屏幕太小，标签栏不够用，这个用起来很紧凑，节省空间  
Proxy SwitchyOmega：科学上网的人都知道，不解释  
保护眼睛：很赞，自动把你访问的网页转换成“绿豆糕色”  
百度网盘助手 + YAAW for Chrome：可以调用aria2后台下载，还没研究透  
阅读模式：排除页面干扰，让你专心阅读网页内容  

网盘：Dropbox  
行业老大，不解释。虽然百度网盘也有Linux客户端，但是不想把重要的东西给他保管。  

Twitter：proxychains + corebird  
proxychains这个工具不错，可以为不支持代理设置的软件提供代理服务。  
Twitter的客户端有好几个，但是这个corebird用起来感觉不错！  

- 虚拟机类  
Virt-Manager + Qemu + KVM  
Linux虚拟机基本就上面方案+VirtualBox+VMware。图省事可以用后面两种，我用第一种，感觉速度还是不错的，本身qemu的启动参数有一大堆，喜欢研究的可以慢慢去考究，特别对做开发的，qemu可以很方便的满足各种需求。因为现在研究方向的原因，不折腾了，所以我就直接用Virt-Manager前端管理虚拟机了。  
对于Windows虚拟机的话，推荐spice插件，可以用spicy连接运行的虚拟机，支持任意大小的窗口分辨率，效果很赞！  

- 游戏  
games-action/supertuxkart  
steam CS-GO...  
