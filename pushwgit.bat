@ECHO OFF
SET /P CommitMessage=Please Enter Commit Message:
git add --all
git commit -a -m "%CommitMessage%"
git push