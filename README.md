## 在原作者的基础上做了小的修复

## 补充了Windows桌面快捷方式，添加了.vbs文件。

# Windows利用.vbs运行,添加如下

      ' 创建一个WScript.Shell对象，用于执行操作系统命令和访问系统资源
      Set objShell = CreateObject("WScript.Shell")
      
      ' 在当前文件夹执行以下命令
      ' 执行Python命令，从main模块中导入并调用shellSync函数
      ' 第一个参数是要执行的命令，第二个参数是窗口的显示方式，1表示显示，第三个参数是是否等待命令执行完毕，True表示等待
      objShell.Run "python -c ""from main import shellSync;shellSync()""", 1, True
      
      ' 释放WScript.Shell对象，结束脚本的执行
      Set objShell = Nothing
# 定时1
## cmd运行
      schtasks /create /tn test_task /tr ‪E:\VSCodePython\DuPanSync\run.vbs - 快捷方式.lnk /sc DAILY /st 08:00:00
### 或
-打开控制面板，选择系统和安全，然后选择管理工具。

-双击任务计划程序，点击操作栏上的创建基本任务。

-输入任务的名称和描述，例如test，然后点击下一步。

-选择任务的触发器，例如每天，然后点击下一步。

-输入任务的开始日期和时间，例如2021年12月1日，8:00:00，然后点击下一步。

-选择任务的操作，例如启动程序，然后点击下一步。

-输入或浏览要运行的脚本文件的路径，例如C:\run.vbs，然后点击下一步。

-查看任务的摘要，然后点击完成。

# TODO
- [ ] 同步（现在只能设置同步的目录，设置时会自动保存一次）
- [ ] 定时任务自动执行
- [ ] 新文件同步提醒
- [ ] iOS快捷指令（或许会做）
- [ ] token失效2个月 ,并添加了失效提醒。

# 度盘群文件同步工具

本程序所有操作均基于百度网盘web端API操作

## 使用条件

1. 由于程序使用到了`selenium`技术，所以需要系统安装Chrome浏览器，同时项目根目录中的`chromedriver`文件需要与Chrome版本对应，可以在[官方网站](http://chromedriver.storage.googleapis.com/index.html)或[阿里云镜像](https://registry.npmmirror.com/binary.html?path=chromedriver/)下载
2. 安装有`python3`环境，作者使用的python3.9环境
3. 会看本文档

## 使用方法

### 电脑(macOS/Windows)

1. 把本项目拉到本地
2. 安装对应版本的chromedriver
   - 本项目使用的是macOS版Chrome 109.0.5414.87适配的chromedriver
3. 安装相关库
   ```shell
    pip install -r requirements.txt
    ```
4. 设置通知
   - 修改位置为[config.json](./config.json)
   - 邮箱密码是在对应邮箱设置里申请的授权码
5. 运行`main.py`
   ```shell
   # 有些人可能是python3 main.py
   python main.py
    ```
6. 根据命令行中的提示进行选择（主要懒得再做个页面）
7. 第一次登录时如果扫不了控制台的二维码就去扫保存到本地的二维码图片
   - 默认地址在`/temp/login.png`
   - `config.json`里的`qrCodeImagePath`可以改默认保存
   - 添加补充说明：在日志里找到二维码链接，CTRL+鼠标左键进入浏览器扫码登录。
8. 设置好后可以使用下面的命令直接执行同步方法，不显示操作菜单
   ```shell
   python -c "from main import shellSync;shellSync()"
   ```
   - 使用此命令可以方便的设置crontab，iOS快捷指令的SSH模块等方式进行操作

### 树莓派(arm64架构的Ubuntu系统)

1. ssh连接树莓派
2. 把项目放到本地（也可以直接用ftp, smb, sftp等方式直接复制过去）
   ```shell
   git clone https://gitee.com/tippy_q/du-pan-sync.git
   ```

3. 配置树莓派selenium环境
   1. 下载安装包, 作者这里使用的是`90.0.4430.72`版本，可以到[Launchpad.net](http://ports.ubuntu.com/pool/universe/c/chromium-browser/)查找下载其他版本，需要注意这三个版本号一定要一致
      ```shell
      # 下载chromium-browser
      wget 'http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-browser_90.0.4430.72-0ubuntu0.16.04.1_arm64.deb'
      # 下载chromium-codecs-ffmpeg-extra
      wget 'http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_90.0.4630.72-0ubuntu0.16.04.1_arm64.deb'
      # 下载chromium-chromedriver
      wget 'http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-chromedriver_90.0.4430.72-0ubuntu0.16.04.1_arm64.deb'
      ```
      
   2. 安装，顺序是`chromium-codecs-ffmpeg-extra`–>`chromium-browser`->`chromium-chromedriver`
      ```shell
      # chromium-codecs-ffmpeg-extra
      sudo dpkg -i chromium-codecs-ffmpeg-extra_90.0.4430.72-0ubuntu0.16.04.1_arm64.deb
      # chromium-browser
      sudo dpkg -i chromium-browser_90.0.4430.72-0ubuntu0.16.04.1_arm64.deb
      # chromium-chromedriver
      sudo dpkg -i chromium-chromedriver_90.0.4430.72-0ubuntu0.16.04.1_arm64.deb
      ```
      
   3. 更新`apt`包管理器，可以忽略这步，我更新时树莓派卡死就直接跳过了
      ```shell
      sudo apt update
      sudo apt upgrade
      ```
      
   4. 验证,只要出来版本号了就算成功了
      ```shell
      # 查看chromedriver版本
      chromedriver -v
      # 查看chromium版本
      chromium-browser -version
      ```
   5. 树莓派selenium教程参考[树莓派安装高版本Chromium和Chromedriver](https://blog.csdn.net/weixin_43890033/article/details/122313492)
4. 进入项目文件夹
   ```shell
   cd du-pan-sync
   ```
5. 安装python包
   ```shell
   pip install -r requirements.txt
   ```

6. 执行程序
   ```shell
   python main.py
   ```

7. 如果需要直接执行更新命令或者设置`crontab`可以使用下面的命令
   - `cd`后面的路径是自己项目存放的路径 
   ```shell
   cd /home/pi/du-pan-sync && python -c "from main import shellSync;shellSync()"
   ```
   
8. 如果出现报错是`Permission denied`开头的，请给项目文件夹下所有文件权限,最后面是项目路径
   ```shell
   sudo chmod -R 777 ./du-pan-sync
   ```
   
## 设置定时执行

### Linux/macOS

1. 部署好项目确保可以运行
2. 编辑`crontab`定时任务列表
   ```shell
   crontab -e
   ```
3. 在文件最下面添加一行
   ```shell
   # min hour day mon year command
   10    8-22  *   *   *   cd /home/pi/du-pan-sync && python -c "from main import shellSync;shellSync()"
   ```
   - ![crontab](./temp/crontab.png)
   - 这个定时会在 8:10,9:10,10:10···22:10 执行，可以根据自己的需求更改
4. 关闭`crontab`
   - 按`Ctrl`+`X`
   - 根据提示按`Y`和回车键
5. 可以通过`logs`文件夹下的log文件判断有没有执行

### Windows

百度[定时任务使用方法](https://blog.csdn.net/weixin_46279624/article/details/127221744)

# TODO
- [x] 同步（现在只能设置同步的目录，设置时会自动保存一次）
- [x] 定时任务自动执行
- [x] 新文件同步提醒
- [ ] iOS快捷指令（或许会做）

# Others
1. 关于订阅功能
   - 由于没有可视化界面不太方便在UI上控制订阅列表，所以只能手动编辑[sub.json](./temp/sub.json)文件，`notice`内容写法同[config.json](./config.json)的`notice`
   - `path`的内容与[sync.json](./temp/sync.json)中的`path`对应，不过可以用正则表达式，要确保正则匹配时可以在开头匹配到
     - 如[sync.json](./temp/sync.json)中有一项的`path`是`/2024一研为定/02.2024考研英语`，我想同步这里面的`/2024一研为定/02.2024考研英语/03.【2024考研英语】田静vip班`,那么[sub.json](./temp/sub.json)中的`path`应该变成`["/2024一研为定/02.2024考研英语/03.【2024考研英语】田静vip班"]`
2. 关于邮箱通知
   - 发送邮箱始终使用[config.json](./config.json)中的内容，如果[config.json](./config.json)的`email`的`enable`为`false`，订阅中的邮箱通知也不会生效
   - 发送邮箱的密码不是登录密码，需要去对应邮箱的控制台生成授权码，[smtp使用方法](http://service.mail.qq.com/detail?search=smtp)

> 实测同步考研的5门课程总共请求了2266次百度接口
> 
> 程序占用内存（不开启http缓存的情况下）约60Mb
> 
> 运行的12分钟左右
