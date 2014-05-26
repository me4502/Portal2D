read -p "Please Enter Commit Message:" commitmessage
git add --all
git commit -m '$commitmessage'
git push
read