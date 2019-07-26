#!/bin/bash

git add -A .
git commit -am 'auto publish'
git push origin master

rm -r public
hugo
cd ../outrunJ.github.io
mv .git ..
rm -r *
mv ../hugo-blog/public/*  .
mv ../.git .
git add -A .
git commit -am 'auto publish'
git push origin master
cd ../hugo-blog