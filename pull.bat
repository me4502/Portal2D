@ECHO OFF
"..\..\PortableApps\Git\bin\git.exe" fetch origin
"..\..\PortableApps\Git\bin\git.exe" rebase origin/master
pause