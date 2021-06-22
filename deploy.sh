#!/bin/bash
msg=${1:-auto publish}


git add -A .
git commit -am "$msg"
git push origin master


rm -r public
hugo


cd ../outrunJ.github.io
mv .git ..
rm -r *
mv ../hugo-blog/public/*  .
mv ../.git .
echo runout.run > CNAME


git add -A .
git commit -am "$msg"
git push origin master


cd ../hugo-blog

