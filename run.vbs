' 创建一个WScript.Shell对象，用于执行操作系统命令和访问系统资源
Set objShell = CreateObject("WScript.Shell")

' 在当前文件夹执行以下命令
' 执行Python命令，从main模块中导入并调用shellSync函数
' 第一个参数是要执行的命令，第二个参数是窗口的显示方式，1表示显示，第三个参数是是否等待命令执行完毕，True表示等待
objShell.Run "python -c ""from main import shellSync;shellSync()""", 1, True

' 释放WScript.Shell对象，结束脚本的执行
Set objShell = Nothing

