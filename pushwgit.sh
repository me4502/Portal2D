read -p "Please Enter Commit Message:" commitmessage
git add --all
git commit -a -m $commitmessage
git push
read