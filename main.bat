:: 作者：flyrayrain
:: 日期：20151021 
:: 文件类型：BAT文件 

@echo off 
for /l %%i in (1,1,255) do ( 
     ping 192.168.1.%%i -n 1 
     if errorlevel 1 goto 不在线 
     if errorlevel 0 goto 建立IPC连接 

:不在线 
echo 192.168.1.%%i is offline 
goto 结束 

:建立IPC连接 
net use z:\\192.168.1.1%%i\c$ "" /user:"Administrator" 
If errorlevel 1 goto 连接失败 
If errorlevel 0 goto 拷贝参数文件 

:拷贝参数文件 
copy 成绩.dbf z:\Program Files\Titan\中行技能测试2014版\ /y 
If errorlevel 1 goto 成绩数据库拷贝失败 
copy param.cfg z:\Program Files\Titan\中行技能测试2014版\ /y 
If errorlevel 1 goto 参数文件拷贝失败 
xcopy 62015102 z:\Program Files\Titan\中行技能测试2014版\  
If errorlevel 1 goto 题库拷贝失败 
goto 显示设置完毕 

:成绩数据库拷贝失败 
echo 192.168.1.%%i成绩数据库拷贝失败 
goto 结束 

:参数文件拷贝失败 
echo 192.168.1.%%i参数文件拷贝失败 
goto 结束 

:题库拷贝失败 
echo 192.168.1.%%i题库拷贝失败 
goto 结束 

:连接失败 
echo can’t connect with 192.168.1.%%i 
goto 结束 

:设置完毕 
echo 192.168.1.%%i has been set up >>成功设置的IP.txt 
net send 192.168.1.%%i 中行技能测评系统设置成功  
if errorlevel 1 goto 替代方案 
net use \\192.168.1.1%% /del 
goto 结束 

:替代方案 
copy 中行技能测评系统设置成功.txg z:\documents and settings\administraotr\桌面 
if errorlevel 1 echo 替代方案失败 
net use \\192.168.1.1%% /del 
goto 结束 

:结束 
) 






