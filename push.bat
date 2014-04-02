@ECHO OFF
SET /P CommitMessage=Please Enter Commit Message:
"..\..\PortableApps\Git\bin\git.exe" add --all
"..\..\PortableApps\Git\bin\git.exe" commit -a -m "%CommitMessage%"
"..\..\PortableApps\Git\bin\git.exe" push