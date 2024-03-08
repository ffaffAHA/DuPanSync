## 在原作者的基础上做了小的修复

### 补充了Windows桌面快捷方式，添加了.vbs文件。

# Windows利用.vbs运行,添加如下
   ' 创建一个WScript.Shell对象，用于执行操作系统命令和访问系统资源
   Set objShell = CreateObject("WScript.Shell")

   ' 在当前文件夹执行以下命令
   ' 执行Python命令，从main模块中导入并调用shellSync函数
   ' 第一个参数是要执行的命令，第二个参数是窗口的显示方式，1表示显示，第三个参数是是否等待命令执行完毕，True表示等待
   objShell.Run "python -c ""from main import shellSync;shellSync()""", 1, True

   ' 释放WScript.Shell对象，结束脚本的执行
   Set objShell = Nothing


使用Windows任务计划程序，创建一个定时任务，指定要运行的脚本文件和执行的时间。例如，如果您想要每天早上8点运行一个名为test.vbs的脚本，您可以按照以下步骤操作：

###定时1
###cmd运行
   schtasks /create /tn test_task /tr ‪E:\VSCodePython\DuPanSync\run.vbs - 快捷方式.lnk /sc DAILY /st 08:00:00
###或
打开控制面板，选择系统和安全，然后选择管理工具。
双击任务计划程序，点击操作栏上的创建基本任务。
输入任务的名称和描述，例如test，然后点击下一步。
选择任务的触发器，例如每天，然后点击下一步。
输入任务的开始日期和时间，例如2021年12月1日，8:00:00，然后点击下一步。
选择任务的操作，例如启动程序，然后点击下一步。
输入或浏览要运行的脚本文件的路径，例如C:\run.vbs，然后点击下一步。
查看任务的摘要，然后点击完成。

# TODO
- [ ] 同步（现在只能设置同步的目录，设置时会自动保存一次）
- [ ] 定时任务自动执行
- [ ] 新文件同步提醒
- [ ] iOS快捷指令（或许会做）
- [ ] token失效2个月 ,并添加了失效提醒。
